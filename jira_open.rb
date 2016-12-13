#!/usr/bin/env ruby
##########################################################
###
##  File: jira_open.rb
##  Desc: bring up a jira ticket in the browser
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

if ARGV.empty?
  puts "ERROR: You need at least one JIRA ticket Number on the command line"
  exit -1
end

if ENV['JIRA_BASE_URL'].nil?
  puts "ERROR: The system environment variable JIRA_BASE_URL is not set."
  exit -1
else
  JIRA_BASE_URL = ENV['JIRA_BASE_URL']
end

if ENV['JIRA_PROJECT'].nil?
  puts "ERROR: The system environment variable JIRA_PROJECT is not set."
  exit -1
else
  JIRA_PROJECT = ENV['JIRA_PROJECT']
end


while !ARGV.empty?
  # TODO: check the argument to see if it is in the form #-#
  #       if so treat the argument as a range
  system("open #{JIRA_BASE_URL}/browse/#{JIRA_PROJECT}-" + ARGV.shift)
end
