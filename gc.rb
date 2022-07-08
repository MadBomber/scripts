#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: gc.rb
##  Desc: add the basename of $RR to the git commit template
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#
#   brew install aspell
#
#   Add a file to the HOME directory called .gitmessage.template
#   This file will be processed into the standard .gitmessage.txt file
#   by making replacements in the content as directed by the
#   Hash object replacements.
#
#   You can
#     alias gc='gc.rb && git commit'
#   to take advantage of the new template capability.
#

require 'amazing_print'
require 'pathname'

# $RR is the Rails.root (or repo root for non-rails projects)
# its generall set by a .envrc file (brew install direnv)

if ENV['RR'].nil?
  rr          = Pathname.pwd
else
  rr          = Pathname.new(ENV['RR'])
end

home          = Pathname.new(ENV['HOME'])
template_path = home + '.gitmessage.template'
message_path  = home + '.gitmessage.txt'

unless template_path.exist?
  exit(0)
end

replacements = {
  # New branches for a ticket are created in a working directory with the ticket name
  '[jira_ticket]'   => ENV['JIRA_TICKET'],
  '[jira_summary]'  => ENV['JIRA_SUMMARY'],
  '[jira_ac]'       => ENV['JIRA_AC']
}

template = template_path.read

replacements.each_pair do |key, value|
  template.gsub!(key, value)
end

message_file = File.open(message_path, 'w')

message_file.puts template

##########################################################
## Lets look for mis-spekked wordz in *.txt and *.md files

staged_files = `git diff --name-only --staged | grep -e txt -e md`.split("\n")

unless staged_files.empty?
  message_file.puts '###################################'
  message_file.puts '# Checking spelling in txt/md files'
  message_file.puts '#'
  staged_files.each do |staged_file|
    spelling_errors = `aspell --list < #{staged_file}`.split("\n")
    unless spelling_errors.empty?
      message_file.print "# #{staged_file} ... "
      message_file.puts spelling_errors.join(", ")
    end
  end
end

message_file.close
