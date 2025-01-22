#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: backup_just.rb
##  Desc: Find all *.just, *.justfile and */justfile files and copy them
##        to ~/.just_backup directory
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# NOTE: Uses 'mdfind' which is a MacOS-only tool ???
#

require 'date'
require 'pathname'
require 'tempfile'


HOME           = Pathname.new(ENV['HOME'])
BACKUP_DIR     = HOME + '.just_backup'
LAST_TIME_PATH = BACKUP_DIR + 'last_backup_timestamp.txt'

home_string       = HOME.to_s
BACKUP_DIR_STRING = BACKUP_DIR.to_s

unless BACKUP_DIR.exist?
  BACKUP_DIR.mkdir
end

unless BACKUP_DIR.directory?
  puts "\nERROR: Not a Directory ~/#{BACKUP_DIR.basename}"
  exit(1)
end

# Handle the case where LAST_TIME_PATH doesn't exist
if LAST_TIME_PATH.exist?
  LAST_BACKUP_TIME = LAST_TIME_PATH.mtime
else
  # If the file doesn't exist, use a default time (e.g., 24 hours ago)
  LAST_BACKUP_TIME = Time.now - 86400*365 # set the time to last year
  puts "No previous backup timestamp found. Using default: #{LAST_BACKUP_TIME}"
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

puts
puts "Last backup was: #{LAST_BACKUP_TIME}"
puts

puts "Finding all the files modified since then ... "

# Define a method to filter files with specific extensions
def filter_files(tempfile_path)
  File.readlines(tempfile_path)
    .reject{|line| line.include?(BACKUP_DIR_STRING) }
    .map{|line| line.strip}
    .select{|line| 
      line.end_with?('.just')     ||
      line.end_with?('justfile')
    }
    .map{|line| Pathname.new(line)}
end


def with_tempfile
  just_files = [] # set the context

  Tempfile.create('tempfile') do |tempfile|
    system("rg --files -uu ~/ 2> /dev/null > #{tempfile.path}")

    just_files = filter_files(tempfile.path)
  end

  just_files
end

source_paths = with_tempfile

total_file_count = source_paths.size

source_paths.reject!{|f| 
  f.mtime < LAST_BACKUP_TIME 
}

modified_file_count = source_paths.size

puts "done"

print "Creating target paths ... "


target_paths = []

source_paths.each do |source|
  target_paths << Pathname.new( source.to_s.gsub(home_string, BACKUP_DIR_STRING) )
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

LAST_TIME_PATH.write(DateTime.now.to_s)

