#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: picnic_gems.rb
##  Desc: Install gems from a text file
##        used to migrate gems from one ruby verion to another
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'cli_helper'

configatron.version = '0.0.1'

cli_helper("Install gems from a list") do |o|

  o.path    '-p', '--path',   'path to file containing gem names'
  o.int     '-g', '--group',  'group install count', default: 10

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

unless configatron.path.exist?
  error "File does not exist: #{configatron.path.basename}"
else
  if configatron.path.directory?
    error "Directory is not allowed: #{configatron.path.basename}"
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

gems_to_be_installed.shuffle!

until gems_to_be_installed.empty?
  count_down = configatron.group
  while count_down > 0 && gems_to_be_installed.size > 0
    gem_name = gems_to_be_installed.shift
    puts "[#{gems_to_be_installed.size}] Installing #{gem_name} ..."
    `gem install #{gem_name}`
    count_down -= 1
  end
  puts '---'
  list_of_installed_gems = gem_list
  gems_to_be_installed.map!{|g| list_of_installed_gems.include?(g) ? nil : g}
  gems_to_be_installed.compact!
end

