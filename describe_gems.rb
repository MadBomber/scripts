#!/bin/env ruby
##############################################################
###
##  File: describe_gems.rb
##  Desc: Display the summary and description for a set of gems
#

usage_str = <<EOS

Usage: #{$0.split('/').last} gem+

  where "gem+" is one or more gem names

EOS

if ARGV.empty?
  puts usage_str  
  exit
end

require 'pp'

require 'yaml'
require 'systemu'
require 'ffi-ncurses'

# FIXME: make word_wrap a gem
require 'word_wrap'
include WordWrap

FFI::NCurses.initscr
set_default_width(FFI::NCurses.COLS)
FFI::NCurses.endwin



gems = ARGV

gems.each do |gem|
  spec = YAML.load(systemu("gem spec #{gem}")[1])
  
  unless spec
    puts "\n#{gem} -- ERROR no such gem installed"
    next
  end
  
  puts "\n#{gem} (#{spec.version}) #{spec.homepage}"

  summary = spec.summary
  unless summary.nil? or 0 == summary.strip.length
    puts
    puts wrap_with_label("  Summary:     ", "#{summary}" )
  end

  description = spec.description
  unless description.nil? or 0 == description.strip.length
    puts
    puts wrap_with_label("  Description: ", "#{description}" )
  end
  
  puts
#  pp spec.methods.sort
end



