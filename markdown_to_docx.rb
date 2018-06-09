#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: markdown_to_docx.rb
##  Desc: Converts one or more markdown files into docx files
##        using the pandoc utility available via brew
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#
# NOTE: written specifically for md to docx conversion of a directory
#       of files, this utility adapted to other formats as well.
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors
require 'ruby-progressbar'  # Ruby/ProgressBar is a flexible text progress bar library for Ruby.
require 'systemu'           # systemu

require 'debug_me'          # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'        # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

SAME_AS_INPUT = 'same as input'

cli_helper("__file_description__") do |o|

  o.string  '-f', '--from',   'Format of source file',          default: 'markdown'
  o.string  '-t', '--to',     'Format of destination file',     default: 'docx'
  o.string  '-o', '--output', 'Directory to save files',        default: SAME_AS_INPUT
  o.bool          '--skip',   'Skips files that have already been converted', default: false

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, '.md')

if configatron.input_files.empty?
  error 'No *.md files were provided'
end

unless SAME_AS_INPUT == configatron.output
  configatron.output = Pathname.new(configatron.output)
  unless configatron.output.exist?
    error "Specified output directory does not exist: #{configatron.output}"
  else
    unless configatron.output.directory?
      error "Specified output directory is NOT a directory: #{configatron.output}"
    end
  end
end

abort_if_errors

configatron.input_files.map!(&:realpath)
configatron.output = configatron.output.realpath unless SAME_AS_INPUT == configatron.output

######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

files_to_process = configatron.input_files

longest_base_filename_size = 0

files_to_process.each do |a_file_path|
  base_filename   = a_file_path.basename('.*').to_s
  longest_base_filename_size = base_filename.size if base_filename.size > longest_base_filename_size
end

if skip?
  files_to_process = configatron.input_files.select do |a_file_path|
    base_filename   = a_file_path.basename('.*').to_s
    if configatron.output == SAME_AS_INPUT
      file_directory  = a_file_path.parent
    else
      file_directory = configatron.output
    end
    !(file_directory + "#{base_filename}.docx").exist?
  end
end

progressbar = ProgressBar.create(
    title:  'Files', # place holder
    total:  files_to_process.size,
    format: '%t: [%B] %c/%C %j%% %e',
    output: STDOUT
  )

files_to_process.sort.each do |a_file_path|
  base_filename     = a_file_path.basename('.*').to_s
  padding           = " " * (2+(longest_base_filename_size - base_filename.size))
  progressbar.title = base_filename + padding
  progressbar.increment
  # puts "#{base_filename} ..." if verbose?
  file_directory  = (configatron.output == SAME_AS_INPUT) ? a_file_path.parent : configatron.output
  a,b,conversion_errors = systemu "pandoc -f markdown -t docx #{a_file_path} -o #{file_directory+(base_filename+'.docx')}"
  unless conversion_errors.empty?
    STDERR.puts <<~EOS


      The file: #{a_file_path}
      has the following error: #{conversion_errors}
    EOS
  end
end




