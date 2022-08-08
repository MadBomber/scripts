#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: get_db_relationships.rb
##  Desc: extract the has_ and belongs_ relationships for ActiveRecord::Base classes
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper


HERE = Pathname.pwd # where program was started


configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("extract the has_ and belongs_ relationships for ActiveRecord::Base classes") do |o|
  o.path    '-p', '--path',   'Root path to the models'
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

unless configatron.path.exist?
  error "#{configatron.path} does not exist"
end

abort_if_errors


######################################################
# Local methods

configatron.things = Array.new

Record = Struct.new(:filename, :name, :relation, :associate, :baggage) do 
  def initialize(filename: '', name: '', relation: '', associate: '', baggage: '')
    super(filename, name, relation, associate, baggage)
  end
end


def extract_relationships_from(a_path)
  content = a_path.read.squeeze(" ")

  return nil unless content.include?("< ActiveRecord::Base")

  lines = content.split("\n").map{|x| x.chomp.strip}

  record = Record.new

  puts "----" # used as a record seperate for agrep

  record.filename = a_path.relative_path_from(HERE).to_s

  puts record.filename

  name = ""
  lines.each do |a_line|
    if  a_line.start_with?("module")   ||
        a_line.start_with?("class")    ||
        a_line.start_with?("belongs_") ||
        a_line.start_with?("has_")
      puts a_line  
    end

    if a_line.start_with?("module")
      name += a_line.split(' ')[1]+ "::"
    end

    if a_line.start_with?("class")
      parts = a_line.split(' ')
      
      if parts.size >= 2
        name += a_line.split(' ')[1]
      else
        name += "unknown"
      end

      record.name = name
      configatron.things << record
    end

    if  a_line.start_with?("has_")      ||
        a_line.start_with?("belongs_")
      parts = a_line.split(' ')

      next if parts.size < 2

      record.relation   = parts[0]
      record.associate  = parts[1].gsub(/[:,]/,'')
      record.baggage    = a_line.gsub(parts[0], '').gsub(parts[1],'').strip
      configatron.things << record
    end
  end

  return
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

paths = Dir.glob(configatron.path.to_s+"/**/*.rb").map{|f| HERE + f}

paths.each do |a_path|
  extract_relationships_from a_path
end


f = File.new('relationships.csv', 'w')
headers = %w[ filename name relation associate baggage]

f.puts headers.join(",")

configatron.things.each do |thing|
  f.print "#{thing.filename},"
  f.print "#{thing.name},"
  f.print "#{thing.relation},"
  f.print "#{thing.associate},"
  f.puts "\"#{thing.baggage}\""
end

f.close  
