#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: get_db_relationships.rb
##  Desc: extract the has_ and belongs_ relationships for ActiveRecord::Base classes
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper


HERE = Pathname.pwd # where program was started


configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("extract the has_ and belongs_ relationships for ActiveRecord::Base classes") do |o|
  o.path    '-p', '--path',   'Root path to the models'
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

unless configatron.path.exist?
  error "#{configatron.path} does not exist"
end

abort_if_errors


######################################################
# Local methods

def extract_relationships_from(a_path)
  content = a_path.read.squeeze(" ")

  return nil unless content.include?("< ActiveRecord::Base")

  lines = content.split("\n").map{|x| x.chomp.strip}

  puts "----" # used as a record seperate for agrep
  puts a_path.relative_path_from(HERE).to_s

  lines.each do |a_line|
    puts a_line if a_line.start_with? "module"
    puts a_line if a_line.start_with? "class"
    puts a_line if a_line.start_with? "belongs_"
    puts a_line if a_line.start_with? "has_"
  end



  return
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

paths = Dir.glob(configatron.path.to_s+"/**/*.rb").map{|f| HERE + f}

paths.each do |a_path|
  extract_relationships_from a_path
end

