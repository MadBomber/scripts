#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: docx_rm_blank_paragraphs.rb
##  Desc: Removes blank paragraphs from an MS *.docx file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'  # A tool to print the labeled value of variables.

require 'fileutils' # STDLIB

require 'pathname'  # STDLIB
require 'pathname_helpers'

require 'docx'      # a ruby library/gem for interacting with .docx files
require 'docx_helpers'
include DocxHelpers


me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  in_filenames:   []
}

def verbose?
  $options[:verbose]
end


usage = <<EOS

Removes blank paragraphs from an MS *.docx file

Usage: #{my_name} [options] filenames+

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress

  filenames+            One or more *.docx filenames

NOTE:

  Something_imporatant

EOS

# Check command line for Problems with Parameters
$errors   = []
$warnings = []


# Get the next ARGV parameter after param_index
def get_next_parameter(param_index)
  next_parameter = nil
  if param_index+1 >= ARGV.size
    $errors << "#{ARGV[param_index]} specified without parameter"
  else
    next_parameter = ARGV[param_index+1]
    ARGV[param_index+1] = nil
  end
  ARGV[param_index] = nil
  return next_parameter
end # def get_next_parameter(param_index)


# Get $options[:out_filename]
def get_out_filename(param_index)
  filename_str = get_next_parameter(param_index)
  $options[:out_filename] = Pathname.new( filename_str ) unless filename_str.nil?
end # def get_out_filename(param_index)


# Display global warnings and errors arrays and exit if necessary
def abort_if_errors
  unless $warnings.empty?
    STDERR.puts
    STDERR.puts "The following warnings were generated:"
    STDERR.puts
    $warnings.each do |w|
      STDERR.puts "\tWarning: #{w}"
    end
    STDERR.puts
  end
  unless $errors.empty?
    STDERR.puts
    STDERR.puts "Correct the following errors and try again:"
    STDERR.puts
    $errors.each do |e|
      STDERR.puts "\t#{e}"
    end
    STDERR.puts
    exit(-1)
  end
end # def abort_if_errors


# Display the usage info
if  ARGV.empty?               ||
    ARGV.include?('-h')       ||
    ARGV.include?('--help')
  puts usage
  exit
end

%w[ -v --verbose ].each do |param|
  if ARGV.include? param
    $options[:verbose]        = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

ARGV.compact!

ARGV.each do |a_file|
  a_path = Pathname.new a_file
  unless '.docx' == a_path.extname
    $warnings << "Not a *.docx file: #{a_file}"
  else
    $options[:in_filenames] << a_path.realpath
  end
end

if $options[:in_filenames].empty?
  $errors << "No *.docx files were specified"
end

abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

pp $options

$options[:in_filenames].each do |a_path|
  print "Processing #{a_path.basename} ... " if verbose?
  a_path.backup
  docx = open_docx(a_path.backup_path)

  docx.paragraphs.each do |a_para|
    content = a_para.text.chomp.strip
    delete_paragraph(a_para)  if content.empty?
  end

  docx.save(a_path)

  print '.' unless verbose?
  puts "done" if verbose?
end
