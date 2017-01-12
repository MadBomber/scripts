#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: copy_missing_files.rb
##  Desc: Copy missing files from one directory to another
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  The .git and .svn directories are automatically ignored.

EOHELP

cli_helper("__file_description__") do |o|

  o.bool          '--dry_run',    'Do NOT copy any files; just report what whould have happened',   default: false
  o.path    '-s', '--source_dir', 'Source directory from which files are copied'
  o.path    '-t', '--target_dir', 'Target directory to which files are added'
  o.paths   '-i', '--ignore',     'Ignore this comma separated list of file/dir names', default: []

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

if configatron.source_dir.nil? || !configatron.source_dir.exist? || !configatron.source_dir.directory?
  error "Source directory is missing."
end

if configatron.target_dir.nil? || !configatron.target_dir.exist? || !configatron.target_dir.directory?
  error "Target directory is missing."
end

abort_if_errors


if dry_run?
  puts <<-EOS

    #{"== Dry-RUN "* 9} ==

  EOS
end

configatron.source_dir = configatron.source_dir.realpath
configatron.target_dir = configatron.target_dir.realpath

configatron.ignore.map!{|i| i.to_s} unless configatron.ignore.empty?

%w[ .git .svn ].each {|i| configatron.ignore << i}

######################################################
# Local methods

$skipped_files = Array.new

$count = Hash.new
$count[:missing] = 0
$count[:skipped] = 0
$count[:ignored] = 0

def review_directory(a_directory)
  a_directory.children.each do |s|
    source_name     = s.basename.to_s
    if configatron.ignore.include?(source_name)
      $count[:ignored] += 1
      puts "Ignoring #{s}"  if     verbose?  ||  debug?  || dry_run?
      print '-'             unless verbose?  ||  debug?  || dry_run?
      next
    end

    source_relative = s.relative_path_from configatron.source_dir
    target_absolute = configatron.target_dir + source_relative

    if s.directory?
      if target_absolute.exist?
        review_directory s
        next
      else
        # Copy the entire directory
        $count[:missing] += s.children.size
        puts "Copying the entire directory #{s}" if     verbose?  ||  debug?  || dry_run?
        command = "cp -R #{s} #{target_absolute.parent}"
        if dry_run?
          puts command
        else
          system command
          print "*"                                unless verbose?  ||  debug?
        end
      end
    else
      unless target_absolute.exist?
        # Copy an individual file
        $count[:missing] += 1
        puts "Copying #{s}" if     verbose?  ||  debug?  || dry_run?
        command = "cp #{s} #{target_absolute.parent}"
        if dry_run?
          puts command
        else
          system command
          print "."           unless verbose?  ||  debug?  || dry_run?
        end
      else
        # The file already exists in the target location
        $count[:skipped] += 1
        $skipped_files << s
        puts "Skipping #{s}" if verbose?  ||  debug?  || dry_run?
      end
    end
  end
end # def review_directory(a_directory)


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


review_directory configatron.source_dir

puts
ap $count

puts "Skipped files count: #{$skipped_files.size}"

