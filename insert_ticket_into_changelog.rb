#!/usr/bin/env ruby
# $RR/bin/insert_ticket_into_changelog.rb

require 'amazing_print'
require 'pathname'
require 'json'

# Assumes this program executes out of the Rails.root bin directory
REPO_ROOT                = Pathname.new(ENV['RR'])

CHANGELOG_FILENAME        = "CHANGELOG.md"
CHANGELOG_FILENAME_BACKUP = CHANGELOG_FILENAME + '.backup'

CHANGELOG_PATH            = REPO_ROOT + CHANGELOG_FILENAME
CHANGELOG_BACKUP_PATH     = REPO_ROOT + CHANGELOG_FILENAME_BACKUP

CHANGELOG_MARKER          = "## Latest Release"
CHANGELOG_MARKER_INX      = 3 # counting numbers

def usage
  puts <<~EOS

    Insert JIRA ticket info into CHANGELOG file

    Usage:
      #{File.basename(__FILE__)} [pptions] jira_ticket

    Options:
      -h, --help      Show Usage
          --dryrun    Do Not Modify the CHANGELOG file

    Note:
      This program will copy the contents of
        #{CHANGELOG_FILENAME} to #{CHANGELOG_FILENAME_BACKUP}
      even if --dryrun is specified.

  EOS
end


if ARGV.empty?  ||  ARGV.include?('--help') || ARGV.include?('-h')
  usage
  exit
end

if ARGV.size > 2
  puts "\nERROR: Not Supported #{ARGV.join(' ')}"
  usage
  exit
end

if 2 == ARGV.size && !ARGV.include?('--dryrun')
  puts "\nERROR: Not Supported #{ARGV.join(' ')}"
  usage
  exit
end


JIRA_TICKET           = ARGV.reject{|arg| arg.start_with?('-')}.first

if JIRA_TICKET.empty?
  puts "\nERROR: No JIRA Ticket supplied: #{ARGV.join(' ')}"
  usage
  exit
end


JIRA_TICKET_URL       = "https://kipusystems.atlassian.net/browse/#{JIRA_TICKET}"
JIRA_USER             = ENV['JIRA_USER']
JIRA_API_TOKEN        = ENV['JIRA_PASS']
JIRA_API_URL          = "https://kipusystems.atlassian.net/rest/api/2/issue/#{JIRA_TICKET}.json"

def dryrun?
  ARGV.include?('--dryrun')
end


def get_jira_ticket_info
  command = <<~COMMAND
    curl \
       -u #{JIRA_USER}:#{JIRA_API_TOKEN} \
       -X GET \
       -H "Content-Type: application/json" \
       #{JIRA_API_URL}
   COMMAND

   json_string = `#{command}`

   JSON.parse json_string
end


jira_hash = get_jira_ticket_info

# ap jira_hash['fields'].keys


ticket_summary  = jira_hash.dig('fields', 'summary')
ticket_url      = "https://kipusystems.atlassian.net/browse/#{JIRA_TICKET}"



`cp #{CHANGELOG_PATH} #{CHANGELOG_BACKUP_PATH}`

file_in   = File.open(CHANGELOG_BACKUP_PATH, 'r')

if dryrun?
  file_out  = STDOUT
else
  file_out  = File.open(CHANGELOG_PATH, 'w')
end

line_number = 0

file_in.readlines.each do |a_line|
  line_number += 1

  a_line.chomp!

  if  CHANGELOG_MARKER_INX  == line_number  &&
      CHANGELOG_MARKER      == a_line
    file_out.puts a_line
    file_out.puts "- [#{JIRA_TICKET}](#{ticket_url}) #{ticket_summary}"
  else
    file_out.puts a_line
  end
end

