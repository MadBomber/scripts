#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: disable.rb
##  Desc: Disable/Enable migrations by their timestamp
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# Assumes that $RR is the current rails root
#

require 'pathname'

RR = Pathname.new ENV['RR']

if RR.exist?  &&  RR.directory?
  # then good
else
  puts <<~EOS

    ERROR: $RR is not a valid Rails.root

  EOS
  exit -1
end

DB_MIGRATE_DIR = RR + 'db/migrate'

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  requires one or more timestamps as parameters

EOHELP

cli_helper("Disable/Enable migrations by their timestamp") do |o|

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end

configatron.timestamps = ARGV

# Error check your stuff; use error('some message') and warning('some message')

if configatron.timestamps.size < 1
  error "requires 1 or more timestamps."
end

abort_if_errors


######################################################
# Local methods

def toggle(migration_path)
  basename = migration_path.basename.to_s

  if basename.end_with?('.disabled')
    # remove
    new_basename = basename.gsub('.disabled','')
    puts "ENABLE #{new_basename}"
  else
    # add
    new_basename = basename + '.disabled'
    puts "DISABLE #{new_basename}"
  end

  new_path = DB_MIGRATE_DIR + new_basename

  system "mv #{migration_path} #{new_path}"  
end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


file_paths = DB_MIGRATE_DIR.children.select do |c| 
  configatron
      .timestamps
      .include?(
        c.basename
          .to_s
          .split('_')&.first
      )
  end

file_paths.each do |migration|
  toggle migration
end
