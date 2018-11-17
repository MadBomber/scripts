#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: copy_csv_to_rdb.rb
##  Desc: Cioy/Import a CSV file into a RethinkDB table
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print' # Pretty print Ruby objects with proper indentation and colors
require 'cli_helper'    # An encapsulation of an integration of slop, nenv, inifile and configatron.
require 'date'          # STDLIB
require 'debug_me'      # A tool to print the labeled value of variables.
require 'progress_bar'  # Simple Progress Bar for output to a terminal
require 'rethinkdb'     # This package provides the Ruby driver library for the RethinkDB database server.
require 'smarter_csv'   # Ruby Gem for smarter importing of CSV Files (and CSV-like files), with lots of optional features, e.g. chunked processing for huge CSV files
require 'tty-spinner'   # A terminal spinner for tasks that have non-deterministic time frame.

include CliHelper
include DebugMe
include RethinkDB::Shortcuts


HELP = <<EOHELP
Important:

  This program was developed primarily to load
  the historical stock pricess table.

  --save MUST be used to actually save the CSV data to the database

  Usage examples of --add_fields

    -a key:value
    -a ticker:AAPL
    -a 'ticker:AAPL,company:Apple Computer'    NOTE: the single quotes due to space

EOHELP

cli_helper("Copy/Import a CSV file into a RethinkDB table") do |o|

  o.bool    '-s', '--save',       'Save to RDB',  default: false
  o.int     '-p', '--port',       'RDB Port',     default: 28015
  o.string        '--host',       'RDB Host',     default: 'localhost'
  o.string        '--database',   'RDB Database', default: 'analyst_ratings'
  o.string  '-t', '--table',      'RDB Table',    default: 'historical_prices'
  o.string  '-a', '--add_fields', 'Add fields',   default: nil

  o.path    '-c', '--csv_path', 'CSV File Path'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.csv_path = Pathname.new configatron.csv_path

unless configatron.csv_path.exist?
  error "File does not exist: #{configatron.csv_path}"
else
  if configatron.csv_path.directory?
    error "CSV Path is not a file: #{configatron.csv_path}"
  else
    unless '.csv' == configatron.csv_path.extname.downcase
      error "CSV Path is not a CSV file: #{configatron.csv_path}"
    end
  end
end

unless configatron.add_fields.nil?
  entries = configatron.add_fields.split(',')
  NewFields = Hash.new
  entries.each do |entry|
    parts = entry.split(':')
    unless 2 == parts.size
      error "New field entry invalid: #{entry}"
    else
      NewFields[parts.first.downcase.to_sym] = parts.last
    end
  end
end

abort_if_errors


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


begin
  rdb_conn =  r.connect(
                host:   configatron.host,
                port:   Integer(configatron.port),
                db:     configatron.database,
                table:  configatron.table,
              )
rescue Errno::ECONNREFUSED => e
  STDERR.puts e
  STDERR.puts "rethinkdb may not be running on host: #{host}"
  exit(-1)
end

rdb_db     = rdb_conn.use(configatron.database)
rdb_table  = rdb_db.table(configatron.table)


spinner = TTY::Spinner.new("Reading the CSV file: #{configatron.csv_path} ...  :spinner", hide_cursor: true, clear: true, format: :pulse_2)
spinner.auto_spin

records = SmarterCSV.process configatron.csv_path

unless configatron.add_fields.nil?
  records.map!{|record| record.merge(NewFields)}
end

spinner.stop


ap records if debug?

if save?
  bar = ProgressBar.new(records.size)

  puts "Processing Historical Stock Prices ..."

  records.each do |record|
    bar.increment!
    rdb_table.insert(record).run(rdb_conn)
  end
end

rdb_conn.close
