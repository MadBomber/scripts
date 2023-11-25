#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: revert_all.rb
##  Desc: Does a 'gco' on all modified files in a git working directory
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Does a 'gco' on all modified files in a git working directory") do |o|

  o.bool          '--doit',   'do the gco',   default: false
  o.bool          '--dryrun', 'show me',      default: false

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

this_dir = Pathname.pwd

unless (this_dir+".git").exist?
  error "This dir is NOT a working git repo: #{this_dir}"
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


gs_files = `git status`.split("\n")
                        .map(&:strip)
                        .select{|r| r.start_with?("modified:")}
                        .map{|r| r.gsub("modified:","").strip}

debug_me{[
  :gs_files,
]}

exit(0) unless configatron.doit? || configatron.dryrun?

debug_me{[
  :doit?,
  :dryrun?
]}


gs_files.each do |a_filepath|
  gco_command = "git checkout '#{a_filepath}'"
  puts gco_command if dryrun?
  if doit?
    gco_results = `#{gco_command}` 
    puts gco_results
  end
end
