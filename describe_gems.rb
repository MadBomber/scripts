#!/usr/bin/env ruby
##############################################################
###
##  File: describe_gems.rb
##  Desc: Display the summary and description for a set of gems
#

require 'terminal-size'  # A tiny gem to accomplish a simple task: Determining the terminal size.
MAX_COLUMNS = Terminal.size[:width] # - 1

usage_str = <<EOS

Usage: #{$0.split('/').last} gem+

  where "gem+" is one or more gem names

EOS

if ARGV.empty?
  puts usage_str
  exit
end

require 'pp'

require 'yaml'  # STDLIB
require 'systemu'  # systemu

# FIXME: make word_wrap a gem
require 'word_wrap'  # Simple tool for word-wrapping text
require 'word_wrap/core_ext'  # Simple tool for word-wrapping text


def wrap_with_label(a_label, a_desc)
  spacer = " "*a_label.size
  desc_array = a_desc.fit(MAX_COLUMNS - a_label.size).split("\n")
  desc_array[0]= a_label + desc_array.first
  if desc_array.size > 1
    (1..desc_array.size-1).each do |x|
      desc_array[x] = spacer + desc_array[x]
    end
  end

  return desc_array.join("\n")
end

gems = ARGV

gems.each do |gem|
  spec = YAML.load(`gem spec #{gem}`)

  unless spec
    puts "\n#{gem} -- ERROR no such gem installed"
    next
  end

  puts "\n#{gem} (#{spec.version}) #{spec.homepage}"

  summary = spec.summary
  unless summary.nil? || 0 == summary.strip.length
    puts wrap_with_label("  Summary:     ", "#{summary}" )
  end

  description = spec.description
  unless description.nil? ||
         0 == description.strip.length ||
         summary == description
    puts wrap_with_label("  Description: ", "#{description}" )
  end

  depends = spec.dependencies
  unless depends.empty?
    puts wrap_with_label(
      "   Depends on: ",
      depends.map{|d| d.name}.join(', ')
    )
  end

  puts
end



