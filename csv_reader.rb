#!/usr/bin/env ruby
# encoding: utf-8
Encoding.default_internal
##########################################################
###
##  File: csv_reader.rb
##  Desc: Read an *.csv file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'

require 'pathname'
require 'csv'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  in_filename:    nil
}

def verbose?
  $options[:verbose]
end


usage = <<EOS

Read a CSV *.csv file

Usage: #{my_name} [options] filename.csv

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress

  filename.csv          The path to a text *.csv file


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

if ARGV.empty?
  $errors << "No *.csv filename was specified."
else
  $options[:in_filename] = Pathname.new ARGV.shift
  unless $options[:in_filename].exist?
    $errors << "Filename does not exist: #{$options[:in_filename]}"
  else
    $options[:in_filename] = $options[:in_filename].realpath
    unless '.csv' == $options[:in_filename].extname.downcase
      $errors << "Filename is not a text *.csv file: #{$options[:in_filename]}"
    end
  end
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

header_row = []

row_number = 0

CSV.foreach( $options[:in_filename] ) do |a_row|
  row_number += 1

  puts "Row No: #{row_number}"

  if header_row.empty?
    header_row = a_row
    pp header_row
    next
  end

  x=0

  a_row.each do |a_column|
    if a_column.nil?
      a_column = ""
    end
    if 0 == x
      a_column.gsub!("\n"," ")
    end
    puts "#{header_row[x]} ... #{a_column}"
    x += 1
  end

  puts "-"*45

end

