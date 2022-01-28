#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: update_jira_json_txt.rb
##  Desc: Update the text version of the JIRA ticket JSON file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#   brew install gron  -- converts json to txt (one line per element)
#


require 'amazing_print'

require 'debug_me'
include DebugMe

require 'pathname'

unless ENV['JIRA_DB_DIR']
  puts <<~EOS

    ERROR: JIRA_DB_DIR and JIRA_DB_PROJECTS must be
           existing ENV variables.

  EOS
  exit
end


JIRA_DB_DIR_PATH = Pathname.new ENV['JIRA_DB_DIR']
JIRA_DB_PROJECTS = ENV['JIRA_DB_PROJECTS'].split




######################################################
# Local methods

def changed?(file_path)
  txt_path = Pathname.new(file_path.to_s + '.txt')
  !txt_path.exist? || (file_path.ctime >= txt_path.ctime)
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

JIRA_DB_PROJECTS.each do |project|
  puts "="*64
  puts "== #{project}"
  changed_paths = (JIRA_DB_DIR_PATH+project).children.select{|c| !c.directory? && '.json' == c.extname && changed?(c) }
  changed_paths.each do |changed_ticket|
    puts "updating #{changed_ticket} ..."
    command = "gron #{changed_ticket} > #{changed_ticket}.txt"
    system command
  end
end
