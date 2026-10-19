#!/usr/bin/env ruby
########################################################
###
##  File: data_dictionary.rb
##  Desc: Process a Rails db/schema.rb file to produce a markdown
##        data dictionary report showing all tables in the database with
##        their indexes and associations and all columns with their data types.
##
##  Usage: data_dictionary.rb [options] [RAILS_ROOT | SCHEMA_FILE]
##
##         RAILS_ROOT defaults to the current directory.  The application
##         name is taken from config/application.rb and the database
##         product from config/database.yml when they are present.
#

require 'date'
require 'optparse'
require 'active_support/core_ext/string/inflections'

module DataDictionary
  Column = Data.define(:name, :type, :options)
  Index  = Data.define(:columns, :unique)

  ADAPTER_NAMES = {
    'postgresql' => 'PostgreSQL',
    'postgis'    => 'PostgreSQL',
    'sqlite3'    => 'SQLite',
    'mysql2'     => 'MySQL',
    'trilogy'    => 'MySQL',
    'sqlserver'  => 'Microsoft SQL Server',
    'oracle_enhanced' => 'Oracle'
  }.freeze

  # Receives the column DSL calls made inside a create_table block
  class Table
    attr_reader :name, :columns, :indexes, :associations
    attr_accessor :comment

    def initialize(name)
      @name         = name.to_s
      @columns      = []
      @indexes      = []
      @associations = []
    end

    def column(name, type, **options)
      @columns << Column.new(name.to_s, type.to_s, options)
    end

    def index(column_names, unique: false, **)
      @indexes << Index.new(Array(column_names).map(&:to_s), unique)
    end

    def timestamps(**options)
      column('created_at', :datetime, **options)
      column('updated_at', :datetime, **options)
    end

    def references(name, polymorphic: false, type: :bigint, index: nil, foreign_key: nil, **options)
      column("#{name}_id", type, **options)
      column("#{name}_type", :string, **options) if polymorphic
    end
    alias belongs_to references

    def associate(table_name)
      table_name = table_name.to_s
      @associations << table_name unless @associations.include?(table_name)
    end

    # Constraints are not part of the data dictionary
    def check_constraint(*, **)     = nil
    def exclusion_constraint(*, **) = nil
    def unique_constraint(*, **)    = nil

    # Every other t.<type> call is a column definition, which covers
    # adapter specific types such as citext, vector, tsvector, etc.
    def method_missing(type, *names, **options)
      return super if names.empty?

      names.each { column(it, type, **options) }
    end

    def respond_to_missing?(*) = true
  end # class Table


  # Receives the DSL calls made inside an ActiveRecord::Schema.define block
  class Schema
    attr_accessor :version
    attr_reader :tables, :extensions, :enums

    def initialize
      @tables     = {}
      @extensions = []
      @enums      = {}
    end

    def table(name)
      @tables[name.to_s] ||= Table.new(name)
    end

    def create_table(name, id: :primary_key, primary_key: 'id', comment: nil, **)
      t = table(name)
      t.comment = comment

      unless id == false || primary_key.is_a?(Array)
        t.column(primary_key, id, primary_key: true)
      end

      yield t if block_given?
      t
    end

    def add_index(table_name, column_names, **options)
      table(table_name).index(column_names, **options)
    end

    def add_foreign_key(from_table, to_table, **)
      table(from_table).associate(to_table)
      table(to_table).associate(from_table)
    end

    def enable_extension(name)
      @extensions << name.to_s
    end

    def create_enum(name, values)
      @enums[name.to_s] = values.map(&:to_s)
    end

    # Ignore everything else: create_schema, create_view, execute, etc.
    def method_missing(*, **) = nil
    def respond_to_missing?(*) = true
  end # class Schema


  # Facts about the Rails project gathered from its config files
  class Project
    attr_reader :root

    def self.app_name_from(application_rb)
      application_rb[/^\s*module\s+(\w+)/, 1]
    end

    def self.adapter_from(database_yml)
      adapter = database_yml[/^\s*adapter:\s*["']?(\w+)/, 1]
      ADAPTER_NAMES.fetch(adapter, adapter)
    end

    def initialize(root)
      @root = File.expand_path(root)
    end

    def name
      text = read('config/application.rb')
      (text && self.class.app_name_from(text)) || File.basename(root)
    end

    def database
      text = read('config/database.yml')
      text && self.class.adapter_from(text)
    end

    private

    def read(relative_path)
      path = File.join(root, relative_path)
      File.read(path) if File.exist?(path)
    end
  end # class Project


  # Builds the markdown data dictionary from a parsed Schema
  class Report
    def self.format_version(version)
      digits = version.to_s.delete('_')
      return 'unknown' if digits.empty?

      m = digits.match(/\A(\d{4})(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)\z/)
      m ? "#{m[1]}-#{m[2]}-#{m[3]} #{m[4]}:#{m[5]}:#{m[6]} (#{digits})" : digits
    end

    def self.format_value(value)
      value.is_a?(Proc) ? value.call.to_s : value.inspect
    end

    def self.qualifiers(options)
      options.except(:comment)
             .map { |key, value| "#{key}: #{format_value(value)}" }
             .join(', ')
    end

    def self.index_label(index)
      label = index.columns.join(' + ')
      index.unique ? "#{label} (unique)" : label
    end

    def self.cell(value)
      value.to_s.gsub('|', '\|').gsub(/\s*\n\s*/, ' ')
    end

    def self.markdown_table(headers, rows)
      lines = [headers, headers.map { '-' * it.length }] + rows
      lines.map { |row| "| #{row.map { cell(it) }.join(' | ')} |" }.join("\n")
    end

    def initialize(schema, app_name:, database: nil, schema_path: 'db/schema.rb', date: Date.today)
      @schema      = schema
      @app_name    = app_name
      @database    = database
      @schema_path = schema_path
      @date        = date
    end

    def to_markdown
      [header, table_section, column_section].join("\n\n") + "\n"
    end

    def header
      <<~HEADER.chomp
        # #{@app_name} Data Dictionary

        This report is auto-generated from the file '#{@schema_path}'

        Report Date:    #{@date}

        Last Migration: #{self.class.format_version(@schema.version)}
      HEADER
    end

    def table_section
      tables = @schema.tables.values.sort_by(&:name)
      described = tables.any?(&:comment)

      headers = ['Database Table Name', 'Indexed By', 'Associated With']
      headers << 'Description' if described

      rows = tables.map do |t|
        row = [
          t.name,
          t.indexes.empty? ? 'N/A' : t.indexes.map { self.class.index_label(it) }.join(', '),
          t.associations.empty? ? 'N/A' : t.associations.sort.join(', ')
        ]
        row << t.comment if described
        row
      end

      <<~SECTION.chomp
        ## Database Tables

        The #{@app_name} application stores its content in #{database_phrase}.
        The database tables used by the application are shown in the table below.

        The first column is the name of the database table.  The second column
        shows the data elements within the database table for which the table
        is indexed.  The third column gives the names of the database tables
        which have associations with the database table named in the first column.

        Table 1. Database Table Names Used by the #{@app_name} Application

        #{self.class.markdown_table(headers, rows)}
      SECTION
    end

    def column_section
      entries = @schema.tables.values.flat_map { |t| t.columns.map { [it, t.name] } }
                       .sort_by { |column, table_name| [column.name, table_name] }
      described = entries.any? { |column, _| column.options[:comment] }

      headers = ['Data Element Name', 'Database Table Name', 'Data Type', 'Qualifiers']
      headers << 'Description' if described

      rows = entries.map do |column, table_name|
        row = [column.name, table_name, data_type(column), self.class.qualifiers(column.options)]
        row << column.options[:comment] if described
        row
      end

      <<~SECTION.chomp
        ## Data Element Definitions

        The following table (Table 2) lists in alphabetic order all of the data element
        names in use within all of the database tables that were shown in Table 1.
        This table shows in the first column the name of the data element.  Note that
        it is possible for the same data element name to be used in multiple database
        tables.  The second column shows the name of the database table which defines
        the data element.  The third column shows the type of the data element - for
        example whether the data element is a "string" or an "integer."  The fourth
        column shows any additional qualifiers for the data element as it is defined.
        Qualifiers can be such things as the default value for the data element or
        whether the data element is allowed to have a "null" value.

        Table 2. Data Elements Defined in all Database Tables used by the #{@app_name} Application

        #{self.class.markdown_table(headers, rows)}
      SECTION
    end

    def data_type(column)
      values = @schema.enums[column.options[:enum_type].to_s]
      values ? "#{column.type} (#{values.join(', ')})" : column.type
    end

    def database_phrase
      @database ? "a #{@database} database" : 'a relational database'
    end
  end # class Report


  # Evaluates schema.rb source against the fake ActiveRecord::Schema
  def self.parse(source, path = 'schema.rb')
    ActiveRecord::Schema.collector = Schema.new
    eval(source, TOPLEVEL_BINDING, path) # rubocop:disable Security/Eval
    ActiveRecord::Schema.collector
  ensure
    ActiveRecord::Schema.collector = nil
  end

  # Returns [project_root, schema_path] for a Rails root or a schema file
  def self.resolve_paths(target)
    target = File.expand_path(target)
    return [target, File.join(target, 'db', 'schema.rb')] if File.directory?(target)

    dir = File.dirname(target)
    [File.basename(dir) == 'db' ? File.dirname(dir) : dir, target]
  end

  def self.parse_options(argv)
    options = { title: nil, output: nil }

    parser = OptionParser.new do |o|
      o.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] [RAILS_ROOT | SCHEMA_FILE]"
      o.on('-t', '--title NAME', 'Application name used in the report') { options[:title] = it }
      o.on('-o', '--output FILE', 'Write the report to FILE instead of STDOUT') { options[:output] = it }
      o.on('-h', '--help', 'Show this help') { options[:help] = o.help }
    end

    options[:target] = parser.parse(argv).first || '.'
    options
  end

  def self.run(argv, out: $stdout, err: $stderr)
    options = parse_options(argv)
    if options[:help]
      out.puts options[:help]
      return 0
    end

    root, schema_path = resolve_paths(options[:target])
    unless File.exist?(schema_path)
      err.puts "ERROR: schema file not found: #{schema_path}"
      return 1
    end

    project = Project.new(root)
    report  = Report.new(
      parse(File.read(schema_path), schema_path),
      app_name:    options[:title] || project.name,
      database:    project.database,
      schema_path: schema_path.delete_prefix("#{root}/")
    )

    if options[:output]
      File.write(options[:output], report.to_markdown)
    else
      out.print report.to_markdown
    end
    0
  rescue OptionParser::ParseError => e
    err.puts "ERROR: #{e.message}"
    1
  end
end # module DataDictionary


# Fake the ActiveRecord::Schema interface used by db/schema.rb
module ActiveRecord
  class Schema
    class << self
      attr_accessor :collector

      # Rails 5.2+ writes ActiveRecord::Schema[7.1].define(...)
      def [](_rails_version) = self

      def define(info = {}, &block)
        collector.version = info[:version]
        collector.instance_eval(&block)
      end
    end
  end
end


exit DataDictionary.run(ARGV) if $PROGRAM_NAME == __FILE__
