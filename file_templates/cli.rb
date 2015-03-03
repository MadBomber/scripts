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
require 'nenv'
require 'slop'

# Example Custom Type for Slop
module Slop
  class PathOption < Option
    def call(value)
      Pathname.new(value)
    end
  end
  class PathsOption < ArrayOption
    def finish(opts)
      self.value = value.map { |f| Pathname.new(f) }
    end
  end
end # module Slop

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s
home_path = Pathname.new(Nenv.home)

$options = {
  version:        '0.0.1',# the version of this program
  arguments:      [],     # whats left after options and parameters are extracted
  verbose:        false,
  debug:          false,
  user_name:      Nenv.user || Nenv.user_name || Nenv.logname || 'Dewayne VanHoozer'
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end

HELP = <<EOHELP

Important:

  Put important stuff here.

EOHELP

opts = Slop.parse do |o|
  o.banner = "\nDownload files from an AWS/S3 bucket"
  o.separator "\nUsage: #{my_name} [options] parameters"
  o.separator "\nWhere:"
  o.separator "  options"

  o.on '-h', '--help', 'show this message' do
    puts o
    puts HELP if defined?(HELP)
    exit
  end

  o.bool '-v', '--verbose', 'enable verbose mode'
  o.bool '-d', '--debug',   'enable debug mode'

  o.separator "\n  parameters"

  o.string  '-s', '--string', 'example string parameter',  default: 'IamDefault'
  o.int     '-i', '--int',    'example integer parameter', default: 42
  o.array   '-a', '--array',  'example array parameter',   default: [:bob, :carol, :ted, :alice]
  o.path    '-p', '--path',   'example Pathname parameter', default: Pathname.new('default/path/to/file.txt')
  o.paths         '--paths',  'example Pathnames parameter', default: ['default/path/to/file.txt', 'file2.txt'].map{|f| Pathname.new f}


  o.on '--version', "print the version: #{$options[:version]}" do
    puts $options[:version]
    exit
  end
end

$options.merge!(opts.to_hash)
$options[:arguments] = opts.arguments

# Display the usage info
if  ARGV.empty?
  puts opts
  puts HELP if defined?(HELP)
  exit
end


# Check command line for Problems with Parameters
$errors   = []
$warnings = []


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

