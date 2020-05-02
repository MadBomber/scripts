#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: dot_tags_reporter.rb
##  Desc: Report on the contents of a .tags file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Report on the contents of a .tags file") do |o|

end

# Display the usage info
if  ARGV.empty?
  configatron.target_dir = Pathname.pwd
else
  configatron.target_dir = Pathname.new(ARGV.shift)
end


# Error check your stuff; use error('some message') and warning('some message')


unless configatron.target_dir.exist?
  error "No such directory exists: #{configatron.target_dir}"
else
  configatron.tags_path = configatron.target_dir + '.tags'

  unless configatron.tags_path.exist?
    error "No such file exists: #{configatron.target_dir}"
  end
end



abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

configatron.tags_path.each_line do |a_line|
  next if a_line.start_with?('!')

  a_line.gsub!(';"','')

  parts = a_line.chomp.split("\t")

  if parts.size > 4
    reference_key = parts[4].gsub('class:','').gsub('.','::')

    if 'f' == parts[3]
      reference_key += '#' + parts[0]
    else
      reference_key += '::' + parts[0]
    end

    parts[4] = reference_key
  end

  ap parts
end
