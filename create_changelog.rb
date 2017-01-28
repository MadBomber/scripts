#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: create_changelog.rb
##  Desc: Create an CHANGELOG.md file from a git log that contains
##        references to JIRA tickets that document the work effort.
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

=begin

Assumptions:
  - working in a multi-team environment against a common git repository
  - each team has their own JIRA ticket system
    * Each system has a different project identifier
    * Each JIRA system has different login creds
  - each team makes reference to work effort done via reference to JIRA ticket(s)
    * JIRA ticket reference could be in the branch name and/or
    * JIRA ticket reference could be in the commit message

=end


require 'active_support'
require 'active_support/inflector'
require 'awesome_print'
require 'date'
require 'ostruct'
require 'Pathname'


require 'debug_me'
include DebugMe

require 'jira-ruby'

me = Pathname.new(__FILE__).basename

# TODO: accept date range from command line.

DATE_RANGE = ( (Date.today - 30) .. Date.today )

# TODO: accept configuration from YAML file instead of SEV.
# TODO: use some kind of template file for report layout

usage = <<EOS

Create an CHANGELOG.md file from a git log that contains
references to JIRA tickets that document the work effort.

Usage: #{me} [working_directory]

Where:

  working_directory   [optional] is a git-managed working directory
                      Default Value: #{Pathname.pwd}

System Environment Variables Used:

  Name            Description
  CCL_PROJECTS    Comma separated list of JIRA project IDs
  CCL_URL_xxxx    The JIRA server base URL for project xxxx
  CCL_USER_xxxx   The user name for project xxxx to login to the server
  CCL_PASS_xxxx   The user password for project xxxx for login

EOS

if  ARGV.include?('--help')  ||
    ARGV.include?('-h')      ||
    ARGV.include?('-?')
  puts usage
  exit
end

#############################################################
# Validate the System Environment Variables

unless ENV['CCL_PROJECTS'].empty?
  CCL_PROJECTS = ENV['CCL_PROJECTS'].split(',').map{|proj_id| proj_id.strip.upcase}
else
  puts <<~EOS

    ERROR: The system environment variable CCL_PROJECTS is not defined

  EOS
  exit -1
end

warnings = []
CCL_PROJECTS.each do |proj_id|
  %w[ CCL_USER CCL_PASS CCL_URL ].each do |sev_base|
    sev = "#{sev_base}_#{proj_id}"
    if ENV[sev].blank?
      warnings << "The system environment variable #{sev} is not defined"
    end
  end
end

unless warnings.empty?
  warnings.each do |e|
    puts "WARNING: #{e}"
  end
end


#############################################################
# Create a JIRA client connection for each project

JIRA_CLIENT = Hash.new

CCL_PROJECTS.each do |proj_id|
  options = {
    :username     => ENV["CCL_USER_#{proj_id}"],
    :password     => ENV["CCL_PASS_#{proj_id}"],
    :site         => ENV["CCL_URL_#{proj_id}"],
    :context_path => '',
    :auth_type    => :basic
  }

  JIRA_CLIENT[proj_id] = JIRA::Client.new(options)
end

#############################################################
# Adding a little sugar to String to support
# duck typing requirement of the extract_jira_tickets method

class String
  def join
    self
  end
end



#############################################################
# build the command for retrieving the git log

git_log_command = 'git'

unless ARGV.empty?
  working_directory = Pathname.new ARGV.shift
  unless  working_directory.exist?  &&
          working_directory.directory?
    puts "\nERROR: Argument is not an existing directory."
    puts usage
    exit
  end
  git_log_command += " -C #{working_directory}"
end

git_log_command += ' log --name-status'



#####################################################
## Helpers for Parsing Commit Entries in a GIT Log ##
#####################################################


#####################################################################
# determine if this commit is a merge
# an_array of strings that comprise a single commit from the git log

def is_a_merge(an_array)
  merge_string_index = an_array.index{|s| s.start_with?("Merge")}
  return !merge_string_index.nil?
end


#####################################################################
# extract the date of a commit
# an_array of strings that comprise a single commit from the git log

def extract_date(an_array)
  date_string_index = an_array.index{|s| s.start_with?("Date:")}
  date_string = an_array[date_string_index]
  return DateTime.parse date_string.gsub('Date:','').strip
end


#####################################################################
# extract the author of a commit
# an_array of strings that comprise a single commit from the git log

def extract_author(an_array)
  author_string_index = an_array.index{|s| s.start_with?("Author:")}
  author_string = an_array[author_string_index]
  return author_string.gsub('Author:','').strip
end


#####################################################################
# extract all files impacted by this commit
# an_array of strings that comprise a single commit from the git log

def extract_files(an_array)
  files = []
  an_array.reverse.each do |a_file|
    next if a_file.empty?
    next if a_file.start_with?(' ')
    break if a_file.start_with?('Date:')
    files << a_file   # .split("\t").last
  end
  return files.sort
end


#####################################################################
# extract the description of a commit
# an_array of strings that comprise a single commit from the git log

def extract_description(an_array)
  description = ""
  while !an_array.shift.empty? do
    # NOOP
  end

  until an_array.first.empty? do
     description << an_array.shift.strip + "\n"
  end

  return description.chomp
end


#####################################################################
# extract all references to JIRA tickets
# projects is an array of project id strings used to find JIRA ticket references
# from can be a string or an array of strings from which JIRA tickets are extracted

def extract_jira_tickets(projects: CCL_PROJECTS, from:)
  minmax_string   = projects.map{|x|x.size}.minmax.join(',')
  project_string  = projects.join + projects.join.downcase
  project_string  = project_string.scan(/\w/).uniq.sort.join
  regex_string    = "([#{project_string}]{#{minmax_string}}-" + '\d+)'
  jira_re         = Regexp.new(regex_string)
  jira_tickets    = from.join(' ').scan(jira_re).flatten.map{|t|t.upcase}.sort.uniq
  return jira_tickets
end


#####################################################################
# parse the pull_request sting into a structured format
# a_string that comprise a pull request merge marker

def parse_pull_request(a_string)
  pr_details    = /^\s.*#(?<id>\d+) in (?<repo>.*) from (?<source>.*) to (?<target>.*)$/.match(a_string)
  pull_request  = Hash[ pr_details.names.map{|k|k.to_sym}.zip( pr_details.captures ) ]
  return pull_request
end


#####################################################################
# extract all data for a pull_request into a structured format
# an_array of strings that comprise a single commit from the git log

def extract_pull_request(an_array)
  pr_string_index = an_array.index{|s| s.include?("Merge pull request")}
  pull_request = pr_string_index.nil? ? {} : parse_pull_request(an_array[pr_string_index])
  return pull_request
end


#####################################################################
# extract all data for a commit into a structured format
# an_array of strings that comprise a single commit from the git log

def parse_commit(an_array)
  commit_id     = an_array.first.split().last
  date          = extract_date(an_array)
  author        = extract_author(an_array)
  merge         = is_a_merge(an_array)
  pull_request  = merge ? extract_pull_request(an_array) : {}
  pull_request[:date] = date unless pull_request.empty?
  files         = extract_files(an_array)
  description   = extract_description(an_array)
  jira_tickets  = extract_jira_tickets from: [pull_request[:source], description]

  return {
    id:           commit_id,
    date:         date,
    author:       author,
    merge:        merge,
    pull_request: pull_request,
    files:        files,
    description:  description,
    jira_tickets: jira_tickets
  }
end


######################################################
# Main

result = `#{git_log_command}`.split("\n")

max_commits   = 3000
commit_count  = 0
line_count    = 0

commit_start_index  = 0
commit_stop_index   = 0

commits = []
commit  = {}

jira_hash = Hash.new

result.each do |a_line|
  # NOTE: Running backwards in time
  if a_line.start_with?('commit')
    commit_count += 1

    commit_start_index  = commit_stop_index + 1
    commit_stop_index   = line_count - 1

    unless commit_stop_index <= commit_start_index
      commit = parse_commit(result[commit_start_index .. commit_stop_index])
      commits << commit unless commit[:date].to_date > DATE_RANGE.last
      commit[:jira_tickets].each do |key|
        unless jira_hash.include?(key)
          jira_hash[key] = {summary: '', description: '', files: []}
        end
        jira_hash[key][:files] << commit[:files]
      end
      break if commit[:date].to_date < DATE_RANGE.first
      exit if commit_count >= max_commits
    end
  end

  line_count += 1
end # result.each do |a_line|

jira  = []
files = []
prs   = []

commits.reverse.each do |c|
  unless c[:pull_request].empty?
    jira << c[:jira_tickets]
    files << c[:files]
    jira  = jira.flatten.sort.uniq
    files = files.flatten.sort.uniq
    jira.each do |key|
      unless jira_hash.include? key
        jira_hash[key] = {summary: '', description: '', files: []}
      end
      jira_hash[key][:files] << files
      jira_hash[key][:files] = jira_hash[key][:files].flatten.sort.uniq
    end

    prs << {
      pull_request: c[:pull_request],
      jira:         jira_hash
    }

    # Reset for next PR
    jira_hash = {}
    jira  = []
    files = []
    next
  end
  jira << c[:jira_tickets]
  files << c[:files]
end

puts <<~EOS
This is the kind of information that is available from a git log
using the command '#{git_log_command}'

When the branch name and/or commit descriptions contain references to
JIRA ticket numbers those reference can be extracted and information
about the ticket can be retrieved from the associated project's
JIRA server.  Currently only the ticket summary and description are
being retrieved.

The format of this automatically generated report is raw.  Additional work will
be done to make the report more visually pleasing.

This report was made from commits that occurred in the follow date range:
  #{DATE_RANGE}

Just verified this raw data against bitbucket's PR page.  Discouraged ...
commits in log are not specifically tied to a PR.  I made a stupid ASSUMPTION
that the order of the commits was associated with the PR but that is just nuts.

Really need a good way to access the bitbucket PR record.  Did a quick look
at what gems are available ... slim pickens.

EOS

prs.reverse.each do |pr|

  puts "\n" + "="*65
  puts "Pull Request"
  puts "    date: #{pr[:pull_request][:date].strftime('%c')}"
  puts "      id: #{pr[:pull_request][:id]}"
  puts "    repo: #{pr[:pull_request][:repo]}"
  puts "  source: #{pr[:pull_request][:source]}"
  puts "  target: #{pr[:pull_request][:target]}"
  puts

  jira_hash = pr[:jira]

  jira_hash.keys.sort.each do |key|
    proj_id = key.split('-').first

    begin
      ticket = JIRA_CLIENT[proj_id].Issue.find(key)
    rescue
      ticket = OpenStruct.new(summary: 'not available', description: 'not available')
    end

    jira_hash[key][:summary]      = ticket.summary
    jira_hash[key][:description]  = ticket.description

    puts "\n#{key} - #{ticket.summary}"
    puts "\t" + "#{ticket.description.gsub("\n","\n\t").strip}"
    puts "\nFiles Effected:"
    puts "\t" + "#{jira_hash[key][:files].join("\n\t").chomp}"
  end

end # prs.reverse.each do |pr|


