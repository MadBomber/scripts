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
# TODO: integrate "aicommit" (brew install aicommit)
#
#   brew install aspell
#
#   Add a file to the HOME directory called .gitmessage.template
#   This file will be processed into the standard .gitmessage.txt file
#   by making replacements in the content as directed by the
#   Hash object replacements.
#
# Do this to make 'git commit' pick up the
# local commit message file.
#
#   git config --local commit.template .gitmessage.txt
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
message_path  = rr + '.gitmessage.txt'

unless template_path.exist?
  exit(0)
end

JIRA_TICKET   = ENV.fetch('JIRA_TICKET', '')
JIRA_SUMMARY  = ENV.fetch('JIRA_SUMMARY', '')
JIRA_AC       = ENV.fetch('JIRA_AC', '') # Acceptance Critera
JIRA_DESC     = ENV.fetch('JIRA_DESC', '') # Description sometimes has the AC

replacements = {
  # New branches for a ticket are created in a working directory with the ticket name
  '[jira_ticket]'   => JIRA_TICKET,
  '[jira_summary]'  => JIRA_SUMMARY,
  '[jira_ac]'       => JIRA_AC,
  '[jira_desc]'     => JIRA_DESC
}

template = template_path.read

replacements.each_pair do |key, value|
  template.gsub!(key, value.gsub('\r\n', "\n"))
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
