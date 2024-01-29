#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: class_method_file_xref.rb
##  Desc: Create a cross reference of class, methods and file paths
##        in markdown format to STDOUT
##
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# gem install ripper-tags
#

if defined?(RubyVM::YJIT)
  RubyVM::YJIT.enable if RubyVM::YJIT.respond_to? :enable
end


require 'json'
require 'pathname'

def usage
  puts <<~USAGE

    #{Pathname.new(__FILE__).basename} [directory]

    The default directory is the PWD

    Sends a markdown formatted table to STDOUT that
    contains the class name, method name and file path
    for all methods defined in the *.rb files located
    in the specified directory.

  USAGE
end

if ARGV.any? {|arg| %w[-h --help].include? arg}
  usage
  exit
end

base_path = if ARGV.empty?
              Pathname.pwd
            else
              Pathname.new(ARGV.shift)
            end

unless base_path.exist? && base_path.directory?
  STDERR.print "\nERROR: #{base_path} must be an existing directory\n\n"
  exit(1)
end

root_path = base_path.parent

# Create a 'tags' file at Pathname.pwd
system <<~COMMAND
ripper-tags \
  -f cmpx_tags \
  --tag-relative=yes \
  --format json \
  --recursive \
  --all-files \
  #{base_path}
COMMAND

tags  = Pathname.new('cmpx_tags')
data  = JSON.parse(tags.read)
          .select{|e| "method" == e['kind']}
          .sort_by { |e| e["class"] + e["name"] }

tags.delete

puts <<~HEADER
  | Class Name | Method Name | Path to File |
  | ---------- | ----------- | ------------ |
HEADER

data.each do |e|
  print "| #{e['class']} "
  print "| #{e['name'] } "
  path = Pathname.new(e['path']).relative_path_from(root_path)
  print "| #{path} "
  puts  "|"
end
