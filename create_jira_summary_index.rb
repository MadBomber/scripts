#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: create_jira_summary_index.rb
##  Desc: Extract the summary component from JIRA *.json files
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'json'           # STDLIB

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("__file_description__") do |o|

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, '.json')

if configatron.input_files.empty?
  error 'No json files were provided'
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

summaries = []

configatron.input_files.each do |filename|
  stuff   = JSON.parse(filename.read)
  key     = stuff["key"]
  summary = stuff["fields"]["summary"]
  desc    = stuff["fields"]["description"]
  status  = stuff["fields"]["status"]["name"]
  summaries << "#{key} - #{status} - #{summary}"
end

summaries.sort.each do |ticket|
  puts ticket
end




