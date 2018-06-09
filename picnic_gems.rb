#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: picnic_gems.rb
##  Desc: Install gems from a text file
##        used to migrate gems from one ruby verion to another
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'cli_helper'  # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

temp_gemfile = Pathname.new(ENV['HOME']) + 'temp' + 'temp_gemfile'

configatron.version = '0.0.1'

cli_helper("Install gems from a list") do |o|

  o.path    '-p', '--path',   '(required) path to file containing gem names'
  o.int     '-g', '--group',  'group install count', default: 10

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

if configatron.path.nil?
  error "--path is required."
else
  unless configatron.path.exist?
    error "File does not exist: #{configatron.path.basename}"
  else
    if configatron.path.directory?
      error "Directory is not allowed: #{configatron.path.basename}"
    end
  end
end


abort_if_errors

gems_to_be_installed = configatron.path.readlines.map{|a_line| a_line.chomp}

######################################################
# Local methods

def gem_list
  list_of_gems = `gem list | cut -d' ' -f1`
  list_of_gems.split("\n")
end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


list_of_installed_gems = gem_list
gems_to_be_installed.map!{|g| list_of_installed_gems.include?(g) ? nil : g}

gems_to_be_installed.compact!

original_gems_to_be_installed = gems_to_be_installed.dup

group = configatron.group

until gems_to_be_installed.empty?

  gems = gems_to_be_installed.shift(group)

  tgf = File.open(temp_gemfile, 'w')
  tgf.puts <<-EOS
# temporary file to take advantage of bundler's multi-threaded install capability
source 'https://rubygems.org'
EOS
  gems.each do |gem|
    tgf.puts "gem '#{gem}'"
  end
  tgf.close

  puts "[#{gems_to_be_installed.size}] Installing #{gems.join(' ')} ..."
  # NOTE: 'gem install' is single threaded regardless of the number of gems on the command line
  # `gem install #{gems.join(' ')}`

  # NOTE: 'bundle install --jobs X' is multi-threaded
  # SMELL: if bundler encounters an error while installing a gem it aborts all jobs
  `bundle install --jobs #{group} --gemfile #{temp_gemfile}`

end # until gems_to_be_installed.empty?


list_of_installed_gems = gem_list
left_overs = original_gems_to_be_installed.map{|g| list_of_installed_gems.include?(g) ? nil : g}

unless left_overs.empty?
  puts "\nThe following gems were not installed:"
  print "\n  "
  puts left_overs.join("\n  ")
  puts
  puts "Trying again ..."
  `gem install #{left_overs.join(' ')}`
end



