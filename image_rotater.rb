#!/usr/bin/env ruby
############################################################
###
##  File: image_rotater.rb
##  Desc: Rotate an imaged to a desired degree
#

require 'rmagick'

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors

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

  o.integer '-r', '--rotate', 'Rotate +/- degrees'

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

degrees = configatron.rotate

#### Used to generate some test images for face
#### alignment detection.
####
#### degrees = -180

configatron.input_files.each do |image|

#### while degrees <= 180 do

  # SMELL: assumes that there is only one '.' in the file name
  new_file_name = image.to_s.gsub('.', "_#{degrees}.")
  
  img = Magick::Image.read(image)[0]

  print "rotating #{degrees}  degrees ..." if verbose?
  
  img.rotate!(degrees)
  
  puts "done." if verbose?

  img.write(new_file_name)

  degrees += 15

#### end

end # configatron.input_files.each do |image|

