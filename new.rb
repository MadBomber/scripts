#!/usr/bin/env ruby -W0
##########################################################
###
##  File: new.rb
##  Desc: Generate a new instance of a file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'

require 'pathname'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

file_templates_path = my_dir + 'file_templates'

file_templates = file_templates_path.children.select { |c| c.file? }

$options = {
  verbose:        false
}

def verbose?
  $options[:verbose]
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

  #{file_templates.map{|f|f.basename.to_s}.join("\n\t")}

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

# TODO:  No need to limit to one template.  Consider the use
#        case where different files are combined.  For example
#        some common header files to be combined with different
#        body files.


template_files = ARGV.map { |f| file_templates_path + f }

template_files.each do |template_file|
  unless template_file.exist?
    errors << "no such template file: #{template_file.basename}"
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
  puts template_file.read
end

