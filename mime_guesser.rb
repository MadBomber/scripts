#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: mime_guesser.rb
##  Desc: Guess the MIME type of a file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'magic'  # ruby-magic v0.5.4

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Guess the MIME type of a file") do |o|
  # Nothing extra
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments)

if configatron.input_files.empty?
  error 'No files were provided'
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

m = Magic.new
max_size = configatron.input_files.map{|f| f.basename.to_s.size}.max + 3

puts

configatron.input_files.each do |f|
  name = f.basename.to_s
  padding = max_size - name.size
  puts "#{name}#{' '*padding} #=> #{m.file(f)}"
end
