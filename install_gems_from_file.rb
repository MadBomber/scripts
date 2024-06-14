#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: install_gems_from_file.rb
##  Desc: Take a list of gem names from a file and installs them
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'bundler/inline'

gemfile true do
  source 'https://rubygems.org'
  gem 'amazing_print'
  gem 'debug_me'
  gem 'cli_helper'
end


require 'yaml'  # STDLIB

require 'amazing_print'     # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'          # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'        # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.2'

cli_helper("return minimum set of gems to install") do |o|
  o.path    '-f', '--file',       'file containing gem names'
  o.integer '-b', '--batch-size', 'Number of gems to fetch at once', default: 20
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
  unless $problem_gems.empty?
    STDERR.puts
    STDERR.puts "The following gems had problems durning installation:"
    STDERR.puts $problem_gems.join('  ')
  end
  STDERR.puts
  STDERR.puts "Done."
  STDERR.puts
end

ap configatron.to_h  if verbose? || debug?


missing_gems = configatron.file.read.split("\n").sort.uniq - installed_gems.sort.uniq

$problem_gems = Array.new

if missing_gems.empty?
  puts "All gems are already installed"
else
  until missing_gems.empty?
    gem_names = []

    configatron.batch_size.times do
      gem_names << missing_gems.shift
    end

    command   = "gem install #{gem_names.join(' ')}"
    puts command

    begin
      system command

      begin
        gem_names.each do |gem_name|
          depends = YAML.load(`gem spec #{gem_name}`)
                      .dependencies.map{|d| d.name}
          unless depends.empty?
            depends.each {|d| missing_gems.delete d}
          end
        end
      rescue Psych::DisallowedClass
        # NO-OP
      end

    rescue Exception => e
      $problem_gems << gem_names
      print "\n...ERROR #{e} ...\n\n"
    end
  end # until missing_gems.empty?
end # if missing_gems.empty?

