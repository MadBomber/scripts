#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: vcr_hater_yaml2hash.rb
##  Desc: Extracts the response body string from
##        from a vcr_cassette in prep for removing
##        the hated VCR virus from spec files
##
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# TODO:   make it recursive on a directory parameter
#

require 'amazing_print'
AP_OPTIONS = {
  indent:     2,
  index:      false,
  plain:      true,
  object_id:  false
}

# System Libraries
require 'json'      # STDLIB
require 'pathname'  # STDLIB
require 'yaml'      # STDLIB

me       = Pathname.new(__FILE__).realpath
my_name  = me.basename.to_s


def chomp_the_hash!(a_hash)
  a_hash.each_pair do |k,v|
    # SMELL: This will defeat any intentionally added
    #        \n at the end of a string.
    if String == a_hash[k].class
      a_hash[k].chomp!
    elsif Hash == a_hash[k].class
      chomp_the_hash!(a_hash[k])
    end
  end
  return a_hash
end


def process_yaml(file_contents='')
  a_hash = YAML.load file_contents
  # SMELL: multi-line strings in YAML
  #        add a newline character after
  #        the last line of the string.  That
  #        seems to contradict the YAML spec.
  chomp_the_hash!(a_hash)
  return a_hash
end


def process_a_file(a_pathname)
  file_contents = a_pathname.read
  if file_contents.chomp.strip.empty?
    print "EMPTY "
    {} # empty hash
  else
    process_yaml(file_contents)
  end
end


def write_hash_file_from(yaml_pathname)
  # NOTE: does not recurse to sub-directories
  return() if yaml_pathname.directory?
  return() unless ['.yml', '.yaml'].include?(
      yaml_pathname.extname.downcase
    )
  a_hash = process_a_file(yaml_pathname)
  
  return if a_hash.empty?


  hash_pathname = Pathname.new yaml_pathname.to_s.gsub(yaml_pathname.extname, '.rb')
  
  buffer = '# ' + hash_pathname.to_s + "\n\n"
  buffer += fake_response(a_hash) + "\n\n__END__\n\n"
  buffer += a_hash.ai(AP_OPTIONS)

  hash_pathname.write buffer
end


def process_a_parameter(a_pathname)
  a_pathname = String == a_pathname.class ? Pathname.new(a_pathname) : a_pathname
  return unless a_pathname.exist?
  if a_pathname.directory?
    # NOTE: Not recursive
    a_pathname.children.each do |child_pathname|
      write_hash_file_from(child_pathname)
    end
  else
    write_hash_file_from(a_pathname)
  end # unless cf.exist? || cf.directory?
end # def process_a_parameter(a_pathname)


def fake_response(a_hash)
  http_interactions = a_hash['http_interactions']

  step_no = 0
  buffer  = ""

  http_interactions.each do |step|
    step_no += 1
    a_string = step.dig('response', 'body', 'string').to_json
   
    if a_string.nil? 
      a_string = "ERROR: keys: #{step_no}-=>#{step.keys.join(', ')}"
      print "ERROR:NO_RESP(#{step_no}) "
    end

    buffer += '# Step #' + step_no.to_s + "\n"
    buffer += "xyzzy.fake_response = " + a_string + "\n\n"
  end

  buffer
end

###############################
## Process options

if  ARGV.empty?             ||
    ARGV.include?('-h')     ||
    ARGV.include?('--help')
  puts <<EOS

Convert YAML files into Hash-based Ruby files

Usage: #{my_name} [-h|--help] (file|directory)+

  Requires one or more files or directories

  Files mush have an extension of '.yml'
  or '.yaml'

  If a directory is provided, all YAML files
  in the directory will be converted.  Mo
  sub-directories will be processed.  Its not
  recursive.

  ERB may be included within the YAML file.

EOS

  exit(1)
end


##################################
## main()

ARGV.each do |a_parameter|
  print "Processing #{a_parameter} ... "
  process_a_parameter(a_parameter)
  puts "done."
end
