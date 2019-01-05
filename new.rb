#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: new.rb
##  Desc: Generate a new instance of a file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# TODO: parse files looking for __xyzzy_magic__ strings
#       request replacement text from user for the magic strings
#

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'pathname'  # STDLIB
require 'erb'       # STDLIB

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

templates_path = my_dir + 'templates'
templates      = templates_path.children
@verbose       = false

def verbose?
  @verbose
end

PH_REGEX = /\b(__\S+__)\b/.freeze

def find_placeholders(a_string)
  return [] unless a_string.include? '__'

  place_holders = a_string.scan(PH_REGEX).flatten.sort.uniq

  debug_me(file: STDERR) { [ :place_holders ] }

  return place_holders
end

@ph_values = {}

def fill_placeholders(a_string, place_holders)
  text = a_string.dup

  place_holders.each do |place_holder|
    unless @ph_values.key? place_holder
      STDERR.puts "\nEnter value for #{place_holder} then press return:"
      STDERR.print '> '
      @ph_values[place_holder] = STDIN.gets.chomp
    end
    text.gsub!(place_holder, @ph_values[place_holder])
  end
  return text
end

usage = <<~END_USAGE

  Generate a new instance of a file

  Usage: #{my_name} [options] file_template_name+ > new_file_name

  Where:

    options               Do This
      -h or --help        Display this message
      -v or --verbose     Display progress

    file_template_name+   The name(s) of file templates
                            to concat

  NOTE:

    The output of the selected file template(s) are printed to
    STDOUT.  Use common file redirection to save to a
    new_file_name.

    Current file templates are:

    #{templates.select(&:file?).map { |f| "\t" + f.basename.to_s.gsub('.erb', '') }.join("\n")}

    Current directory templates are:

    #{templates.select(&:directory?).map { |f| f.basename.to_s }.join("\n\t")}

END_USAGE

# Check command line for Problems with Parameters
errors = []

if  ARGV.empty?               ||
    ARGV.include?('-h')       ||
    ARGV.include?('--help')
  puts usage
  exit
end

%w[-v --verbose].each do |param|
  if ARGV.include? param
    @verbose = true
    ARGV[ARGV.index(param)] = nil
  end
end

ARGV.compact!

template_files = ARGV.map { |f| templates_path + f }

template_files.each_index do |x|
  template_file = template_files[x]
  unless template_file.exist?
    errors << "no such template file: #{template_file.basename}"
    next
  end

  erb_version = template_file.parent +
                (template_file.basename.to_s + '.erb')

  template_files[x] = erb_version if erb_version.exist?
end


unless errors.empty?
  STDERR.puts
  STDERR.puts 'Correct the following errors and try again:'
  STDERR.puts
  errors.each do |e|
    STDERR.puts "\t#{e}"
  end
  STDERR.puts
  exit(1)
end


template_files.each do |template_file|

  debug_me(file: STDERR) { [:template_file] }

  if template_file.file?
    if '.erb' == template_file.extname.to_s
      puts ERB.new(template_file.read).result
    else
      text  = template_file.read
      phers = find_placeholders(text)
      text  = fill_placeholders(text, phers) unless phers.empty?
      puts text
    end
  else
    system "cp -R #{template_file} #{Pathname.pwd}"
  end
end
