#!/usr/bin/env ruby
##########################################################
###
##  File: jira_open.rb
##  Desc: bring up a jira ticket in the browser
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#   System Environment Variables Used:
#   JIRA_BASE_URL
#     Example: https://<account-name>.atlassian.net/
#   JIRA_URL_SUFFIX
#     Example: ?oldIssueView=true
#   JIRA_PROJECT
#     Example: AR
#   JIRA_TICKET_EXAMPLE
#     Example: 162755560

require 'os'

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

if ENV['JIRA_URL_SUFFIX'].nil?
  JIRA_URL_SUFFIX = ''
else
  JIRA_URL_SUFFIX = ENV['JIRA_URL_SUFFIX']
end


if ENV['JIRA_PROJECT'].nil?
  puts "ERROR: The system environment variable JIRA_PROJECT is not set."
  exit -1
else
  JIRA_PROJECT = ENV['JIRA_PROJECT']
end

# NOTE: JIRA_TICKET_EXAMPLE is optional so no error message
JIRA_TICKET_EXAMPLE = ENV['JIRA_TICKET_EXAMPLE']




# NOTE: "open" is the CLI command for a Mac that will launch an
#       application to render the URI passed to it.  In this
#       case it launches the default browser and opens the
#       designated URL... opens in the default browser.
open_command = OS.mac? ? 'open' : 'xdg-open'
base_command = "#{open_command} #{JIRA_BASE_URL}/browse/#{JIRA_PROJECT}-"




# base_ticket is used to allow short id.  For example
# if the base_ticket is "9876543210" and the ARGV contains
# a ticket id like 222 then the last three characters of
# base_ticket are replaced with 222 in order to make up the full
# ticket to be opened.

def expand_using_base_ticket(a_ticket)
  return a_ticket if JIRA_TICKET_EXAMPLE.nil? || JIRA_TICKET_EXAMPLE.empty?

  str_ticket       = String(a_ticket) # make sure its a string

  a_ticket_size    = str_ticket.size
  base_ticket_size = JIRA_TICKET_EXAMPLE.size

  use_size         = base_ticket_size - a_ticket_size - 1 # cause we start counting at zero

  return a_ticket unless use_size > 0

  ticket = JIRA_TICKET_EXAMPLE[0..use_size] + str_ticket

  return ticket
end



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
        cmd = "#{base_command}#{ticket}#{JIRA_URL_SUFFIX}"
        system(cmd)
        sleep 1
      end
    else
      puts "ERROR: '#{ticket}' makes no sense. Left side must be less than the right side."
    end
  else
    ticket = expand_using_base_ticket(ticket) 
    `#{base_command}#{ticket}#{JIRA_URL_SUFFIX}`
  end
end # while !ARGV.empty?
