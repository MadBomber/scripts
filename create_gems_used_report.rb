#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: create_library_list.rb
##  Desc: Uses the Gemfile to create a libraries used report
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'pathname'       # STDLIB

class NilClass
  def to_s
    "unknown"
  end
end

class Array
  def to_s
    join(', ')
  end
end



GEMS = Hash.new
USED = Array.new

Gem::Specification.all.each do |gem_spec|
  GEMS[gem_spec.name] = gem_spec
end

here = Pathname.pwd

gem_files = %w[ Gemfile gems.rb ]

def source(*args)
  # No-Op
end

def group(*args, &block)
  # No-Op
end

def describe(one, two)
  return one if two.nil? || (one == two)
  return one + ' ' + two
end

def gem(name, *args)
  return unless GEMS.has_key? name
  USED << name

  if GEMS[name].dependencies.size > 0
    GEMS[name].dependencies.each do |library|
      USED << library.name
    end
  end
end

here = Pathname.pwd

gem_files.each do |gem_file|
  if load(here+gem_file)
    break
  end
end

################################################
## create the markdown-formatted report

puts "# Appendix: External Ruby Libraries (gems) Used"
puts <<~EOS

  This appendix details all of the external libraries (gems) used by this application in
  the production environment.  Other libraries may be used during development
  and test which are not shown in this appendix.

EOS

GEMS['pg'].description = '' # NOTE: had junk that messed up the markdown

USED.sort.uniq.each do |name|
  next if GEMS[name].nil? # means the gem is not install; may be a development dependency
  puts
  print '## '+ name
  puts " v#{GEMS[name].version}" if GEMS.has_key? name
  puts

  puts describe(
    GEMS[name].summary,
    GEMS[name].description
  )

  puts "\nHomepage: " + GEMS[name].homepage.to_s
  puts
  puts "| Author | eMail |"
  puts "| ------ | ----- |"
  authors = Array(GEMS[name].authors)
  emails  = Array(GEMS[name].email)
  authors.each_index do |row|
    puts "| #{authors[row]} | #{emails[row]} |"
  end

  deps = GEMS[name].dependencies.select{|dep| :runtime == dep.type}

  if deps.size > 0
    print "\n#### Dependencies\n\n"

    puts "| Name | Versions |"
    puts "| ---- | -------- |"

    GEMS[name].dependencies.each do |library|
      puts "| #{library.name} | #{library.requirement} |"
    end
  end
end # USED.sort.each do |name|

puts
puts




