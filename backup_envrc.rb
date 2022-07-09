#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: backup_envrc.rb
##  Desc: Find all .envrc files and copy them
##        to ~/.envrc_backup directory
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# Why? because sometimes .envrc files are not included in git repos
#
# NOTE: Cannot use mdfind - a MacOS-only tool - because
# spotlight does not index "hidden" files.
#

require 'amazing_print'
require 'date'
require 'pathname'

HOME            = Pathname.new(ENV['HOME'])
BACKUP_DIR      = HOME + '.envrc_backup'
LAST_TIME_PATH  = BACKUP_DIR + 'last_backup_timestamp.txt'
DOCUMENTS_PATH  = HOME + "Documents"

unless LAST_TIME_PATH.exist?
  system "touch -t 200001010000 #{LAST_TIME_PATH}"
end


LAST_BACKUP_TIME  = LAST_TIME_PATH.mtime

home_string       = HOME.to_s
backup_dir_string = BACKUP_DIR.to_s

unless BACKUP_DIR.exist?
  BACKUP_DIR.mkdir
end

unless BACKUP_DIR.directory?
  puts "\nERROR: Not a Directory ~/#{BACKUP_DIR.basename}"
  exit(1)
end



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

print "Finding all the files modified since then ... "
source_files_string  = `cd #{DOCUMENTS_PATH} && find . | fgrep \.envrc`

source_paths  = source_files_string
                  .split("\n")
                  .reject{|f| f.include?(backup_dir_string) }
                  # .select{|f| ".envrc" == f}
                  .map{   |f| DOCUMENTS_PATH + f.chomp.strip }


total_file_count = source_paths.size

source_paths.reject!{ |f| f.mtime < LAST_BACKUP_TIME }

modified_file_count = source_paths.size

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

LAST_TIME_PATH.write(DateTime.now.to_s)

