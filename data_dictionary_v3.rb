#!/usr/bin/env ruby
########################################################
###
##  File: data_dictionary_v2.rb
##  Desc: Boot a Rails application and produce a markdown data dictionary
##        from its live database(s) and its ActiveRecord models.
##
##        With --output DIR it writes data_dictionary.md (databases, table
##        list, enum types and an index of every column across all tables),
##        one page per table, and one ERD per table plus schema.svg whose
##        boxes link to the table pages.  Without it, data_dictionary.md
##        goes to STDOUT.
##
##        From the database:  tables, views, columns, keys, indexes,
##          foreign keys, check constraints, triggers, comments, enum
##          types, extensions, row counts and sizes.
##        From the models:  associations, enums, validations, STI,
##          store accessors, attachments, encrypted and virtual attributes.
##
##        Each table's ERD shows the table in full with its parents and its
##        children collapsed to their key columns; schema.svg shows every
##        table that way. Database foreign keys are solid edges; polymorphic
##        associations the models declare (has_one/has_many ... as:) are dashed.
##        Each table page also lists the migrations that touched the table,
##        read from the database's migrations_paths (db/migrate).
##        --erd-format picks svg (default), png, pdf or dot source; the
##        rendered formats need Graphviz `dot` on the PATH.
##
##  Usage: data_dictionary_v2.rb [options] [RAILS_ROOT]
##    or:  bin/rails runner path/to/data_dictionary_v2.rb [options]
##
##  Run it with the Ruby version the application uses (cd into the
##  application first so rbenv/frum pick up its .ruby-version).
##  Requires Ruby 3.2+ and Rails 6.1+.  Only reads from the database.
#

require 'date'
require 'fileutils'
require 'pathname'
require 'optparse'

module DataDictionaryV2
  App = Data.define(:name, :root, :environment, :rails_version, :ruby_version, :databases, :models)

  Database = Data.define(:name, :adapter, :location, :server_version, :schema_version,
                         :pending_migrations, :extensions, :enums, :tables, :migrations, :error) do
    def initialize(name:, adapter: nil, location: nil, server_version: nil, schema_version: nil,
                   pending_migrations: nil, extensions: [], enums: {}, tables: [], migrations: [], error: nil)
      super
    end
  end

  Table = Data.define(:name, :kind, :comment, :primary_key, :columns, :indexes, :foreign_keys,
                      :check_constraints, :triggers, :rows, :rows_estimated, :bytes) do
    def initialize(name:, kind: 'table', comment: nil, primary_key: nil, columns: [], indexes: [],
                   foreign_keys: [], check_constraints: [], triggers: [], rows: nil,
                   rows_estimated: false, bytes: nil)
      super
    end
  end

  Column     = Data.define(:name, :sql_type, :null, :default, :comment)
  Index      = Data.define(:name, :columns, :unique, :where, :using)
  ForeignKey = Data.define(:name, :column, :to_table, :primary_key, :on_delete, :on_update)
  Constraint = Data.define(:name, :expression)
  Trigger    = Data.define(:name, :timing, :events, :action)

  # One migration file: tables maps each table it touches to the changes made
  # to it, in file order; renames lists [old_name, new_name] pairs
  Migration  = Data.define(:version, :name, :path, :tables, :renames)

  Model = Data.define(:name, :table_name, :database, :source, :sti_parent, :sti_column,
                      :associations, :enums, :validations, :stored_attributes, :attachments,
                      :encrypted_attributes, :virtual_attributes, :error) do
    def initialize(name:, table_name: nil, database: 'primary', source: nil, sti_parent: nil,
                   sti_column: nil, associations: [], enums: {}, validations: [],
                   stored_attributes: {}, attachments: [], encrypted_attributes: [],
                   virtual_attributes: [], error: nil)
      super
    end
  end

  Association = Data.define(:macro, :name, :class_name, :foreign_key, :options)
  Validation  = Data.define(:kind, :attributes, :options)


  # Reads everything it can about one database through an ActiveRecord connection
  class DatabaseInspector
    INTERNAL_TABLES = %w[schema_migrations ar_internal_metadata].freeze

    def initialize(connection, name:, root: Dir.pwd, count_rows: false, include_internal: false)
      @connection       = connection
      @name             = name
      @root             = root
      @count_rows       = count_rows
      @include_internal = include_internal
    end

    def call
      Database.new(
        name:               @name,
        adapter:            @connection.adapter_name,
        location:           location,
        server_version:     server_version,
        schema_version:     schema_version,
        pending_migrations: pending_migrations,
        migrations:         migrations,
        extensions:         extensions,
        enums:              enums,
        tables:             data_sources.map { |name, kind| table(name, kind) }
      )
    end

    def postgres? = @connection.adapter_name.match?(/postg/i)
    def sqlite?   = @connection.adapter_name.match?(/sqlite/i)

    # [[name, kind], ...] for every table and view
    def data_sources
      sources = @connection.tables.map { |name| [name, 'table'] } +
                @connection.views.map { |name| [name, materialized_views.include?(name) ? 'materialized view' : 'view'] }
      sources.reject! { |name, _| INTERNAL_TABLES.include?(name) } unless @include_internal
      sources.sort
    end

    def table(name, kind)
      Table.new(
        name:              name,
        kind:              kind,
        comment:           table_comment(name),
        primary_key:       @connection.primary_key(name),
        columns:           columns(name),
        indexes:           indexes(name),
        foreign_keys:      foreign_keys(name),
        check_constraints: check_constraints(name),
        triggers:          triggers.fetch(name, []),
        **row_stats(name, kind)
      )
    end

    def columns(table_name)
      @connection.columns(table_name).map do |c|
        sql_type = c.sql_type.to_s
        sql_type += '[]' if c.respond_to?(:array?) && c.array?
        Column.new(
          name:     c.name,
          sql_type: sql_type,
          null:     c.null,
          default:  c.default_function || c.default,
          comment:  c.respond_to?(:comment) ? c.comment : nil
        )
      end
    end

    def indexes(table_name)
      @connection.indexes(table_name).map do |i|
        Index.new(name: i.name, columns: Array(i.columns), unique: i.unique, where: i.where, using: i.using)
      end
    end

    def foreign_keys(table_name)
      return [] unless @connection.supports_foreign_keys?

      @connection.foreign_keys(table_name).map do |fk|
        ForeignKey.new(name: fk.name, column: fk.column, to_table: fk.to_table,
                       primary_key: fk.primary_key, on_delete: fk.on_delete, on_update: fk.on_update)
      end
    end

    def check_constraints(table_name)
      return [] unless @connection.respond_to?(:supports_check_constraints?) && @connection.supports_check_constraints?

      @connection.check_constraints(table_name).map { |c| Constraint.new(name: c.name, expression: c.expression) }
    end

    def table_comment(table_name)
      @connection.table_comment(table_name) if @connection.supports_comments?
    end

    def row_stats(table_name, kind)
      stats = relation_stats.fetch(table_name, {})
      rows  = stats[:rows]

      if @count_rows && kind != 'view'
        rows = @connection.select_value("SELECT COUNT(*) FROM #{@connection.quote_table_name(table_name)}").to_i
        return { rows: rows, rows_estimated: false, bytes: stats[:bytes] }
      end

      { rows: rows, rows_estimated: !rows.nil?, bytes: stats[:bytes] }
    end

    # { table_name => { rows:, bytes: } }; rows are planner estimates
    def relation_stats
      @relation_stats ||=
        if postgres? then postgres_relation_stats
        elsif sqlite? then sqlite_relation_stats
        else {}
        end
    end

    def postgres_relation_stats
      sql = <<~SQL
        SELECT c.relname AS name, c.reltuples::bigint AS rows, pg_total_relation_size(c.oid) AS bytes
          FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace
         WHERE c.relkind IN ('r', 'p', 'm') AND n.nspname = ANY (current_schemas(false))
      SQL
      @connection.select_all(sql).to_h do |row|
        rows = row['rows'].to_i
        [row['name'], { rows: rows.negative? ? nil : rows, bytes: row['bytes'].to_i }]
      end
    end

    # Needs SQLite compiled with the dbstat virtual table; sizes include indexes
    def sqlite_relation_stats
      sql = <<~SQL
        SELECT m.tbl_name AS name, SUM(d.pgsize) AS bytes
          FROM dbstat d JOIN sqlite_master m ON m.name = d.name
         GROUP BY m.tbl_name
      SQL
      @connection.select_all(sql).to_h { |row| [row['name'], { bytes: row['bytes'].to_i }] }
    rescue ActiveRecord::StatementInvalid
      {}
    end

    # { table_name => [Trigger, ...] }
    def triggers
      @triggers ||=
        if postgres? then postgres_triggers
        elsif sqlite? then sqlite_triggers
        else {}
        end
    end

    def postgres_triggers
      sql = <<~SQL
        SELECT event_object_table AS table_name, trigger_name, action_timing,
               string_agg(event_manipulation, ' OR ' ORDER BY event_manipulation) AS events,
               action_statement
          FROM information_schema.triggers
         WHERE trigger_schema = ANY (current_schemas(false))
         GROUP BY event_object_table, trigger_name, action_timing, action_statement
         ORDER BY 1, 2
      SQL
      @connection.select_all(sql).group_by { |r| r['table_name'] }.transform_values do |rows|
        rows.map { |r| Trigger.new(name: r['trigger_name'], timing: r['action_timing'], events: r['events'], action: r['action_statement']) }
      end
    end

    def sqlite_triggers
      sql = "SELECT tbl_name, name, sql FROM sqlite_master WHERE type = 'trigger' ORDER BY tbl_name, name"
      @connection.select_all(sql).group_by { |r| r['tbl_name'] }.transform_values do |rows|
        rows.map { |r| Trigger.new(name: r['name'], timing: nil, events: nil, action: r['sql']) }
      end
    end

    def materialized_views
      @materialized_views ||=
        postgres? ? @connection.select_values('SELECT matviewname FROM pg_matviews WHERE schemaname = ANY (current_schemas(false))') : []
    end

    # { enum_type_name => [values] } for PostgreSQL enum types
    def enums
      return {} unless postgres?

      sql = <<~SQL
        SELECT t.typname AS name, string_agg(e.enumlabel, ',' ORDER BY e.enumsortorder) AS labels
          FROM pg_type t
          JOIN pg_enum e ON e.enumtypid = t.oid
          JOIN pg_namespace n ON n.oid = t.typnamespace
         WHERE n.nspname = ANY (current_schemas(false))
         GROUP BY t.typname ORDER BY 1
      SQL
      @connection.select_all(sql).to_h { |r| [r['name'], r['labels'].split(',')] }
    end

    def extensions
      @connection.respond_to?(:extensions) ? @connection.extensions.sort : []
    end

    def location
      @connection.pool.db_config.database
    rescue StandardError
      nil
    end

    def server_version
      sql = if postgres? then 'SHOW server_version'
            elsif sqlite? then 'SELECT sqlite_version()'
            else 'SELECT version()'
            end
      @connection.select_value(sql)
    rescue StandardError
      nil
    end

    def schema_version
      migration_context&.current_version
    rescue StandardError
      nil
    end

    def pending_migrations
      migration_context&.needs_migration?
    rescue StandardError
      nil
    end

    # Every migration file on this database's migrations paths, oldest first
    def migrations
      MigrationScanner.new(migrations_paths, root: @root).call
    end

    def migrations_paths
      Array(migration_context&.migrations_paths)
    rescue StandardError
      []
    end

    def migration_context
      pool = @connection.pool
      return pool.migration_context if pool.respond_to?(:migration_context)

      @connection.migration_context if @connection.respond_to?(:migration_context)
    end
  end # class DatabaseInspector


  # Reads migration files and works out which tables each one changes, from
  # the schema DSL calls and from the SQL in execute strings and heredocs.
  # Only the forward direction counts: `def down` and `dir.down` are skipped.
  class MigrationScanner
    TABLE_OPS = %w[create_table drop_table change_table add_column remove_column change_column
                   change_column_null change_column_default change_column_comment rename_column
                   add_index remove_index add_reference remove_reference add_belongs_to
                   remove_belongs_to add_check_constraint remove_check_constraint
                   add_unique_constraint remove_unique_constraint add_exclusion_constraint
                   remove_exclusion_constraint add_timestamps remove_timestamps
                   change_table_comment validate_foreign_key validate_check_constraint
                   validate_constraint].freeze

    # op :table[, :column | %i[a b] | [:a, :b] | "string"]
    ARGUMENT    = /(?:\s*,\s*(?::(\w+)|%i\[([^\]]*)\]|\[([^\]]*)\]|"([^"]*)"|'([^']*)'))?/
    # longest names first so change_column_null is not read as change_column
    OPS         = TABLE_OPS.sort_by { |op| -op.size }.join('|')
    DSL_CALL    = /\b(#{OPS})\b\s*\(?\s*:(\w+)#{ARGUMENT}/
    # The same call with a variable for the table, as in `TABLES.each { |t| add_column t, ... }`;
    # the change is attributed to every word in the file's %i[...] and %w[...] literals
    DSL_VAR     = /\b(#{OPS})\b\s*\(?\s*([a-z_]\w*)#{ARGUMENT}/
    WORD_LISTS  = /%[iw]\[([^\]]*)\]/m
    RENAME      = /\brename_table\s*\(?\s*:(\w+)\s*,\s*:(\w+)/
    JOIN_TABLE  = /\bcreate_join_table\s*\(?\s*:(\w+)\s*,\s*:(\w+)/
    FOREIGN_KEY = /\b(add|remove)_foreign_key\s*\(?\s*:(\w+)\s*,\s*:(\w+)/
    MODEL_TABLE = /self\.table_name\s*=\s*['"](\w+)['"]/
    SQL         = /\b(?<verb>ALTER\s+TABLE|CREATE\s+TABLE|DROP\s+TABLE|TRUNCATE\s+TABLE|CREATE\s+(?:UNIQUE\s+)?INDEX\s+\S+\s+ON|UPDATE|INSERT\s+INTO|DELETE\s+FROM)\s+(?:IF\s+(?:NOT\s+)?EXISTS\s+)?(?:ONLY\s+)?"?(?<table>\w+)"?/i
    HEREDOC     = /<<[~-]?(['"]?)([A-Z_]+)\1[^\n]*\n(.*?)^\s*\2\s*$/m
    EXEC_STRING = /\bexecute\s*\(?\s*(['"])(.*?)\1/m
    FILENAME    = /\A(\d+)_(.+)\.rb\z/

    class << self
      # The source with comment lines, `def down ... end`, `dir.down do ... end`
      # and one-line `dir.down { ... }` removed. A block ends at the first line
      # whose indentation matches the line that opened it.
      def forward_source(source)
        skip = nil
        source.lines.filter_map do |line|
          if skip
            skip = nil if line.match?(/\A#{skip}end\b/)
            next
          end
          next if line.match?(/\A\s*#/) || line.match?(/\bdir\.down\s*\{/)

          if (m = line.match(/\A(\s*)(?:def down\b|dir\.down\s+do\b)/))
            skip = m[1]
            next
          end
          line
        end.join
      end

      # SQL fragments in execute strings and heredocs
      def sql_blocks(source)
        source.scan(HEREDOC).map(&:last) + source.scan(EXEC_STRING).map(&:last)
      end

      # Column list argument rendered as "col" or "[a, b]"
      def argument(match)
        return match[3] if match[3]
        return "[#{match[4].split.join(', ')}]" if match[4]
        return "[#{match[5].delete(':').split(/\s*,\s*/).join(', ')}]" if match[5]

        match[6] || match[7]
      end

      # { table => [change, ...] } in file order, from the forward source
      def tables(source)
        src    = forward_source(source)
        tables = Hash.new { |h, k| h[k] = [] }

        src.scan(DSL_CALL) { tables[$2] << [$1, argument(Regexp.last_match)].compact.join(' ') }
        looped = src.scan(WORD_LISTS).flatten.flat_map(&:split).uniq
        src.scan(DSL_VAR) do
          change = [$1, argument(Regexp.last_match)].compact.join(' ')
          looped.each { |table| tables[table] << change }
        end
        src.scan(RENAME)   { tables[$1] << "rename_table to #{$2}"; tables[$2] << "rename_table from #{$1}" }
        src.scan(JOIN_TABLE) { tables[[$1, $2].sort.join('_')] << 'create_join_table' }
        src.scan(FOREIGN_KEY) { tables[$2] << "#{$1}_foreign_key to #{$3}"; tables[$3] << "#{$1}_foreign_key from #{$2}" }
        src.scan(MODEL_TABLE) { tables[$1] << 'data change through a model' }
        sql_blocks(src).each do |sql|
          sql.scan(SQL) do
            m = Regexp.last_match
            tables[m[:table]] << "#{m[:verb].upcase.gsub(/\s+/, ' ').sub(/ (UNIQUE )?INDEX .*/, ' INDEX')} (SQL)"
          end
        end
        tables.transform_values(&:uniq)
      end

      def renames(source)
        forward_source(source).scan(RENAME)
      end

      def migration(path)
        version, name = File.basename(path).match(FILENAME)&.captures
        source = File.read(path)
        Migration.new(version: version || '0', name: name || File.basename(path, '.rb'), path: path,
                      tables: tables(source), renames: renames(source))
      end
    end

    # paths are migration directories, absolute or relative to root
    def initialize(paths, root: Dir.pwd)
      @dirs = Array(paths).map { |p| File.expand_path(p.to_s, root) }
    end

    # [Migration, ...] oldest first; missing directories are skipped
    def call
      @dirs.flat_map { |dir| Dir[File.join(dir, '*.rb')] }.sort.map { |path| self.class.migration(path) }
    end
  end # class MigrationScanner


  # Reads what the application code says about one ActiveRecord model
  class ModelInspector
    SHOWN_OPTIONS = %i[through source source_type as polymorphic dependent inverse_of
                       counter_cache optional required touch primary_key foreign_type
                       autosave validate].freeze
    ACTIVE_STORAGE = %w[ActiveStorage::Attachment ActiveStorage::Blob].freeze

    def self.models
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.select { |m| reportable?(m) }.sort_by(&:name)
    end

    def self.reportable?(model)
      name = model.name
      return false if name.nil? || model.abstract_class?

      !name.include?('HABTM_') && !name.start_with?('ActiveRecord::', 'DataDictionaryV2::')
    end

    def initialize(model, root: Dir.pwd)
      @model = model
      @root  = root
    end

    def call
      Model.new(
        name:                 @model.name,
        table_name:           @model.table_name,
        database:             database_name,
        source:               source,
        sti_parent:           sti_parent,
        sti_column:           sti_column,
        associations:         associations,
        **own_definitions
      )
    rescue StandardError => e
      Model.new(name: @model.name, table_name: (@model.table_name rescue nil), error: "#{e.class}: #{e.message}")
    end

    # Definitions that can be inherited; an STI subclass only reports what it adds
    def definitions
      {
        enums:                enums,
        validations:          validations,
        stored_attributes:    stored_attributes,
        attachments:          attachments,
        encrypted_attributes: encrypted_attributes,
        virtual_attributes:   virtual_attributes
      }
    end

    def own_definitions
      mine = definitions
      return mine unless sti_parent

      inherited = self.class.new(@model.superclass, root: @root).definitions
      mine.to_h { |key, value| [key, value.is_a?(Hash) ? value.reject { |k, v| inherited[key][k] == v } : value - inherited[key]] }
    end

    def database_name
      @model.connection_db_config.name
    rescue StandardError
      'primary'
    end

    def source
      path = Object.const_source_location(@model.name)&.first
      return nil unless path

      path = File.expand_path(path)
      return path.delete_prefix("#{@root}/") if path.start_with?("#{@root}/")

      path[%r{/gems/(.+)}, 1] || path
    end

    def sti_parent
      @model.superclass.name unless @model.base_class == @model
    end

    # The inheritance column, when this model is the base of an STI hierarchy
    def sti_column
      column = @model.inheritance_column
      return nil unless @model.base_class == @model && @model.descendants.any?

      column if @model.column_names.include?(column)
    rescue StandardError
      nil
    end

    def associations
      inherited = sti_parent ? @model.superclass.reflect_on_all_associations.map(&:name) : []

      @model.reflect_on_all_associations.filter_map do |r|
        next if inherited.include?(r.name) || ACTIVE_STORAGE.include?(r.options[:class_name].to_s)

        options = r.options.slice(*SHOWN_OPTIONS)
        options[:scope] = :lambda if r.scope
        Association.new(
          macro:       r.macro,
          name:        r.name,
          class_name:  r.polymorphic? ? nil : r.class_name,
          foreign_key: (r.options[:through] ? nil : (r.foreign_key rescue nil)),
          options:     options
        )
      end
    end

    # { attribute => { key => stored_value } }
    def enums
      @model.defined_enums.transform_values(&:to_h)
    end

    def validations
      validators = @model.validators.map do |v|
        Validation.new(kind: v.kind, attributes: v.attributes.map(&:to_s), options: v.options)
      end
      validators + custom_validations
    end

    # `validate :method_name` style validations, skipping the ones Rails adds itself
    def custom_validations
      @model._validate_callbacks.map(&:filter).grep(Symbol).filter_map do |name|
        next if rails_method?(name)

        Validation.new(kind: :validate, attributes: [name.to_s], options: {})
      end
    rescue StandardError
      []
    end

    def rails_method?(name)
      path = @model.instance_method(name).source_location&.first.to_s
      path.match?(%r{/(activerecord|activemodel|activesupport)-[^/]+/})
    rescue NameError
      false
    end

    def stored_attributes
      @model.stored_attributes.to_h { |store, keys| [store.to_s, keys.map(&:to_s)] }
    end

    def attachments
      return [] unless @model.respond_to?(:reflect_on_all_attachments)

      @model.reflect_on_all_attachments.map { |a| "#{a.name} (#{a.macro})" }
    end

    def encrypted_attributes
      @model.respond_to?(:encrypted_attributes) ? @model.encrypted_attributes.to_a.map(&:to_s) : []
    end

    # Attributes declared with the attribute API that have no database column
    def virtual_attributes
      @model.attribute_types.keys - @model.column_names
    rescue StandardError
      []
    end
  end # class ModelInspector


  # Builds the markdown data dictionary from an App
  class Report
    class << self
      def cell(value)
        value.to_s.gsub('|', '\|').gsub(/\s*\n\s*/, ' ')
      end

      # Columns are padded so the pipes line up (markdownlint MD060 "aligned")
      def markdown_table(headers, rows)
        cells  = ([headers] + rows).map { |row| row.map { |v| cell(v) } }
        widths = cells.transpose.map { |column| [column.map(&:length).max, 3].max }
        lines  = cells.map { |row| row.zip(widths).map { |v, w| v.ljust(w) } }
        lines.insert(1, widths.map { |w| '-' * w })
        lines.map { |row| "| #{row.join(' | ')} |" }.join("\n")
      end

      def format_version(version)
        digits = version.to_s.delete('_')
        return 'unknown' if digits.empty? || digits == '0'

        m = digits.match(/\A(\d{4})(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)\z/)
        m ? "#{m[1]}-#{m[2]}-#{m[3]} #{m[4]}:#{m[5]}:#{m[6]} (#{digits})" : digits
      end

      def format_value(value)
        case value
        when Proc   then '(proc)'
        when Array  then value.map { |v| format_value(v) }.join(', ')
        when Hash   then "{#{format_options(value)}}"
        when String then value
        else value.inspect
        end
      end

      def format_options(options)
        options.map { |key, value| "#{key}: #{format_value(value)}" }.join(', ')
      end

      def enum_values(mapping)
        mapping.map { |key, value| key.to_s == value.to_s ? key.to_s : "#{key} (#{value})" }.join(', ')
      end

      def number(value)
        value.to_s.reverse.scan(/\d{1,3}/).join(',').reverse.then { |s| value.negative? ? "-#{s}" : s }
      end

      def human_size(bytes)
        return '' if bytes.nil?

        units = %w[B KB MB GB TB]
        size  = bytes.to_f
        unit  = 0
        while size >= 1024 && unit < units.size - 1
          size /= 1024
          unit += 1
        end
        unit.zero? ? "#{bytes} B" : format('%.1f %s', size, units[unit])
      end

      def rows_label(table)
        return '' if table.rows.nil?

        table.rows_estimated ? "~#{number(table.rows)}" : number(table.rows)
      end
    end

    INDEX = 'data_dictionary.md'

    # erd_format names the diagram files the table pages embed; nil for none
    # output_dir is where the pages will be written; migration links are relative to it
    def initialize(app, date: Date.today, erd_format: nil, output_dir: nil)
      @app        = app
      @date       = date
      @erd_format = erd_format
      @output_dir = output_dir
      @multi      = app.databases.size > 1
      @models     = app.models.group_by { |m| [m.database, m.table_name] }
    end

    # { filename => markdown } for the index page and one page per table
    def pages
      pages = { INDEX => index_markdown }
      @app.databases.reject(&:error).each do |db|
        db.tables.each { |t| pages["#{basename(db.name, t.name)}.md"] = table_page(db, t) }
      end
      pages
    end

    def index_markdown
      sections = [header, database_summary]
      @app.databases.each { |db| sections << database_section(db) }
      sections << orphan_models
      sections << data_element_index
      sections.compact.join("\n\n") + "\n"
    end

    # File stem shared by a table's page and its diagram; prefixed when there are several databases
    def basename(db_name, table_name)
      @multi ? "#{db_name}.#{table_name}" : table_name
    end

    def page_link(db_name, table_name)
      "[#{table_name}](#{basename(db_name, table_name)}.md)"
    end

    def header
      <<~HEADER.chomp
        # #{@app.name} Data Dictionary

        This report was generated on #{@date} by booting the application and
        reading its live database#{@multi ? 's' : ''} and its ActiveRecord models.

        - **Application:** #{@app.name} (`#{File.basename(@app.root)}`)
        - **Environment:** #{@app.environment}
        - **Rails:** #{@app.rails_version}
        - **Ruby:** #{@app.ruby_version}
        - **Models:** #{@app.models.size}
      HEADER
    end

    def database_summary
      headers = ['Database', 'Adapter', 'Server Version', 'Location', 'Schema Version', 'Tables', 'Views', 'Models']
      rows = @app.databases.map do |db|
        tables, views = db.tables.partition { |t| t.kind == 'table' }
        model_count   = @app.models.count { |m| m.database == db.name }
        [db.name, db.adapter, db.server_version, db.location, self.class.format_version(db.schema_version),
         tables.size, views.size, model_count]
      end

      warnings = @app.databases.filter_map do |db|
        if db.error
          "> **#{db.name}:** could not be read: #{db.error}"
        elsif db.pending_migrations
          "> **#{db.name}:** has pending migrations; the database may not match the migration files."
        end
      end

      # One blockquote; separate quotes with blank lines between them trip MD028
      parts = ["## Databases", self.class.markdown_table(headers, rows)]
      parts << warnings.join("\n>\n") if warnings.any?
      parts.join("\n\n")
    end

    def database_section(db)
      return nil if db.error

      parts = ["## #{@multi ? "#{db.name} Database" : 'Database'} Tables"]
      parts << "**Extensions:** #{db.extensions.join(', ')}" if db.extensions.any?
      parts << table_summary(db)
      if db.enums.any?
        rows = db.enums.map { |name, values| [name, values.join(', ')] }
        parts << "### #{@multi ? "#{db.name} " : ''}Enum Types\n\n#{self.class.markdown_table(%w[Name Values], rows)}"
      end
      parts.join("\n\n")
    end

    def table_summary(db)
      described = db.tables.any?(&:comment)
      headers   = ['Table', 'Kind', 'Models', 'Rows', 'Size']
      headers << 'Description' if described

      rows = db.tables.map do |t|
        row = [page_link(db.name, t.name), t.kind,
               models_for(db, t).map(&:name).join(', '), self.class.rows_label(t), self.class.human_size(t.bytes)]
        row << t.comment if described
        row
      end
      self.class.markdown_table(headers, rows)
    end

    def heading(db, table)
      basename(db.name, table.name)
    end

    def models_for(db, table)
      @models.fetch([db.name, table.name], [])
    end

    def table_page(db, t)
      parts = ["# #{heading(db, t)}"]
      parts << t.comment if t.comment

      facts = ["**Kind:** #{t.kind}"]
      facts << "**Primary key:** #{Array(t.primary_key).join(', ')}" if t.primary_key
      facts << "**Rows:** #{self.class.rows_label(t)}#{' (estimate)' if t.rows_estimated}" if t.rows
      facts << "**Size:** #{self.class.human_size(t.bytes)}" if t.bytes
      parts << facts.join(' · ')

      parts << diagram_section(db, t)
      parts << "## Columns\n\n#{columns_table(t)}"
      parts << "## Indexes\n\n#{indexes_table(t)}" if t.indexes.any?
      parts << "## Foreign Keys\n\n#{foreign_keys_table(db, t)}" if t.foreign_keys.any?

      referenced_by = referencing_keys(db, t)
      if referenced_by.any?
        rows = referenced_by.map { |from, fk| [page_link(db.name, from), Array(fk.column).join(', '), fk.on_delete, fk.name] }
        parts << "## Referenced By\n\n#{self.class.markdown_table(['Table', 'Column', 'On Delete', 'Name'], rows)}"
      end

      if t.check_constraints.any?
        rows = t.check_constraints.map { |c| [c.name, "`#{c.expression}`"] }
        parts << "## Check Constraints\n\n#{self.class.markdown_table(%w[Name Expression], rows)}"
      end

      if t.triggers.any?
        rows = t.triggers.map { |tr| [tr.name, [tr.timing, tr.events].compact.join(' '), "`#{tr.action}`"] }
        parts << "## Triggers\n\n#{self.class.markdown_table(%w[Name When Action], rows)}"
      end

      parts << migrations_section(db, t)
      models_for(db, t).each { |m| parts << model_detail(m) }
      parts << "[Back to the data dictionary](#{INDEX})"
      parts.compact.join("\n\n") + "\n"
    end

    # The ErdWriter for a database, shared with the related-tables list so the
    # page and its diagram agree on what is related
    def erd_for(db)
      @erds ||= {}
      @erds[db.name] ||= ErdWriter.new(db, models: @app.models.select { |m| m.database == db.name })
    end

    # Linked lists of the tables this one references and the tables that
    # reference it, foreign keys and polymorphic associations alike. Markdown
    # renderers show the diagram as a static image, so this is the navigation
    # the diagram's own links would give.
    def related_tables(db, t)
      references = []
      referenced = []
      erd_for(db).relations(t).each do |from, key|
        column = Array(key.column).join(', ')
        note   = key.is_a?(ErdWriter::PolymorphicKey) ? ' (polymorphic)' : ''
        if from == t.name
          references << "- #{page_link(db.name, key.to_table)} via `#{column}`#{note}"
        else
          referenced << "- #{page_link(db.name, from)} via `#{column}`#{note}"
        end
      end
      return nil if references.empty? && referenced.empty?

      parts = []
      parts << "**References:**\n\n#{references.uniq.join("\n")}" if references.any?
      parts << "**Referenced by:**\n\n#{referenced.uniq.join("\n")}" if referenced.any?
      parts.join("\n\n")
    end

    # The Relations section: the related-tables list and, when the ERD is an
    # image format, the diagram. GitHub and most Markdown renderers show the
    # image statically, so the links inside the SVG only work when it is opened
    # from a checkout; the list above it is the navigation that always works.
    def diagram_section(db, t)
      parts = ['## Relations']
      parts << (related_tables(db, t) || 'No other table is related to this one.')
      if %w[svg png].include?(@erd_format)
        file = "#{basename(db.name, t.name)}.#{@erd_format}"
        parts << "![#{t.name} entity relationship diagram](#{file})"
        parts << 'Solid edges are database foreign keys; dashed edges are polymorphic associations the models declare. ' \
                 'The table names in the diagram are links, but only when the SVG is opened on its own from a checkout; ' \
                 'on GitHub use the list above.'
      end
      parts.join("\n\n")
    end

    def columns_table(t)
      described = t.columns.any?(&:comment)
      headers   = %w[Column Type Null Default Key]
      headers << 'Description' if described

      rows = t.columns.map do |c|
        row = [c.name, c.sql_type, c.null ? 'YES' : 'NO', c.default, column_keys(t, c.name)]
        row << c.comment if described
        row
      end
      self.class.markdown_table(headers, rows)
    end

    # "PK", "FK → table", "UQ" markers for a column
    def column_keys(t, column_name)
      keys = []
      keys << 'PK' if Array(t.primary_key).include?(column_name)
      t.foreign_keys.each { |fk| keys << "FK → #{fk.to_table}" if Array(fk.column).include?(column_name) }
      keys << 'UQ' if t.indexes.any? { |i| i.unique && i.columns == [column_name] }
      keys.join(', ')
    end

    def indexes_table(t)
      rows = t.indexes.map do |i|
        [i.name, i.columns.join(', '), i.unique ? 'YES' : '', i.using, i.where && "`#{i.where}`"]
      end
      self.class.markdown_table(%w[Name Columns Unique Using Condition], rows)
    end

    def foreign_keys_table(db, t)
      rows = t.foreign_keys.map do |fk|
        [Array(fk.column).join(', '), "#{page_link(db.name, fk.to_table)}.#{Array(fk.primary_key).join(', ')}", fk.on_delete, fk.on_update, fk.name]
      end
      self.class.markdown_table(['Column', 'References', 'On Delete', 'On Update', 'Name'], rows)
    end

    # [[table_name, ForeignKey], ...] for keys in other tables pointing at this one
    def referencing_keys(db, t)
      db.tables.flat_map { |other| other.foreign_keys.select { |fk| fk.to_table == t.name }.map { |fk| [other.name, fk] } }
    end

    # The table's current name plus every name it was renamed from, found by
    # walking the renames back from newest to oldest
    def table_names(db, t)
      names = [t.name]
      db.migrations.reverse_each do |m|
        m.renames.each { |old, new| names << old if names.include?(new) && !names.include?(old) }
      end
      names
    end

    # [[Migration, [change, ...]], ...] for the migrations that touched this table, oldest first
    def migrations_for(db, t)
      names = table_names(db, t)
      db.migrations.filter_map do |m|
        changes = names.flat_map { |n| m.tables.fetch(n, []) }
        [m, changes] if changes.any?
      end
    end

    def migration_link(m)
      return m.path unless @output_dir

      Pathname.new(m.path).relative_path_from(Pathname.new(@output_dir)).to_s
    end

    def migrations_section(db, t)
      rows = migrations_for(db, t).map do |m, changes|
        [self.class.format_version(m.version).sub(/ \(\d+\)\z/, ''),
         "[#{m.name}](#{migration_link(m)})",
         changes.map { |c| "`#{c}`" }.join(', ')]
      end
      return nil if rows.empty?

      "## Migrations\n\n#{self.class.markdown_table(['Version', 'Migration', 'Changes to this table'], rows)}"
    end

    def model_detail(m)
      parts = ["## Model: #{m.name}"]
      return (parts << "Could not be inspected: #{m.error}").join("\n\n") if m.error

      facts = []
      facts << "**Source:** `#{m.source}`" if m.source
      facts << "**STI subclass of:** #{m.sti_parent}" if m.sti_parent
      facts << "**STI type column:** #{m.sti_column}" if m.sti_column
      parts << facts.join(' · ') if facts.any?

      if m.associations.any?
        rows = m.associations.map do |a|
          [a.macro, a.name, a.class_name || '(polymorphic)', a.foreign_key, self.class.format_options(a.options)]
        end
        parts << "### #{m.name} Associations\n\n#{self.class.markdown_table(['Type', 'Name', 'Class', 'Foreign Key', 'Options'], rows)}"
      end

      if m.enums.any?
        rows = m.enums.map { |attr, mapping| [attr, self.class.enum_values(mapping)] }
        parts << "### #{m.name} Enums\n\n#{self.class.markdown_table(%w[Attribute Values], rows)}"
      end

      if m.validations.any?
        rows = m.validations.map { |v| [v.kind, v.attributes.join(', '), self.class.format_options(v.options)] }
        parts << "### #{m.name} Validations\n\n#{self.class.markdown_table(%w[Validation Attributes Options], rows)}"
      end

      extras = []
      m.stored_attributes.each { |store, keys| extras << "**Store `#{store}`:** #{keys.join(', ')}" }
      extras << "**Attachments:** #{m.attachments.join(', ')}" if m.attachments.any?
      extras << "**Encrypted attributes:** #{m.encrypted_attributes.join(', ')}" if m.encrypted_attributes.any?
      extras << "**Virtual attributes:** #{m.virtual_attributes.join(', ')}" if m.virtual_attributes.any?
      parts.concat(extras)

      parts.join("\n\n")
    end

    def orphan_models
      inspected = @app.databases.reject(&:error)
      known     = inspected.flat_map { |db| db.tables.map { |t| [db.name, t.name] } }
      orphans   = @app.models.select { |m| inspected.any? { |db| db.name == m.database } }
                             .reject { |m| known.include?([m.database, m.table_name]) }
      return nil if orphans.empty?

      rows = orphans.map { |m| [m.name, m.database, m.table_name, m.source, m.error] }
      <<~SECTION.chomp
        ## Models Without a Database Table

        These models point at a table that was not found in their database.
        The table may not be migrated yet, or the model may be unused.

        #{self.class.markdown_table(%w[Model Database Table Source Error], rows)}
      SECTION
    end

    def data_element_index
      entries = @app.databases.flat_map do |db|
        db.tables.flat_map { |t| t.columns.map { |c| [c, db.name, t.name] } }
      end
      return nil if entries.empty?

      entries.sort_by! { |c, db_name, table_name| [c.name, db_name, table_name] }
      described = entries.any? { |c, _, _| c.comment }
      headers = ['Data Element Name', 'Table', 'Type', 'Null']
      headers.insert(1, 'Database') if @multi
      headers << 'Description' if described
      rows = entries.map do |c, db_name, table_name|
        row = [c.name, page_link(db_name, table_name), c.sql_type, c.null ? 'YES' : 'NO']
        row.insert(1, db_name) if @multi
        row << c.comment if described
        row
      end

      <<~SECTION.chomp
        ## Data Element Index

        Every column in alphabetic order. The same data element name may
        be used in more than one table; compare the types to spot drift.
        Each table name links to that table's page.

        #{self.class.markdown_table(headers, rows)}
      SECTION
    end
  end # class Report


  # Builds Graphviz ERDs from a Database: one per table (the table in full,
  # its parents and children by key columns) plus one for the whole schema
  class ErdWriter
    FORMATS = %w[svg dot png pdf].freeze

    GRAPH_ATTRS = 'rankdir=LR bgcolor="transparent" fontname="Arial" nodesep=0.3 ranksep=1.0'
    NODE_ATTRS  = 'shape=plaintext fontname="Arial" fontsize=12 fontcolor="#e6e6e6"'
    EDGE_ATTRS  = 'fontname="Arial" fontsize=9 color="#7aa2f7" fontcolor="#9aa4b2"'
    BORDER      = '#c8d1dc'
    TITLE_BG    = '#2b3a55'
    TYPE_COLOR  = '#9aa4b2'

    Error = Class.new(StandardError)

    # A link the models declare but the database cannot enforce: from_table.column
    # points at to_table's id whenever type_column names model. macro is the
    # inverse side's has_one or has_many; name is the polymorphic association.
    PolymorphicKey = Data.define(:name, :column, :type_column, :to_table, :primary_key, :model, :macro)

    class << self
      # For text inside HTML-like labels and their attributes
      def escape(value)
        value.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub('"', '&quot;')
      end

      # A double-quoted DOT attribute value
      def quote(value)
        %("#{value.to_s.gsub('\\', '\\\\\\\\').gsub('"', '\\"').gsub(/\s*\n\s*/, ' ')}")
      end

      # HTML-like label with a title row and one row (and port) per column,
      # or per column named in only. A url makes the whole box a link; comments
      # become hover tooltips, which Graphviz only emits for cells that carry a
      # link of their own.
      def node(table, url: nil, only: nil)
        cell_link = url ? %( href="#{escape(url)}") : ''
        columns   = only ? table.columns.select { |c| only.include?(c.name) } : table.columns
        rows = columns.map do |c|
          tooltip = c.comment ? %( title="#{escape(c.comment)}") : ''
          %(<tr><td port="#{escape(c.name)}" align="left"#{cell_link}#{tooltip}>#{escape(c.name)} <font color="#{TYPE_COLOR}">[#{escape(c.sql_type)}]</font></td></tr>)
        end
        title = %(<tr><td bgcolor="#{TITLE_BG}"#{cell_link}><font point-size="16" color="#ffffff"><b>#{escape(table.name)}</b></font></td></tr>)
        label = %(<<table border="0" cellborder="1" cellspacing="0" cellpadding="6" color="#{BORDER}">#{title}#{rows.join}</table>>)

        attrs = ["label=#{label}"]
        attrs << "URL=#{quote(url)}" if url
        attrs << "tooltip=#{quote(table.comment)}" if table.comment
        %("#{table.name}" [#{attrs.join(' ')}];)
      end

      # Crow's foot on the child column, bar and ring on the parent key; a
      # PolymorphicKey is dashed, with a single tee when its inverse is has_one
      def edge(from_table, fk, url: nil)
        column = Array(fk.column).first
        key    = Array(fk.primary_key).first || 'id'
        attrs  = ['arrowhead=teeodot', 'dir=both', "label=#{quote(column)}"]
        if fk.is_a?(PolymorphicKey)
          attrs << (fk.macro == :has_one ? 'arrowtail=tee' : 'arrowtail=crow') << 'style=dashed'
          attrs << "tooltip=#{quote("#{from_table}.#{column} references #{fk.to_table}.#{key} when #{fk.type_column} is #{fk.model} (polymorphic #{fk.name})")}"
        else
          attrs << 'arrowtail=crow'
          attrs << "tooltip=#{quote("#{from_table}.#{column} references #{fk.to_table}.#{key}")}"
        end
        attrs << "URL=#{quote(url)}" if url
        %("#{from_table}":"#{column}":e -> "#{fk.to_table}":"#{key}":w [#{attrs.join(' ')}];)
      end

      # nodes and edges are DOT statements from .node and .edge
      def graph(name, nodes, edges)
        lines = ["digraph \"#{name}\" {",
                 "  graph [#{GRAPH_ATTRS}];",
                 "  node  [#{NODE_ATTRS}];",
                 "  edge  [#{EDGE_ATTRS}];"]
        lines.concat(nodes.map { |n| "  #{n}" })
        lines.concat(edges.map { |e| "  #{e}" })
        (lines << '}').join("\n") + "\n"
      end
    end

    # models are the Models backed by this database; their has_one/has_many
    # ... as: declarations become dashed PolymorphicKey edges. name_for maps a
    # table name to the file stem its page and diagram share; when given, boxes
    # and edges link to "<stem>.md"
    def initialize(db, models: [], name_for: nil)
      @db          = db
      @tables      = db.tables.to_h { |t| [t.name, t] }
      @name_for    = name_for
      @polymorphic = polymorphic_keys(models)
    end

    # [[from_table, PolymorphicKey], ...] for every `has_one/has_many ..., as:`
    # whose owner and target tables are both in this database. The association's
    # class_name is the model holding the foreign key; the declaring model is
    # the target the type column names.
    def polymorphic_keys(models)
      by_name = models.to_h { |m| [m.name, m] }
      models.flat_map do |target|
        target.associations.filter_map do |a|
          as = a.options[:as]
          next unless as && a.foreign_key && %i[has_one has_many].include?(a.macro)

          owner = by_name[a.class_name]
          next unless owner && @tables[owner.table_name.to_s] && @tables[target.table_name.to_s]

          [owner.table_name.to_s,
           PolymorphicKey.new(name: as.to_s, column: a.foreign_key.to_s, type_column: "#{as}_type",
                              to_table: target.table_name.to_s, primary_key: 'id',
                              model: target.name, macro: a.macro)]
        end
      end.uniq { |from, pk| [from, pk.column, pk.to_table] }
    end

    def stem(name)
      @name_for ? @name_for.call(name) : name
    end

    def page_url(table_name)
      "#{@name_for.call(table_name)}.md" if @name_for
    end

    def node(table, only: nil) = self.class.node(table, url: page_url(table.name), only: only)
    def edge(from_table, fk) = self.class.edge(from_table, fk, url: page_url(from_table))

    # The primary key plus every column that the given [[table_name, ForeignKey], ...]
    # relations use on this table: enough to draw its edges without the full box
    def key_columns(table, relations)
      keys = Array(table.primary_key).map(&:to_s)
      keys = ['id'] if keys.empty?
      relations.each do |from, fk|
        if from == table.name
          keys.concat(Array(fk.column).map(&:to_s))
          keys << fk.type_column if fk.is_a?(PolymorphicKey)
        end
        keys.concat(Array(fk.primary_key).map(&:to_s)) if fk.to_table == table.name
      end
      keys.uniq
    end

    # [[table_name, ForeignKey or PolymorphicKey], ...] for keys from and to this table
    def relations(table)
      parents  = table.foreign_keys.map { |fk| [table.name, fk] }
      children = @db.tables.flat_map do |other|
        other.foreign_keys.select { |fk| fk.to_table == table.name }.map { |fk| [other.name, fk] }
      end
      poly = @polymorphic.select { |from, pk| from == table.name || pk.to_table == table.name }
      (parents + children + poly).uniq
    end

    # The table in full; its parents and children collapsed to their key columns
    def table_dot(table)
      edges = relations(table)
      names = ([table.name] + edges.flat_map { |from, fk| [from, fk.to_table] }).uniq
      nodes = names.filter_map { |n| @tables[n] }.map do |t|
        t == table ? node(t) : node(t, only: key_columns(t, edges))
      end
      self.class.graph(table.name, nodes, edges.map { |from, fk| edge(from, fk) })
    end

    # Every table collapsed to its key columns
    def schema_dot
      edges = @db.tables.flat_map { |t| t.foreign_keys.map { |fk| [t.name, fk] } } + @polymorphic
      nodes = @db.tables.map { |t| node(t, only: key_columns(t, edges)) }
      self.class.graph('schema', nodes, edges.map { |from, fk| edge(from, fk) })
    end

    # { file stem => dot source } for every diagram
    def diagrams
      @db.tables.to_h { |t| [stem(t.name), table_dot(t)] }.merge(stem('schema') => schema_dot)
    end

    # Writes STEM.FORMAT for each diagram, through Graphviz unless FORMAT is dot
    def write(dir, format: 'svg')
      FileUtils.mkdir_p(dir)
      diagrams.map do |name, source|
        path = File.join(dir, "#{name}.#{format}")
        format == 'dot' ? File.write(path, source) : self.class.render(source, path, format)
        path
      end
    end

    def self.render(source, path, format)
      IO.popen(['dot', "-T#{format}", '-o', path], 'w') { |dot| dot.write(source) }
      raise Error, "dot exited with #{Process.last_status.exitstatus} rendering #{path}" unless Process.last_status.success?
    end
  end # class ErdWriter


  module_function

  def parse_options(argv)
    options = { environment: nil, output: nil, count_rows: false, include_internal: false, databases: [],
                all_databases: false, erd: true, erd_format: 'svg' }

    parser = OptionParser.new do |o|
      o.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] [RAILS_ROOT]"
      o.on('-e', '--environment ENV', 'Rails environment (default: RAILS_ENV or development)') { |v| options[:environment] = v }
      o.on('-o', '--output DIR', "Write #{Report::INDEX}, a page per table and the diagrams to DIR",
           "(without it only #{Report::INDEX} is written, to STDOUT)") { |v| options[:output] = File.expand_path(v) }
      o.on('-d', '--database NAME', 'Report this database config (repeatable; default: the primary only)') { |v| options[:databases] << v }
      o.on('-a', '--all-databases', 'Report every database config (cache, queue, cable, ...)') { options[:all_databases] = true }
      o.on('-c', '--count', 'Exact row counts with SELECT COUNT(*) (can be slow)') { options[:count_rows] = true }
      o.on('-i', '--internal', 'Include schema_migrations and ar_internal_metadata') { options[:include_internal] = true }
      o.on('-f', '--erd-format FORMAT', ErdWriter::FORMATS, "ERD format: #{ErdWriter::FORMATS.join(', ')} (default: svg; needs Graphviz dot unless dot)") { |v| options[:erd_format] = v }
      o.on('--no-erd', 'Skip the ERD diagrams') { options[:erd] = false }
      o.on('-h', '--help', 'Show this help') { options[:help] = o.help }
    end

    options[:root] = File.expand_path(parser.parse(argv).first || '.')
    options
  end

  # Loads the application unless we are already inside it (bin/rails runner)
  def boot(root, environment)
    return if defined?(::Rails.application) && ::Rails.application

    ENV['RAILS_ENV'] = environment if environment
    ENV['RAILS_ENV'] ||= 'development'
    Dir.chdir(root)
    require File.join(root, 'config', 'environment')
  end

  # The configs to report: the ones named, or all of them, or just the primary
  def database_configs(only = [], all: false)
    configs = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env)
    configs = configs.reject { |c| c.respond_to?(:replica?) && c.replica? }
    return configs.select { |c| only.include?(c.name) } if only.any?
    return configs if all

    primary = ActiveRecord::Base.connection_db_config.name
    configs.select { |c| c.name == primary }
  end

  # [[config_name, connection_class], ...]
  def database_connections(configs)
    primary = ActiveRecord::Base.connection_db_config.name

    configs.each_with_index.map do |config, i|
      next [config.name, ActiveRecord::Base] if config.name == primary

      klass = const_set(:"Connection#{i}", Class.new(ActiveRecord::Base) { self.abstract_class = true })
      klass.establish_connection(config.name.to_sym)
      [config.name, klass]
    end
  end

  # Connecting to a missing SQLite file would create an empty one
  def missing_sqlite_file(adapter, database, root)
    return nil unless adapter.to_s.start_with?('sqlite') && database && !database.start_with?(':memory:', 'file:')

    path = File.expand_path(database, root)
    path unless File.exist?(path)
  end

  def with_connection(klass, &block)
    klass.respond_to?(:with_connection) ? klass.with_connection(&block) : block.call(klass.connection)
  end

  def collect(root:, count_rows: false, include_internal: false, databases: [], all_databases: false)
    configs = database_configs(databases, all: all_databases)
    missing = configs.to_h { |c| [c.name, missing_sqlite_file(c.adapter, c.database, root)&.delete_prefix("#{root}/")] }.compact
    names   = configs.map(&:name)

    # Inspecting a model can open its connection, so models on a missing database are skipped
    models = ModelInspector.models.filter_map do |m|
      inspector = ModelInspector.new(m, root: root)
      db_name   = inspector.database_name
      next unless names.include?(db_name)
      next Model.new(name: m.name, table_name: m.table_name, database: db_name, error: "database file not found: #{missing[db_name]}") if missing[db_name]

      inspector.call
    end

    dbs = database_connections(configs).map do |name, klass|
      if missing[name]
        config = klass.connection_db_config
        next Database.new(name: name, adapter: config.adapter, location: config.database, error: "database file not found: #{missing[name]}")
      end

      with_connection(klass) do |connection|
        DatabaseInspector.new(connection, name: name, root: root, count_rows: count_rows, include_internal: include_internal).call
      end
    rescue StandardError => e
      Database.new(name: name, error: "#{e.class}: #{e.message.lines.first&.strip}")
    end

    app_class = Rails.application.class
    App.new(
      name:          app_class.respond_to?(:module_parent_name) ? app_class.module_parent_name : app_class.parent_name,
      root:          root,
      environment:   Rails.env.to_s,
      rails_version: Rails.version,
      ruby_version:  RUBY_VERSION,
      databases:     dbs,
      models:        models
    )
  end

  def run(argv, out: $stdout, err: $stderr)
    options = parse_options(argv)
    if options[:help]
      out.puts options[:help]
      return 0
    end

    root = defined?(::Rails.root) && ::Rails.root ? ::Rails.root.to_s : options[:root]
    unless File.exist?(File.join(root, 'config', 'environment.rb'))
      err.puts "ERROR: not a Rails application: #{root}"
      return 1
    end

    boot(root, options[:environment])
    ActiveRecord::Base.logger = nil

    app = ActiveRecord::Base.while_preventing_writes do
      collect(root: root, **options.slice(:count_rows, :include_internal, :databases, :all_databases))
    end
    erd_format = options[:erd] && options[:output] ? options[:erd_format] : nil
    report     = Report.new(app, erd_format: erd_format, output_dir: options[:output])

    if options[:output]
      FileUtils.mkdir_p(options[:output])
      report.pages.each { |name, markdown| File.write(File.join(options[:output], name), markdown) }
      write_erds(app, report, options[:output], erd_format) if erd_format
    else
      out.print report.index_markdown
    end
    0
  rescue OptionParser::ParseError, ErdWriter::Error => e
    err.puts "ERROR: #{e.message}"
    1
  rescue Errno::ENOENT => e
    raise unless e.message.end_with?('- dot')

    err.puts 'ERROR: Graphviz dot not found; install graphviz or use --erd-format dot'
    1
  end

  # Diagrams share the report's file stems so the pages and the links inside the SVGs line up
  def write_erds(app, report, dir, format)
    app.databases.reject(&:error).flat_map do |db|
      models = app.models.select { |m| m.database == db.name }
      ErdWriter.new(db, models: models, name_for: ->(table_name) { report.basename(db.name, table_name) }).write(dir, format: format)
    end
  end
end # module DataDictionaryV2


exit DataDictionaryV2.run(ARGV) if $PROGRAM_NAME == __FILE__
