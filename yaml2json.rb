#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: yaml2json.rb
##  Desc: Convert YAML with ERB to JSON
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# System Libraries
require 'pathname'  # STDLIB
require 'erb'       # STDLIB
require 'yaml'      # STDLIB
require 'json'      # STDLIB

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


def process_erb(file_contents)
  erb_contents = ERB.new(file_contents).result
  return erb_contents
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
  process_yaml(
    process_erb(file_contents)
  )
end


def write_json_file_from(yaml_pathname)
  # NOTE: does not recurse to sub-directories
  return() if yaml_pathname.directory?
  return() unless ['.yml', '.yaml'].include?(
      yaml_pathname.extname.downcase
    )
  a_hash = process_a_file(yaml_pathname)
  json_pathname = Pathname.new yaml_pathname.to_s.gsub(yaml_pathname.extname, '.json')
  json_pathname.write a_hash.to_json
end


def process_a_parameter(a_pathname)
  a_pathname = String == a_pathname.class ? Pathname.new(a_pathname) : a_pathname
  return unless a_pathname.exist?
  if a_pathname.directory?
    # NOTE: Not recursive
    a_pathname.children.each do |child_pathname|
      write_json_file_from(child_pathname)
    end
  else
    write_json_file_from(a_pathname)
  end # unless cf.exist? || cf.directory?
end # def process_a_parameter(a_pathname)


###############################
## Process options

if  ARGV.empty?             ||
    ARGV.include?('-h')     ||
    ARGV.include?('--help')
  puts <<EOS

Convert YAML files (with embedded ERB) to JSON files

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
  process_a_parameter(a_parameter)
end
