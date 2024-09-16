#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: install_gems_from_file.rb
##  Desc: Take a list of gem names from a file and installs them
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)

# Ensure that required gems are installed
`gem install amazing_print debug_me cli_helper`

require 'yaml'                  # STDLIB
require 'amazing_print'         # Pretty print Ruby objects with proper indentation and colors
require 'debug_me'              # A tool to print the labeled value of variables.
require 'cli_helper'            # An encapsulation of an integration of slop, nenv, inifile and configatron.
require 'set'                   # For storing installed gems
include DebugMe
include CliHelper

configatron.version = '0.0.2'

cli_helper("Return minimum set of gems to install") do |o|
  o.path    '-f', '--file',       'File containing gem names'
  o.integer '-b', '--batch-size', 'Number of gems to fetch at once', default: 20
end

# Display the usage info
if ARGV.empty?
  show_usage
  exit
end

# Error check parameters
if configatron.file.nil?
  error("Argument is missing: -f/--file")
end

unless configatron.arguments.empty?
  warning("Unknown arguments ignored: #{configatron.arguments.join(' ')}")
end

abort_if_errors

# Use Set for faster inclusion check
installed_gems = Set.new(Gem::Specification.map(&:name))

######################################################
# Main

at_exit do
  unless $problem_gems.empty?
    STDERR.puts
    STDERR.puts "The following gems had problems during installation:"
    STDERR.puts $problem_gems.join('  ')
  end
  STDERR.puts
  STDERR.puts "Done."
  STDERR.puts
end

ap configatron.to_h if verbose? || debug?

missing_gems = configatron.file.read.split("\n").map(&:strip).uniq.reject(&:empty?) - installed_gems.to_a

$problem_gems = []

if missing_gems.empty?
  puts "All gems are already installed"
else
  until missing_gems.empty?
    gem_names = missing_gems.shift(configatron.batch_size)

    # Collect the gems that are not installed
    gem_names.reject! { |gem_name| installed_gems.include?(gem_name) }

    next if gem_names.empty?

    command = "gem install #{gem_names.join(' ')}"
    puts "Executing: #{command}"

    begin
      system command
      gem_names.each do |gem_name|
        # Check for dependencies of the installed gems
        begin
          dependencies = YAML.load(`gem spec #{gem_name}`).dependencies.map(&:name)
          dependencies.each { |dep| missing_gems.delete(dep) }
          installed_gems.add(gem_name) # Add to installed gems after successful install
        rescue Psych::DisallowedClass
          # NO-OP
        rescue => e
          $problem_gems << gem_name
          STDERR.puts "Could not retrieve dependencies for #{gem_name}: #{e}"
        end
      end
    rescue => e
      $problem_gems << gem_names.join(', ')
      print "\n...ERROR #{e.message} ...\n\n"
    end
  end # until missing_gems.empty?
end # if missing_gems.empty?
