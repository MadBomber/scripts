#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: seed_with_headers.rb
##  Desc: Load CSV files that contain a header record of column_names into a database table.
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'pretty_backtrace'

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors
require 'csv'            # STDLIB

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

require 'active_record'
require 'pg'             # Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]

require 'active_support/core_ext/string'  # just need String #classify #constantize methods

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Load CSV files that contain a header record of column_names into a database table") do |o|

  o.path    '-c', '--csv',   'csv seed file name'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, '.csv')

if configatron.input_files.empty?
  STDERR.puts 'No CSV files were provided'
end

if configatron.csv.nil?
  error "--csv is required"
end

abort_if_errors

require_relative 'utilities'

ActiveRecord::Base.logger = Logger.new('temp.log')

database_yml_path = Pathname.new('db/database.yml')

config = YAML.load( ERB.new( database_yml_path.read ).result )['development']    # ENV['RUBY_ENV']]
ActiveRecord::Base.establish_connection( config )

###############
## Models

require_relative 'models/localhost_all'


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


# configatron.input_files.each

csv_pathname = configatron.csv

record_count = `wc -l #{csv_pathname}`.to_i

progressbar = ProgressBar.create(
    title: 'Records',
    total: record_count,
    format: '%t: [%B] %c/%C %j%% %e',
    output: STDERR
  )

begin
  DbTableName = csv_pathname.basename.to_s.gsub('.csv','').classify.constantize
rescue Exception => e
  STDERR.puts e
  exit
end

csv_data = CSV.foreach(csv_pathname, quote_char: '"', col_sep: ',', row_sep: :auto, headers: true) 

row_count = 0
pg_record_cnt = 0


csv_data.each do |row|
  progressbar.increment
  #ap row # row is a hash when headers are included

  row_count += 1
  id         = row['id'].to_i

  #printf "%d .. %d\n", row_count, id unless id == row_count

  begin
    # TODO: the (csv_pathname.basename.to_s - '.csv').constantize
    #       is the class name of the database table
    a_pg_record = DbTableName.find(id)  #.serializable_hash
  rescue ActiveRecord::RecordNotFound
    pg_record_cnt += 1
    pdr = DbTableName.new(row.to_hash)
    pdr.save
  rescue
    puts "Not a null id: #{id}"
  end




end
