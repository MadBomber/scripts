#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: run_sql.rb
##  Desc: Execute SQL file(s)
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# makes use of a generic_database.yml file as a default
#

RAILS_ENV = ENV['RAILS_ENV'] || 'development'


require 'awesome_print'

require 'debug_me'
include DebugMe

require 'active_record'
require 'yaml'
require 'erb'

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  The default generic database.yml file makes use of the
  following system environment variables:

    Variable    Default
    DBADAPTER   postgresql
    DBPOOL      15
    DBHOST      localhost
    DBPORT      5432
    DBUSER
    DBPASS
    DBNAME
    RAILS_ENV   development

  Note that the full database name is built as a combination
  of DBNAME and RAILS_ENV using the '_' character inbetween.

EOHELP

cli_helper("Run SQL files: [options] one or more *.sql files") do |o|

  o.path    '-c', '--config',   'A database.yml configuration file',  default: my_dir + 'config/generic_database.yml'

  o.string '--format', 'Report format (text,hash,csv,tab)', default: 'text'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

unless configatron.config.exist?
  error "File does not exist: #{configatron.config}"
end

configatron.input_files = get_pathnames_from( configatron.arguments, '.sql')

if configatron.input_files.empty?
  error 'No SQL files were provided'
else
  configatron.input_files.each do |sql_file|
    unless sql_file.exist?
      warning "File does not exist: #{sql_file}"
    end
  end
end

abort_if_errors

# Establish connection to the database

configatron.database_config = YAML.load(
                                ERB.new( configatron.config.read
                                ).result
                              )[RAILS_ENV]

ActiveRecord::Base.establish_connection( configatron.database_config )


######################################################
# Local methods

class String
  def scrub
    '"' + gsub('"',"'") + '"'
  end
end

def print_header(a_hash)
  gap     = 3
  spaces  = " "*132
  dashes  = "="*132
  a_hash.each_pair do |key, value|
    print key
    extra = gap + value - key.size
    print spaces[0,extra]
  end
  puts
  a_hash.each_pair do |key, value|
    print dashes[0,value]
    print spaces[0,gap]
  end
  puts
end

def print_report_line(data_hash, width_hash)
  gap     = 3
  spaces  = " "*132
  data_hash.each_pair do |key, value|
    print value
    extra = gap + width_hash[key] - value.size
    print spaces[0,extra]
  end
  puts
end


def print_report(an_array_of_uniform_hashes)
  headers   = an_array_of_uniform_hashes.first.keys
  zeros     = headers.map{|key| key.size}
  max_size  = Hash[headers.zip(zeros)]
  an_array_of_uniform_hashes.each do |data_hash|
    data_hash.each_pair do |key, value|
      max_size[key] = value.size if value.size > max_size[key]
    end
  end


  print_header(max_size)

  an_array_of_uniform_hashes.each do |a_line|
    print_report_line(a_line, max_size)
  end
end


def export(an_array_of_uniform_hashes, sep, header)
  first_record = header
  an_array_of_uniform_hashes.each do |data_hash|
    if first_record
      puts data_hash.keys.map{|key| key.scrub}.join(sep)
      first_record = false
    end
    puts data_hash.values.map{|value| value.scrub}.join(sep)
  end
end


def export_csv(an_array_of_uniform_hashes, header: true)
  export(an_array_of_uniform_hashes, ',', header)
end


def export_tab(an_array_of_uniform_hashes, header: true)
  export(an_array_of_uniform_hashes, "\t", header)
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

configatron.input_files.each do |sql_file|

  puts
  puts "-"*65
  puts "-- Results of running: #{sql_file}"
  puts

  sql = sql_file.read

  results = ActiveRecord::Base.connection.execute(sql).to_a

  print_report(results) if 'text' == configatron.format
  ap results            if 'hash' == configatron.format
  export_csv(results)   if 'csv'  == configatron.format
  export_tab(results)   if 'tab'  == configatron.format

end # configatron.input_files.each do |sql_file|

