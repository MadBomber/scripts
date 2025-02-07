#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: backup_envrc.rb
##  Desc: Find all .envrc files and copy them to
##        ~/.envrc_backup directory
##  By:   [Your Name]
#

require 'date'
require 'pathname'
require 'tempfile'

HOME           = Pathname.new(ENV['HOME'])
BACKUP_DIR     = HOME + '.envrc_backup'
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
  # If the file doesn't exist, use a default time
  LAST_BACKUP_TIME = Time.now - 86400*365 # set to last year
  puts "No previous backup timestamp found. Using default: #{LAST_BACKUP_TIME}"
end

require 'amazing_print'

require 'debug_me'
include DebugMe

######################################################
# Local methods

def filter_files(tempfile_path:)
  File.readlines(tempfile_path)
    .reject { |line| line.include?(BACKUP_DIR_STRING) }
    .map(&:strip)
    .select { |line| line.end_with?('.envrc') }
    .map { |line| Pathname.new(line) }
end

def with_tempfile
  envrc_files = []

  Tempfile.create('tempfile') do |tempfile|
    system("rg --files -uu ~/ 2> /dev/null > #{tempfile.path}")
    envrc_files = filter_files(tempfile_path: tempfile.path)
  end

  envrc_files
end

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

puts "Finding all .envrc files modified since then ... "

source_paths = with_tempfile

total_file_count     = source_paths.size
source_paths.reject! { |f| f.mtime < LAST_BACKUP_TIME }
modified_file_count  = source_paths.size

puts "done"

print "Creating target paths ... "

target_paths = source_paths.map do |source|
  Pathname.new(source.to_s.gsub(home_string, BACKUP_DIR_STRING))
end

puts "done"

puts "Copy files to backup ... "
source_paths.zip(target_paths).each do |source, target|
  target.parent.mkpath
  command = "cp -f '#{source}' '#{target}'"
  puts command
  `#{command}`
end
puts "done"

LAST_TIME_PATH.write(DateTime.now.to_s)
