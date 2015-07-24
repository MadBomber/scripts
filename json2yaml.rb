#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: json2yaml.rb
##  Desc: Convert JSON to YAML
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# System Libraries
require 'pathname'
require 'yaml'
require 'json'

me       = Pathname.new(__FILE__).realpath
my_name  = me.basename.to_s


def process_json(file_contents='')
  a_hash = JSON.parse file_contents
  return a_hash
end


def process_a_file(a_pathname)
  file_contents = a_pathname.read
  process_json file_contents
end


def write_yaml_file_from(json_pathname)
  # NOTE: does not recurse to sub-directories
  return() if json_pathname.directory?
  return() unless '.json' == json_pathname.extname.downcase

  a_hash = process_a_file(json_pathname)
  yaml_pathname = Pathname.new json_pathname.to_s.gsub(json_pathname.extname, '.yaml')
  yaml_pathname.write a_hash.to_yaml
end


def process_a_parameter(a_pathname)
  a_pathname = String == a_pathname.class ? Pathname.new(a_pathname) : a_pathname
  return unless a_pathname.exist?
  if a_pathname.directory?
    # NOTE: Not recursive
    a_pathname.children.each do |child_pathname|
      write_yaml_file_from(child_pathname)
    end
  else
    write_yaml_file_from(a_pathname)
  end # unless cf.exist? || cf.directory?
end # def process_a_parameter(a_pathname)


###############################
## Process options

if  ARGV.empty?             ||
    ARGV.include?('-h')     ||
    ARGV.include?('--help')
  puts <<EOS

Convert JSON files to YAML files

Usage: #{my_name} [-h|--help] (file|directory)+

  Requires one or more files or directories

  Files mush have an extension of '.json'

  If a directory is provided, all JSON files
  in the directory will be converted.  Mo
  sub-directories will be processed.  Its not
  recursive.

EOS

  exit(1)
end


##################################
## main()

ARGV.each do |a_parameter|
  process_a_parameter(a_parameter)
end

