#!/usr/bin/env ruby
##########################################################
###
##  File: jira_open.rb
##  Desc: bring up a jira ticket in the browser
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# base_ticket is used to allow short id.  For example
# if the base_ticket is "9876543210" and the ARGV contains
# a ticket id like 222 then the last three characters of
# base_ticket are replaced with 222 in order to make up the full
# ticket to be opened.

def expand_using_base_ticket(a_ticket)
  return a_ticket if ENV['JIRA_TICKET_EXAMPLE'].nil? || ENV['JIRA_TICKET_EXAMPLE'].empty?

  str_ticket       = String(a_ticket) # make sure its a string

  a_ticket_size    = str_ticket.size
  base_ticket_size = ENV['JIRA_TICKET_EXAMPLE'].size

  use_size         = base_ticket_size - a_ticket_size - 1 # cause we start counting at zero

  return a_ticket unless use_size > 0

  ticket = ENV['JIRA_TICKET_EXAMPLE'][0..use_size] + str_ticket

  return ticket
end


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
        ticket = expand_using_base_ticket(ticket) 
        cmd = "#{base_command}#{ticket}"
        system(cmd)
        sleep 1
      end
    else
      puts "ERROR: '#{ticket}' makes no sense. Left side must be less than the right side."
    end
  else
    ticket = expand_using_base_ticket(ticket) 
    system("#{base_command}#{ticket}")
  end
end # while !ARGV.empty?
