#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: docx_to_txt.rb
##  Desc: Convert docx files to txt files
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'
include DebugMe

require 'pathname'
require 'pathname_helpers'

require 'docx'
require 'docx_helpers'
include DocxHelpers


me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  debug:          false,
  docx_pathnames: []
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end


usage = <<EOS

Convert any docx file into a simple txt file.

Usage: #{my_name} [options] files_or_directories

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress

  files_or_directories  The locations of docx files

EOS

# Check command line for Problems with Parameters
$errors   = []
$warnings = []


# Get the next ARGV parameter after param_index
def get_next_parameter(param_index)
  unless Fixnum == param_index.class
    param_index = ARGV.find_index(param_index)
  end
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
    STDERR.print "\nAbort program? (y/N) "
    answer = (gets).chomp.strip.downcase
    $errors << "Aborted by user" if answer.size>0 && 'y' == answer[0]
    $warnings = []
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

%w[ -d --debug ].each do |param|
  if ARGV.include? param
    $options[:debug]          = true
    ARGV[ ARGV.index(param) ] = nil
  end
end


ARGV.compact!


def add_children_to_list(a_directory)
  return unless a_directory.exist?
  return unless a_directory.directory?
  a_directory.children.each do |c|
    add_children_to_list(c) if c.directory?
    next unless '.docx' == c.extname.downcase
    $options[:docx_pathnames] << c.realpath
  end
end

ARGV.each do |arg|
  file_path = Pathname.new arg
  next unless file_path.exist?
  add_children_to_list(file_path) if file_path.directory?
  next unless '.docx' == file_path.extname.downcase
  $options[:docx_pathnames] << file_path.realpath
end

if $options[:docx_pathnames].empty?
  $errors << 'No docx files were found'
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

pp $options  if verbose? || debug?


$options[:docx_pathnames].each do |docx_path|

  puts docx_path.basename

  txt_path = Pathname.new( docx_path.to_s.gsub('.docx', '.txt') )
  docx = open_docx(docx_path)

  txt_file = File.open(txt_path, 'w')

  docx.paragraphs.each do |a_para|
    txt_file.puts a_para.text
  end

  txt_file.close

end


