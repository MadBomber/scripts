#!/usr/bin/env ruby
############################################################
###
##  File: image_resizer.rb
##  Desc: Resize an imaged to a desirable size
#

require 'rmagick'

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Resize image(s) to a standard size/geometry") do |o|

  o.string  '-g', '--geom', 'Geometry (HxV)',    default: '640x480'

end


# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, 
  ['.jpg', '.png', '.gif'])

if configatron.input_files.empty?
  error 'No image files were provided'
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

configatron.input_files.each do |image|

  # SMELL: assumes that there is only one '.' in the file name
  new_file_name = image.to_s.gsub('.', "_#{configatron.geom}.")

  print "Resizing #{image} to #{new_file_name} ... " if verbose?

  img = Magick::Image.read(image)[0]
  img.change_geometry!(configatron.geom) { |cols, rows| img.thumbnail! cols, rows }
  img.write(new_file_name)

  puts "done." if verbose?

end # configatron.input_files.each do |image|

