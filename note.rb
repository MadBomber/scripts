#!/usr/bin/env ruby
# note.rb
#
#   The system environment variable $EDUTIR must be set to a text editor
#
# typical usage is to alias this program to a single character...
#   alias _='~/scripts/note.rb'
# 
# Usage:
#
#   _             Open the _notes.txt file that is closes to pwd
#   _ +           Sets the current directory as a project in the ~/_notes_project_db.json file
#   _ +project    Opens the _notes.txt file for the "project"
#   _ <any text>  Adds <any text> and the clipboard to the close project
#   _ +project <any text>   Add the text to the _notes.txt file for "project"
#


require 'clipboard'
require 'pathname'
require 'json'
require 'date'

NOTES_FILENAME  = "_notes.txt"
notes_dir       = Pathname.pwd
HOME_PATH       = Pathname.new ENV['HOME']
PROJECT_DB_FILE = HOME_PATH + '_notes_project_db.json'


if PROJECT_DB_FILE.exist?
  project_db = JSON.parse(PROJECT_DB_FILE.read)
else
  project_db = Hash.new
end

notes_file = nil

if ARGV.size > 0
  if '+' == ARGV.first
    here                      = Pathname.pwd
    project_name              = here.basename
    project_db[project_name]  = here + NOTES_FILENAME
    f = File.open(PROJECT_DB_FILE, 'w')
    f.puts JSON.pretty_generate(project_db)
    f.close

    notes_file = here + NOTES_FILENAME

    if notes_file.exist?
      puts "Using existing #{NOTES_FILENAME} file."
    else
      puts "Creating new #{NOTES_FILENAME} file for project #{project_name}"
      f = File.open notes_file, 'w'
      f.puts "# Project: #{project_name}"
      f.print "# Started: #{Time.now}\n\n"
      f.close
    end

    puts "Added project #{project_name} to the project database."
    exit
  end

  if ARGV.first.start_with? '+'
    temp          = ARGV.shift
    project_name  = temp[1,999]
    unless project_db.include? project_name
      puts "ERROR: #{project_name} is not in the project database."
      exit -1
    end
    notes_file = Pathname.new project_db[project_name]
  end
end # if ARGV.size > 0


# NOTE: recursive go up the current working directory path looking
#       for a notes file.  Stop at the $HOME directory; create one
#       there or use an existing one.
def get_relevant_notes_file(a_path)
  if a_path.children.include?(a_path + NOTES_FILENAME)
    return a_path + NOTES_FILENAME
  else
    if a_path == HOME_PATH
      return HOME_PATH + NOTES_FILENAME
    else
      return get_relevant_notes_file a_path.parent
    end
  end
end

notes_file = get_relevant_notes_file(Pathname.pwd) if notes_file.nil?

File.open(notes_file, "a") do |f|
  f.print "\n--- #{Time.now}\n"
  f.print "\t#{ARGV.join(' ')}\n\n" unless ARGV.empty?  # .join(' ')
  f.print "\t" + Clipboard.paste.split("\n").join("\n\t")
  f.print "\n\t"*3
end

system "#{ENV['EDITOR']} #{notes_file} &" if ARGV.empty?  &&  !ENV['EDITOR'].nil?

