#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: copy_modified_files.rb
##  Desc: Copy modified files from one directory to another
##        depending upon whether those files have been modified from
##        a base reference directory
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

cli_helper("Copy modified files from one directory to another") do |o|

  o.bool          '--dry_run',        'Do NOT copy any files; just report what whould have happened',   default: false
  o.path    '-s', '--source_dir',     'Source directory from which files are copied'
  o.path    '-t', '--target_dir',     'Target directory to which files are added'
  o.path    '-r', '--reference_dir',  'Reference directory to which files are compared'
  o.paths   '-i', '--ignore',         'Ignore this comma separated list of file/dir names', default: []

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end

# Error check your stuff; use error('some message') and warning('some message')

unless configatron.source_dir.directory?
  error "Source directory is missing."
end

unless configatron.target_dir.directory?
  error "Target directory is missing."
end

unless configatron.reference_dir.directory?
  error "Reference directory is missing."
end

abort_if_errors


if dry_run?
  puts <<-EOS

    #{"== Dry-RUN "* 9} ==

  EOS
end

configatron.source_dir    = configatron.source_dir.realpath
configatron.target_dir    = configatron.target_dir.realpath
configatron.reference_dir = configatron.reference_dir.realpath

%w[ .git .svn ].each { |i| configatron.ignore << (configatron.source_dir + i) }

configatron.ignore.map!{ |i| i.to_s }

######################################################
# Local methods

class Pathname

  def ignored?
    a_string = self.to_s
    result = false
    configatron.ignore.each do |i|
      result ||= a_string.include?(i)
    end
    return result
  end

end # class Pathname

$modified_files = Array.new

$count = Hash.new
$count[:modified]   = 0
$count[:skipped]    = 0
$count[:ignored]    = 0
$count[:unmodified] = 0

def unmodified_file?(reference_path, source_path)
  result = `diff -q '#{reference_path}' '#{source_path}'`
  return result.empty?
end # def unmodified_file?(reference_path, source_path)


def diff_files(source_path, target_path)
  result  = "< source: #{source_path}"
  result += "> target: #{target_path}"
  result += `diff '#{source_path}' '#{target_path}'`
end # def diff_files(source_path, target_path)



def review_directory(a_directory)
  if a_directory.ignored?
    $count[:ignored] += 1
    return(nil)
  end

  a_directory.children.each do |s|
    source_name     = s.basename.to_s
    if s.ignored?
      $count[:ignored] += 1
      puts "Ignoring #{s.relative_path_from(configatron.source_dir)}"  if     verbose?  ||  debug?  || dry_run?
      print '-'             unless verbose?  ||  debug?  || dry_run?
      next
    end

    source_relative     = s.relative_path_from configatron.source_dir
    reference_absolute  = configatron.referebce_dir + source_relative
    target_absolute     = configatron.target_dir    + source_relative

    if s.directory?
      if target_absolute.exist?
        review_directory s
      else
        # Skip the entire directory
        $count[:skipped] += s.children.size
        puts "Skipping the entire directory #{s.relative_path_from(configatron.source_dir)}" if     verbose?  ||  debug?  || dry_run?
      end
      next
    else
      if s.ignored?
        $count[:ignored] += 1
        next
      end
      if target_absolute.exist?
        if unmodified_file?(s,target_absolute)
          $count[:unmodified] += 1
        else
          # Copy an individual file
          $count[:modified] += 1
          $modified_files << s
          puts "Copying #{s.relative_path_from(configatron.source_dir)}" if     verbose?  ||  debug?  || dry_run?
          command = "cp #{s} #{target_absolute.parent}"

          if dry_run?
            puts command
          else
            system command
            print "."           unless verbose?  ||  debug?  || dry_run?
          end
        end
      else
        # The file does not exists in the target location
        $count[:skipped] += 1
        puts "Skipping #{s.relative_path_from(configatron.source_dir)}" if verbose?  ||  debug?  || dry_run?
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

puts
puts "Modified files count: #{$modified_files.size}"

__END__

test_file = Pathname.new('app/exams/valvular-heart-disease.yml')

ref_file  = configatron.reference_dir + test_file
src_file  = configatron.source_dir + test_file
tgt_file  = configatron.target_dir + test_file

if unmodified_file?(ref_file, src_file)
  puts 'unmodified'
else
  puts "="*40
  puts diff_files(src_file, tgt_file)
end



