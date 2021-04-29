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
#   JIRA_OPEN_COMMAND
#     Example: open | xdg=open | firefox | chrome | safari etc.

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


if ENV['JIRA_OPEN_COMMAND'].nil?
  puts "ERROR: The system environment variable JIRA_OPEN_COMMAND is not set."
  exit -1
else
  JIRA_OPEN_COMMAND = ENV['JIRA_OPEN_COMMAND']
end


# NOTE: JIRA_TICKET_EXAMPLE is optional so no error message
JIRA_TICKET_EXAMPLE = ENV['JIRA_TICKET_EXAMPLE']

def base_command(ticket)
  "#{JIRA_OPEN_COMMAND} #{JIRA_BASE_URL}/browse/#{JIRA_PROJECT}-#{ticket}#{JIRA_URL_SUFFIX}"
end

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

# if a_string looks like XX-nnnn we want to extract XX as
# the project.  Also if the string looks like XX without any
# digits we want XX as the project.
#
# returns an Array of two strings.  This first is the project.
# the last is the ticket number.
#
def extract_project(a_string)
  a_string.scan(/([a-zA-Z]*)-?(\d*)/).first
end


parameters = ARGV.map(&:upcase)

while !parameters.empty?
  ticket = parameters.shift

  result = extract_project(ticket)

  unless result[0].empty?
    JIRA_PROJECT = result[0]
    # allow for "XX-123-456"
    ticket = ticket.gsub("#{JIRA_PROJECT}-", '')
  end

  if ticket.include?('-')
    parts         = ticket.split('-')
    first_ticket  = parts.first.to_i
    last_ticket   = parts.last.to_i
    if first_ticket < last_ticket
      tickets = ( first_ticket .. last_ticket)
      tickets.each do |ticket|
        ticket = expand_using_base_ticket(ticket)
        cmd = base_command(ticket)
        system(cmd)
        sleep 1
      end
    else
      puts "ERROR: '#{ticket}' makes no sense. Left side must be less than the right side."
    end
  else
    ticket = expand_using_base_ticket(ticket)
    system( base_command(ticket) )
  end
end # while !ARGV.empty?
