#!/usr/bin/env ruby
# note.rb
#
#   The system environment variable $EDITOR must be set to a text editor
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
# TODO: refactor this utility to use the power of obsidian and
#       its daily notes system to become a more powerful PKM.

require 'pathname'   # STDLIB
require 'yaml'       # STDLIB
require 'date'       # STDLIB
require 'shellwords' # STDLIB for security
require 'fileutils'  # STDLIB for file operations

require 'load_gems'   # from lib/ruby
load_gems 'clipboard'

class NoteManager
  NOTES_FILENAME    = "_notes.txt"
  HOME_PATH         = Pathname.new ENV['HOME']
  PROJECT_DB_FILE   = HOME_PATH + '_notes_project_db.yaml'
  NOTES_BACKUP_DIR  = HOME_PATH + '_notes_backup'

  def initialize
    ensure_backup_directory
    @project_db = load_project_db
    @notes_file = nil
  end

  def run(args)
    if args.empty?
      # No arguments - just open the nearest notes file
      @notes_file = get_relevant_notes_file(Pathname.pwd)
      append_note(@notes_file, [])
      backup_notes_file(@notes_file)
      open_in_editor(@notes_file)
    else
      process_arguments(args)
    end
  end

  private

  def ensure_backup_directory
    NOTES_BACKUP_DIR.mkdir unless NOTES_BACKUP_DIR.exist?
  end

  def process_arguments(args)
    case args.first.downcase
    when '-h', '--help'
      puts usage
      exit(0)
      
    when '-s', '--search'
      args.shift
      if args.empty?
        puts "ERROR: no search terms were entered."
        exit(-1)
      end
      search_notes(args.join(' '))
      exit(0)
      
    when '-l', '--list'
      list_projects
      exit(0)
    end
    
    # Handle project removal
    if args.first.start_with?('-') && !args.first.start_with?('--')
      project_name = args.first[1..]
      remove_project(project_name)
      exit(0)
    end
    
    # Handle project addition or selection
    if '+' == args.first
      here = Pathname.pwd
      project_name = here.basename.to_s
      @notes_file = add_project(project_name, here)
      args.shift
      
    elsif args.first.start_with?('+')
      project_name = args.shift[1..]
      unless @project_db.include?(project_name)
        puts "ERROR: #{project_name} is not in the project database."
        puts "Available projects:"
        list_projects
        exit(-1)
      end
      @notes_file = Pathname.new(@project_db[project_name])
    end

    # Get the relevant notes file if not already set
    @notes_file = get_relevant_notes_file(Pathname.pwd) if @notes_file.nil?

    # Append note and/or open editor
    append_note(@notes_file, args)
    backup_notes_file(@notes_file)

    # Open in editor if no arguments remain
    open_in_editor(@notes_file) if args.empty?
  end

  def usage
    <<~EOS

      Keep and search engineering notes by project.  Notes are
      stored in text files with the name "_notes.txt"  Project
      names associated to each note file are maintained in the
      home directory in the file "_notes_project_db.yaml"

      Usage:

      alias _=#{$0}

      _ [-h|--help] Prints this usage text

      _             Open the _notes.txt file that is closest to pwd
                      The search is up the directory tree
      _ <any text>  Adds <any text> and the clipboard to the closest project

      _ +           Sets the current directory as a project in the file
                    #{PROJECT_DB_FILE.basename}

      _ +project    Opens the _notes.txt file for the "project"

      _ +project <any text>   Add the text to the _notes.txt file for "project"

      _ [-s|--search] Will search all '_notes.txt' files using the 'agrep' command

      _ [-l|--list]   Lists all projects in the database

      _ -project      Removes the project from the database

      NOTE:

        Every time a new note is added, the _notes.txt file is copied to
        a backup file in the $HOME/_notes_backup directory.  The name of
        the backup file indicates the directory from which it came.

    EOS
  end

  # NOTE: recursive go up the current working directory path looking
  #       for a notes file.  Stop at the $HOME directory; create one
  #       there or use an existing one.
  def get_relevant_notes_file(a_path)
    notes_path = a_path.join(NOTES_FILENAME)
    if notes_path.exist?
      return notes_path
    else
      if a_path == HOME_PATH
        return HOME_PATH.join(NOTES_FILENAME)
      else
        here = a_path.parent
        if '/' == here.to_s
          return HOME_PATH.join(NOTES_FILENAME)
        else
          return get_relevant_notes_file(here)
        end
      end
    end
  end

  def load_project_db
    if PROJECT_DB_FILE.exist?
      begin
        YAML.load_file(PROJECT_DB_FILE) || {}
      rescue => e
        STDERR.puts "Warning: Error parsing project database: #{e.message}"
        STDERR.puts "Creating new database..."
        {}
      end
    else
      {}
    end
  end

  def save_project_db
    File.write(PROJECT_DB_FILE, @project_db.to_yaml)
  rescue => e
    STDERR.puts "Error saving project database: #{e.message}"
    exit(-1)
  end

  def list_projects
    if @project_db.empty?
      puts "No projects in database."
    else
      puts "\nProjects in database:"
      puts "-" * 50
      @project_db.each do |name, path|
        puts "  #{name.ljust(20)} => #{path}"
      end
      puts "-" * 50
    end
  end

  def remove_project(project_name)
    if @project_db.delete(project_name)
      save_project_db
      puts "Removed project '#{project_name}' from the database."
    else
      puts "Project '#{project_name}' not found in database."
      exit(-1)
    end
  end

  def search_notes(search_terms)
    params = Shellwords.escape(search_terms)
    puts "\nSearching for #{search_terms} ..."
    command = "mdfind -name '_notes.txt' | xargs agrep -n #{params} | pr -td"
    system command
  end

  def add_project(project_name, project_path)
    notes_file = project_path.join(NOTES_FILENAME)
    @project_db[project_name] = notes_file.to_s
    save_project_db
    
    if notes_file.exist?
      puts "Using existing #{NOTES_FILENAME} file."
    else
      puts "Creating new #{NOTES_FILENAME} file for project #{project_name}"
      File.write(notes_file, "# Project: #{project_name}\n# Started: #{Time.now}\n\n")
    end
    
    puts "Added project #{project_name} to the project database."
    notes_file
  end

  def backup_notes_file(notes_file)
    backup_filename = notes_file.relative_path_from(HOME_PATH).to_s.gsub('../','').gsub('/','_')
    backup_filename_path = NOTES_BACKUP_DIR.join(backup_filename)
    
    if backup_filename_path.exist?
      FileUtils.mv(backup_filename_path.to_s, "#{backup_filename_path}.bak")
    end
    
    FileUtils.cp(notes_file.to_s, backup_filename_path.to_s)
  rescue => e
    STDERR.puts "Warning: Could not backup notes file: #{e.message}"
  end

  def append_note(notes_file, text_array)
    File.open(notes_file, "a") do |f|
      f.print "\n--- #{Time.now}\n"
      f.print "    #{text_array.join(' ')}\n\n" unless text_array.empty?
      
      begin
        clipboard_content = Clipboard.paste
        if clipboard_content && !clipboard_content.empty?
          f.print "  " + clipboard_content.split("\n").join("\n\t")
        end
      rescue => e
        STDERR.puts "Warning: Could not paste clipboard: #{e.message}"
      end
      
      f.print "\n" * 3
    end
  end

  def open_in_editor(notes_file)
    editor = ENV['EDITOR']
    if editor && !editor.empty?
      begin
        system(editor, notes_file.to_s, "&")
      rescue => e
        STDERR.puts "Error launching editor: #{e.message}"
        STDERR.puts "Please check your $EDITOR environment variable"
      end
    else
      STDERR.puts "Warning: $EDITOR environment variable not set"
    end
  end
end

# Main execution
if __FILE__ == $0
  manager = NoteManager.new
  manager.run(ARGV)
end