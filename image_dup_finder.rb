#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: image_dup_finder.rb
##  Desc: Find duplicate images
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

IMAGE_FORMATS_SUPPORTED = ['.jpg', '.png']

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe
require 'ruby-progressbar'  # Ruby/ProgressBar is a flexible text progress bar library for Ruby.

require 'phashion'

require 'cli_helper'        # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Only the following image formats are currently supported:

    #{IMAGE_FORMATS_SUPPORTED.join('  ')}

EOHELP

cli_helper("Find duplicate images") do |o|

end

# Error check your stuff; use error('some message') and warning('some message')


configatron.input_files = get_pathnames_from( configatron.arguments, IMAGE_FORMATS_SUPPORTED )

if configatron.input_files.empty?
  error "No supported image files were provided.  Supported formasts are: #{IMAGE_FORMATS_SUPPORTED}"
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


images = configatron.input_files.map{|c| Phashion::Image.new(c.to_s)}

image_count = images.size

progressbar = ProgressBar.create(
    title: 'Images',
    total: image_count,
    format: '%t: [%B] %c/%C %j%% %e',
    output: STDERR
)


last_one = images.size - 1

images.size.times do |x|
  progressbar.increment

  f1 = images[x]

  (x+1 .. last_one).each do |y|
    f2 = images[y]
    if f1.duplicate? f2
      puts "Duplicates: #{f1.filename} and #{f2.filename}"
    end
  end

end

progressbar.finish

