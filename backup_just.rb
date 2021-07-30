#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: backup_just.rb
##  Desc: Find all *.just and */justfile files and copy them
##        to ~/.just_backup directory
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'date'
require 'pathname'

HOME        = Pathname.new(ENV['HOME'])
BACKUP_DIR  = HOME + '.just_backup'

home_string       = HOME.to_s
backup_dir_string = BACKUP_DIR.to_s

unless BACKUP_DIR.exist?
  BACKUP_DIR.mkdir
end

unless BACKUP_DIR.directory?
  puts "\nERROR: Not a Directory ~/#{BACKUP_DIR.basename}"
  exit(1)
end

require 'amazing_print'

require 'debug_me'
include DebugMe


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

print "Finding all the files ... "
source_files_string  = `find $HOME -name '*.just' -exec echo "{}<br/>" \\;`
source_files_string += `find $HOME -name 'justfile' -exec echo "{}<br/>" \\;`

source_paths  = source_files_string
                  .gsub('<br/>', "\n")
                  .split("\n")
                  .reject{|f| f.include?(backup_dir_string) }
                  .map{   |f| Pathname.new(f.chomp.strip)   }

puts "done"

print "Creating target paths ... "


target_paths = []

source_paths.each do |source|
  target_paths << Pathname.new( source.to_s.gsub(home_string, backup_dir_string) )
end

puts "done"

puts "Copy files to backup ... "
  (0..source_paths.size-1).each do |inx|
    directory = target_paths[inx].parent
    directory.mkpath
    command = "cp -f '#{source_paths[inx]}' '#{target_paths[inx]}'"
    puts command
    `#{command}`
  end
puts "done"

last_backup_timestamp = BACKUP_DIR + 'last_backup_timestamp.txt'

last_backup_timestamp.write(DateTime.now.to_s)

