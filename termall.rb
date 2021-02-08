#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: termall.rb
##  Desc: Send TERM signal to all process that start with the given string
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'

require 'debug_me'
include DebugMe

# require 'cli_helper'
# include CliHelper

# configatron.version = '0.0.1'

HELP = <<EOHELP
Example:

  #{$0} sidekiq   # will do 'kill -TERM <pid>' on all sidekiq processes

EOHELP

# cli_helper("Send TERM signal to all process that start with the given string") do |o|

#   o.bool          '--dryrun', 'do not do anything',         default: false
#   o.string  '-s', '--signal', 'Exanole: 9 or TERM',         default: 'TERM'

# end

# Display the usage info
if  ARGV.empty?
  # show_usage
  puts "you forgot to say what to terminate."
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

# configatron.process_name = ARGV.last

# if configatron.process_name.empty?
#   error 'No process name was provided'
# end

# abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

# ap configatron.to_h  if verbose? || debug?

command = "kill -TERM"

process_name = ARGV.first

psf_lines   = `ps aux | fgrep #{process_name}`.split("\n")
commands = []

psf_lines.each do |psf|
  elements = psf.split
  if elements[10].start_with? process_name
    commands << "#{command} #{elements[1]} # #{elements[10]}"
  end
end

if commands.empty?
  puts "Nothing to terminate"
else
  # if dryrun?
  #   ap commands
  # else
    commands.each do |command|
      puts command # if verbose?
      system command
    end
  # end
end
