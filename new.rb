#!/usr/bin/env ruby
##########################################################
###
##  File: new.rb
##  Desc: Generate a new instance of a file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# TODO: parse files looking for __xyzzy_magic__ strings
#       request replacement text from user for the magic strings
#

require 'debug_me'
include DebugMe

require 'pathname'
require 'erb'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

templates_path = my_dir + 'templates'

templates  = templates_path.children

$options = {
  verbose:        false
}

def verbose?
  $options[:verbose]
end

PH_REGEX = /\b(__\S+__)\b/

def find_placeholders(a_string)
  return [] unless a_string.include? '__'

  place_holders = a_string.scan(PH_REGEX).flatten.sort.uniq

  debug_me(file: STDERR){[ :place_holders ]}

  return place_holders
end

PH_VALUES = Hash.new

def fill_placeholders(a_string, place_holders)
  text = a_string.dup

  place_holders.each do |place_holder|
    unless PH_VALUES.has_key? place_holder
      STDERR.puts "\nEnter value for #{place_holder} then press return:"
      STDERR.print "> "
      PH_VALUES[place_holder] = STDIN.gets.chomp
    end
    text.gsub!(place_holder, PH_VALUES[place_holder])
  end
  return text
end

usage = <<EOS

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

  #{templates.select{|f| f.file?}.map{|f|f.basename.to_s.gsub('.erb','')}.join("\n\t")}

  Current directory templates are:

  #{templates.select{|f| f.directory?}.map{|f|f.basename.to_s}.join("\n\t")}

EOS

# Check command line for Problems with Parameters
errors = []

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

template_files = ARGV.map { |f| templates_path + f }

template_files.each_index do |x|
  template_file = template_files[x]
  unless template_file.exist?
    erb_version = template_file.parent +
                    (template_file.basename.to_s + '.erb')
    unless erb_version.exist?
      errors << "no such template file: #{template_file.basename}"
    else
      template_files[x] = erb_version
    end
  end
end


unless errors.empty?
  STDERR.puts
  STDERR.puts "Correct the following errors and try again:"
  STDERR.puts
  errors.each do |e|
    STDERR.puts "\t#{e}"
  end
  STDERR.puts
  exit(1)
end


template_files.each do |template_file|

debug_me{[ :template_file ]}

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

