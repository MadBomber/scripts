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

base_command = "open #{JIRA_BASE_URL}/browse/#{JIRA_PROJECT}-"

while !ARGV.empty?
  ticket = ARGV.shift

  if ticket.include?('-')
    parts         = ticket.split('-')
    first_ticket  = parts.first.to_i
    last_ticket   = parts.last.to_i
    if first_ticket < last_ticket
      tickets = ( first_ticket .. last_ticket)
      tickets.each do |ticket|
        cmd = "#{base_command}#{ticket}"
        system(cmd)
        sleep 1
      end
    else
      puts "ERROR: '#{ticket}' makes no sense. Left side must be less than the right side."
    end
  else
    system("#{base_command}#{ticket}")
  end
end # while !ARGV.empty?
