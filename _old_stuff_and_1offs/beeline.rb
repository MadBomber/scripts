#!/usr/bin/env ruby

require 'debug_me'
include DebugMe 

require 'awesome_print'

require 'pathname'

require 'uuidtools'
require 'spreadsheet'

require 'variable_name_of'  # @madbomber/lib_ruby
require 'date_transformer'  # @madbomber/lib_ruby



#############################################################
## Utility functions

def convert_basename_to_table_name(a_string)
  table_name = case a_string.downcase
    when 'beeline' then
      'Contingent Staffing Data'
    else
  	  raise "Unknown basename: #{a_string}"
  end
  return table_name
end # def convert_basename_to_table_name(a_string)


def convert_strings_to_variable_names(an_array_of_strings)
  raise ArgumentError unless Array == an_array_of_strings.class
  column_names = Array.new

  col_number = 0
  an_array_of_strings.each do |column_heading|
    raise ArgumentError unless String == column_heading.class
    column_name = variable_name_of(column_heading, :snake_case)
    if column_names.include? column_name
      col_index = column_names.index column_name
      if column_names[col_index] == column_name
        raise "Duplicate Column Name: #{column_name} Columns: #{col_index+1} and #{col_number+1}"
      end
    end
    column_names << column_name
    col_number += 1
  end

  return column_names
end # def convert_strings_to_variable_names(an_array)


def transform(a_value_array, a_name_array, max_string_size=255)
  raise ArgumentError unless Array == a_value_array.class && Array == a_name_array.class
  raise "Size mismatch: v: #{a_value_array.size} N: #{a_name_array.size}" unless a_value_array.size == a_name_array.size

  a_name_array.size.times do |x|
    if a_name_array[x].end_with?('_date')
      a_value_array[x] = date_transformer(a_value_array[x])
    end
    if 'bill_rate' == a_name_array[x]
      # delta = rand(a_value_array[x].to_i)
      # a_value_array[x] -= delta
    end
    if String == a_value_array[x].class
      a_value_array[x] = a_value_array[x][0,max_string_size] if a_value_array[x].size > max_string_size
    end
  end

  return a_value_array
end # def transform(a_value_array, a_name_array)


#############################################################
## Base variables

# TODO: take xls filename from command line

xls_path     = Pathname.new 'beeline.xls'
xls_basename = xls_path.basename.to_s.gsub(xls_path.extname,'')
table_title  = convert_basename_to_table_name xls_basename

Spreadsheet.client_encoding = 'UTF-8'
book   = Spreadsheet.open(xls_path)
sheet1 = book.worksheet(0)

heading = sheet1.first.to_a

column_names = convert_strings_to_variable_names(heading)

heading.map do |column_heading|
  variable_name_of(column_heading, :snake_case)
end

debug_me{[ 'heading.size', 'column_names.size', :heading, :column_names ]}



leader_names   = %w[ id unique_id ]
follower_names = %w[ report_date ]  # SMELL: created_at updated_at

##########################################################
## Main Processing


file_name = "#{variable_name_of(table_title, :lowerCamelCase)}.model.js"
mod_file  = File.open(file_name,'w')

mod_file.puts <<EOS

// ==================================================================
// File: $PROJ_ROOT/server/models/#{variable_name_of(table_title, :lowerCamelCase)}.model.js

module.exports = function(sequelize, DataTypes) {
  return sequelize.define("#{variable_name_of(table_title, :CamelCase)}", {
    id:        {type: DataTypes.INTEGER, unique: true},
    unique_id: {type: DataTypes.STRING,  unique: true},
EOS

=begin
# Basic javascript/serialize data types are:
	DataTypes.BOOLEAN
	DataTypes.DATE
	DataTypes.DECIMAL
	DataTypes.FLOAT
	DataTypes.INTEGER
	DataTypes.JSON
	DataTypes.STRING
	DataTypes.TEXT
	DataTypes.VIRTUAL
=end

column_names.each do |col_name|
  mod_file.print "    #{col_name}: DataTypes."
  if col_name.downcase.end_with?('date')
  	mod_file.print "DATE"
  else
  	mod_file.print "STRING"
  end
  mod_file.puts ','
end

mod_file.puts <<EOS
    report_date: DataTypes.DATE,
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE
  }, {
    underscored: true,
    tableName: '#{variable_name_of(table_title, :snake_case)}',
    indexes: [
      {fields: ['report_date']}
    ]
  })
};


EOS

mod_file.close

fn_prefix = DateTime.now.strftime("%Y%m%d%H%M%S")

file_name = "#{fn_prefix}-create-#{variable_name_of(table_title, :snake_case).gsub('_','-')}.js"
mig_file  = File.open(file_name,'w')

mig_file.puts <<EOS
// =========================================================
// == File: $PROJ_ROOT/db/migrate/#{fn_prefix}-create-#{variable_name_of(table_title, :snake_case).gsub('_','-')}.js

'use strict';
var Promise = require('bluebird');

module.exports = {
  up: function (queryInterface, Sequelize) {
    return new Promise(function (resolve, reject) {
      queryInterface.createTable(
        '#{variable_name_of(table_title, :snake_case)}',
        {
          id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
          },
          unique_id: {
            type: Sequelize.STRING,
            unique: true
          },
EOS


column_names.each do |col_name|
  mig_file.print "          #{col_name}: Sequelize."
  if col_name.downcase.end_with?('date')
  	mig_file.print "DATE"
  else
  	mig_file.print "STRING"
  end
  mig_file.puts ','
end


mig_file.puts <<EOS
          report_date: Sequelize.DATE,
          created_at: Sequelize.DATE,
          updated_at: Sequelize.DATE
        })
        .then(function () {
          queryInterface.sequelize.query("ALTER TABLE #{variable_name_of(table_title, :snake_case)} OWNER TO insighter;")
            .then(resolve)
            .catch(reject);
        })
        .catch(reject);
    });
  },

  down: function (queryInterface) {
    return new Promise(function(resolve, reject) {
      queryInterface.dropTable("#{variable_name_of(table_title, :snake_case)}")
        .then(resolve)
        .catch(reject);
    });
  }
};


EOS

mig_file.close

file_name = "#{variable_name_of(table_title, :snake_case)}.sql"
sql_file  = File.open(file_name, 'w')

sql_file.puts <<EOS
-- ==============================================================
-- == File: #{variable_name_of(table_title, :snake_case)}.sql

DROP TABLE IF EXISTS #{variable_name_of(table_title, :snake_case)};

CREATE TABLE "public"."contingent_staffing_data" ( 
  "id" INTEGER DEFAULT nextval('#{variable_name_of(table_title, :snake_case)}_id_seq'::regclass) NOT NULL UNIQUE, 
  "unique_id" CHARACTER VARYING( 255 ) COLLATE "pg_catalog"."default"
EOS


column_names.each do |col_name|
  sql_file.print "  \"#{col_name}\" "
  if col_name.downcase.end_with?('date')
  	sql_file.print "Date"
  else
  	sql_file.print "CHARACTER VARYING( 255 ) COLLATE \"pg_catalog\".\"default\""
  end
  sql_file.puts ','
end


sql_file.puts <<EOS
  "report_date" Date,
  "created_at" Date,
  "updated_at" Date
 PRIMARY KEY ( "id" )
 );

EOS

sql_file.close


##############################################################
## Generating a csv file

file_name = variable_name_of(table_title, :snake_case) + '.csv'
csv_file  = File.open(file_name, 'w')

# Header
# SMELL: The ops-review startup seed process does not use a header row.  It
#        gets its column order from the table_name.model.js file.
#csv_file.puts (leader_names+column_names+follower_names).join(',')

expected_columns_base 	= column_names.size
number_of_added_columns = 5 # id, unique_id, report_date, created_at, updated_at
expected_columns 		= expected_columns_base + number_of_added_columns

debug_me{[ 	:expected_columns_base, 
			:number_of_added_columns, 
			:expected_columns, 
			:column_names ]}


id = -1

c1 = 13 # zero-based 'N'
c2 = 18 # 'S'
lsize = 2

sheet1.each do |row|
  id += 1

  raw_d  = row.to_a
  debug_me{[ 'raw_d[c1]', 'raw_d[c2]' ]} if 0 == id
  ap raw_d if 0 == id

  next if 0 == id
  a_line = ''


  data   = [ id, UUIDTools::UUID.random_create.to_s ] + # id and unique_id
  		   transform(raw_d, column_names) + 		    # transformed row values
  		   ['2015-10-17', '2015-10-17', '2015-10-17'] 	# report_date, created_at, updated_at

  v1 = data[c1+lsize]
  v2 = data[c2+lsize]
  unless v1 == v2
    debug_me{[ :id, :v1, :v2 ]}
  end



  if data.size > expected_columns
  	debug_me('ERROR'){[ :id, 'data.size' ]}
  end

  if 1100 == data.first
    field = data[expected_columns-3]
    field_size = field.size
    the_last_character = field[field_size-1,1]
    debug_me{[ :field, :field_size, :the_last_character,
    	'the_last_character.size',
    	'the_last_character.ord'
     ]}
	v1 = data[c1+lsize]
	v2 = data[c2+lsize]
	#unless v1 == v2
	  debug_me{[ :id, :v1, :v2 ]}
	#end

  end





  data.each do |v|
    if v.respond_to?(:downcase)
      v = v.chomp.gsub("\n",' ').strip.downcase.gsub('"',"'")
      unless v.empty?
      	v = "\"#{v}\""
      end
    else
      v = v.to_s
    end
    a_line += v + ','
  end

  x = a_line.size
  csv_file.puts a_line[0,x-1] # MAGIC: remove the last comma equals 2
end

csv_file.close


