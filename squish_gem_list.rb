#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: squish_gem_list.rb
##  Desc: Take a list of gem names and get minimum
##        set to install
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'yaml'  # STDLIB
require 'ruby-progressbar'  # Ruby/ProgressBar is a flexible text progress bar library for Ruby.

require 'awesome_print'     # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'          # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'        # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

cli_helper("return minimum set of gems to install") do |o|
  o.path    '-f', '--file',     'file containing gem names',            default: nil
  o.path    '-o', '--output',   'output to file as list of gem names',  default: nil
  o.boolean '-g', '--gemfile',  'output in Gemfile format',             default: false
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

if configatron.file.nil?
  warning("Argument is missing: -f/--file; will use 'gem list' command")
else
  unless !configatron.file.nil? && configatron.file.exist?
    error("File does not exist: #{configatron.file}")
  end
end

unless configatron.arguments.empty?
  warning("Unknown arguments ignored: #{configatron.arguments.join(' ')}")
end


abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  STDERR.puts
  STDERR.puts "Done."
  STDERR.puts
end

ap configatron.to_h  if verbose? || debug?

unless configatron.file.nil?
  array_of_gems = configatron.file.read.split("\n")
else
  array_of_gems = `gem list`.split("\n").map{|g| g.split(' ').first }.select{|g| !g.empty?}
end

gem_count = array_of_gems.size

progressbar = ProgressBar.create(
    title: 'Gems',
    total: gem_count,
    format: '%t: [%B] %c/%C %j%% %e',
    output: STDERR
  )

array_of_gems.each do |g|
  progressbar.increment
  next if g.nil?
  # NOTE: 'gem spec' only works if the gem is installed locally
  spec = YAML.load(`gem spec #{g}`)
  unless spec
    puts g
    next
  end
  depends = spec.dependencies
  depends.each do |d|
    x = array_of_gems.find_index d.name
    array_of_gems[x] = nil unless x.nil?
  end
end

progressbar.finish

array_of_gems.compact!

STDERR.puts "Squeshied from #{gem_count} to #{array_of_gems.size}"

if gemfile?
  puts "source 'https://rubygems.org'\n\n"
  array_of_gems.each do |g|
    puts "gem '#{g}'"
  end
  puts
else
  if configatron.output.nil?
    puts array_of_gems.join("\n")
  else
    outfile = File.new(configatron.output, 'w')
    outfile.puts array_of_gems.join("\n")
  end
end

