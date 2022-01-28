#!/usr/bin/env ruby
# note.rb
#
#   The system environment variable $EDUTIR must be set to a text editor
#
# typical usage is to alias this program to a single character...
#   alias _='~/scripts/note.rb'
#
# External System Commands Used:
#   mdfind - makes this Mac-exclusive?
#   xargs
#   agrep
#   pr
#
# Usage:

def usage
  <<~EOS

    Keep and search engineering notes by project.  Notes are
    stored in text files with the name "_notes.txt"  Project
    names associated to each note file are maintained in the
    home directory in the file "_notes_project_db.json"

    Usage:

    alias _=#{__FILE__}

    _ [-h|--help] Prints this usage text

    _             Open the _notes.txt file that is closes to pwd
                    The search is up the directory tree
    _ <any text>  Adds <any text> and the clipboard to the closest project

    _ +           Sets the current directory as a project in the ~/_notes_project_db.json file
    _ +project    Opens the _notes.txt file for the "project"
    _ +project <any text>   Add the text to the _notes.txt file for "project"

    _ [-s|--search] Will search all '_notes.txt' files using the 'agrep' command

    NOTE:

      Every time a new note is added, the _notes.txt file is copied to
      a backup file in the $HOME/_notes_backup directory.  The name of
      the backup file indicates the directory from whihc it came.

  EOS
end



require 'pathname'   # STDLIB
require 'json'       # STDLIB
require 'date'       # STDLIB

require 'load_gems'
load_gems 'clipboard'


NOTES_FILENAME    = "_notes.txt"
notes_dir         = Pathname.pwd
HOME_PATH         = Pathname.new ENV['HOME']
PROJECT_DB_FILE   = HOME_PATH + '_notes_project_db.json'
NOTES_BACKUP_DIR  = HOME_PATH + '_notes_backup'

unless NOTES_BACKUP_DIR.exist?
  NOTES_BACKUP_DIR.mkdir
end


if PROJECT_DB_FILE.exist?
  project_db = JSON.parse(PROJECT_DB_FILE.read)
else
  project_db = Hash.new
end

notes_file = nil

if ARGV.size > 0
  if %w[ -h --help ].include? ARGV.first.downcase
    puts usage
    exit(0)
  end

  if %w[ -s --search ].include? ARGV.first.downcase
    ARGV.shift
    if ARGV.empty?
      puts "ERROR: no search terms were entered."
      exit(-1)
    end
    params = ARGV.join(' ')
    puts "\nSearching for #{params} ..."
    command = "mdfind -name '_notes.txt' | xargs agrep -n #{params} | pr -td"
    system command
    exit(0)
  end

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
      here = a_path.parent
      if '/' == here.to_s
        return HOME_PATH + NOTES_FILENAME
      else
        return get_relevant_notes_file(here)
      end
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

backup_filename = notes_file.relative_path_from(HOME_PATH).to_s.gsub('../','').gsub('/','_')

backup_filename_path = NOTES_BACKUP_DIR + backup_filename

if backup_filename_path.exist?
  `mv #{backup_filename_path} #{backup_filename_path}.bak`
end

`cp #{notes_file} #{backup_filename_path}`

