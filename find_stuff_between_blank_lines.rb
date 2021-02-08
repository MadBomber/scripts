#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: find_stuff_between_blank_lines.rb
##  Desc: Does what I used agrep to do
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

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

cli_helper("Find stuff between blank lines") do |o|
  o.path    '-p', '--path',   'Path to *.txt file to search'
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

if configatron.path.nil?  ||  !configatron.path.exist?
  error "Invalid or no file path was specified.  Use -p to specify the path to the file to search."
else
  unless '.txt' == configatron.path.extname.downcase
    error "Only *.txt files can be search; path: #{configatron.path}"
  end
end

if configatron.arguments.empty?
  error "No search terms were specified."
end

abort_if_errors


######################################################
# Local methods

def reduce_to_ranges(a_lines, array_of_x)
  ranges = []
  array_of_x.each do |x|
    start_x = x - 1
    until start_x <= 0 or a_lines[start_x].empty?
      start_x -= 1
    end
    end_x = x + 1
    until end_x >= a_lines.size or a_lines[end_x].empty?
      end_x += 1
    end
    ranges << (start_x .. end_x)
  end
  return ranges.uniq
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


a_lines = configatron.path.readlines.map{|a_line| a_line.strip}


configatron.arguments.each do |search_term|
  puts "Searching for #{search_term} ..."
  found_array = a_lines.each_index.select{|x| a_lines[x].downcase.include?(search_term.downcase)}

  if debug?
    ap found_array
    puts
  end

  ranges = reduce_to_ranges a_lines, found_array

  if debug?
    ap ranges
    puts
  end

  ranges.each do |a_range|
    puts "Range: #{a_range}"
    a_range.each do |x|
      puts "#{x}: #{a_lines[x]}"
    end
    puts
  end

end
