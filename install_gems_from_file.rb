#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: install_gems_from_file.rb
##  Desc: Take a list of gem names and installs them
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#


require 'yaml'  # STDLIB

require 'awesome_print'     # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'          # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'        # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

cli_helper("return minimum set of gems to install") do |o|
  o.path    '-f', '--file',     'file containing gem names'
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

if configatron.file.nil?
  error("Argument is missing: -f/--file")
end

unless configatron.arguments.empty?
  warning("Unknown arguments ignored: #{configatron.arguments.join(' ')}")
end


abort_if_errors

installed_gems = Gem::Specification.all.map { |gs| gs.name }

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


missing_gems = configatron.file.read.split("\n").sort.uniq - installed_gems.sort.uniq


if missing_gems.empty?
  puts "All gems are already installed"
else
  # command = "gem install #{missing_gems.join(' ')}"
  # puts command
  # system command

  until missing_gems.empty?
    gem_name  = missing_gems.shift
    command   = "gem install #{gem_name}"
    puts command
    system command
    depends = YAML.load(`gem spec #{gem_name}`)
                .dependencies.map{|d| d.name}
    unless depends.empty?
      depends.each {|d| missing_gems.delete d}
    end
  end # until missing_gems.empty?
end # if missing_gems.empty?

