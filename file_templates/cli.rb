#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: __file_name__.rb
##  Desc: __file_description__
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'
include DebugMe

require 'pathname'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  debug:          false,
  out_filename:   nil
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end


usage = <<EOS

__file_description__

Usage: #{my_name} [options] parameters

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress
    -o or --output      Specifies the path to the output
        out_filename      file.  The extname must be 'ics'
                          Defaults to STDOUT

  parameters            The parameters required by
                        the program

NOTE:

  Something_imporatant

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


# only gets valid files of one type
def get_pathnames_from(an_array, extnames=['.json', '.txt', '.docx'])
  an_array = [an_array] unless an_array.is_a? Array
  extnames = [extnames] unless extnames.is_a? Array
  extnames = extnames.map{|e| e.downcase}
  file_array = []
  an_array.each do |a|
    pfn = Pathname.new(a)
    if pfn.directory?
      file_array << get_pathnames_from(pfn.children, extnames)
    else
      file_array << pfn if pfn.exist? && extnames.include?(pfn.extname.downcase)
    end
  end
  return file_array.flatten
end # def get_pathnames_from(an_array, extname='.json')


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

%w[ -o --output ].each do |param|
  get_out_filename( ARGV.index(param) ) if ARGV.include?(param)
  unless $options[:out_filename].nil?
    unless $options[:out_filename].parent.exist?
      $errors << "Directory does not exist: #{$options[:out_filename].parent}"
    end
  end
end


ARGV.compact!

# ...

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

stub = <<EOS


   d888888o. 8888888 8888888888 8 8888      88 8 888888888o
 .`8888:' `88.     8 8888       8 8888      88 8 8888    `88.
 8.`8888.   Y8     8 8888       8 8888      88 8 8888     `88
 `8.`8888.         8 8888       8 8888      88 8 8888     ,88
  `8.`8888.        8 8888       8 8888      88 8 8888.   ,88'
   `8.`8888.       8 8888       8 8888      88 8 8888888888
    `8.`8888.      8 8888       8 8888      88 8 8888    `88.
8b   `8.`8888.     8 8888       ` 8888     ,8P 8 8888      88
`8b.  ;8.`8888     8 8888         8888   ,d8P  8 8888    ,88'
 `Y8888P ,88P'     8 8888          `Y88888P'   8 888888888P


EOS

puts stub

