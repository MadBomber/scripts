#!/usr/bin/env ruby
############################################################
###
##  File: image_renamer.rb
##  Desc: Renames image files to a standard naming convention
##
##  Convention:   img_NNNN.xxx
##
##    where:  MMMM is a zero-filed number and xxx is the file extension
#

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Resize image(s) to a standard size/geometry") do |o|

  o.int  '-s', '--serial',    'Starting serial number',     default: 500
  o.int  '-i', '--increment', 'Increment',                  default:  10
  o.int  '-w', '--width',     'Width of a serial number',   default:   4

end


# Display the usage info
if  ARGV.empty?   ||  ARGV.include?('-h')  ||  ARGV.include?('--help')
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

if configatron.width >=4  &&  configatron.width <= 12
  FILENAME_FORMAT = "img_%0#{ configatron.width }d%s"
  MAX_SERIAL = 10**configatron.width
else
  error "Serial must be in the range: 4..12"
end


if configatron.serial >= MAX_SERIAL  ||  configatron.serial < 0
  error "Invalid starting serial number; no negaitives and < 10000"
end

if configatron.increment <= 0
  error "serial number increment can not be zero or negative"
end

configatron.input_files = get_pathnames_from( configatron.arguments, 
  ['.jpg', '.png', '.gif'])

if configatron.input_files.empty?
  error 'No image files were provided'
end

abort_if_errors



file_count = configatron.input_files.size
last_serial = configatron.serial + (configatron.increment * file_count)

if last_serial >= MAX_SERIAL
  error "Given the number of files (#{file_count}), starting serial number (#{configatron.serial}) and increment (#{configatron.increment}) the max serial number (#{MAX_SERIAL}) is exceeded"
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

ap configatron.to_h  if debug?

serial = configatron.serial

configatron.input_files.each do |old_file_path|

  new_file_name = sprintf(FILENAME_FORMAT, serial, old_file_path.extname)
  command       =  "mv #{old_file_path} #{ old_file_path.parent + new_file_name  }"
  puts "Command: " + command + " ..." if verbose?

  serial        = serial + configatron.increment
  system command  unless debug?

end # configatron.input_files.each do |old_file_path|

