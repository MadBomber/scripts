#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: create_jira_summary_index.rb
##  Desc: Extract the summary component from JIRA *.json files
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'
require 'json'

require 'debug_me'
include DebugMe

require 'cli_helper'
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

summaries = {}

configatron.input_files.each do |filename|
  ticket  = filename.basename(".*").to_s.split('-').last.to_i
  stuff   = JSON.parse(filename.read)
  summary = stuff["fields"]["summary"]
  status  = stuff["fields"]["status"]["name"]
  summaries[ticket] = "#{status} - #{summary}"
end

summaries.sort.each do |ticket|
  printf "%4d - %s\n", ticket[0], ticket[1]
end




