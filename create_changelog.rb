#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: create_changelog.rb
##  Desc: Create an CHANGELOG file from a git log that contains
##        references to JIRA tickets that document the work effort.
##        Use the Bitbucket REST API and the JIRA REST API
##        tp get details about the associated resource.
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# TODO: accept configuration from YAML file instead of SEV.
# TODO: use some kind of template file for report layout

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
require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'date'           # STDLIB
require 'json'           # STDLIB
require 'ostruct'        # STDLIB
require 'Pathname'


require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'jira-ruby'      # Ruby Gem for use with the Atlassian JIRA REST API
require 'faraday'        # HTTP/REST API client library.


require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
System Environment Variables Used:

  Name            Description
  CCL_PROJECTS    Comma separated list of JIRA project IDs
  CCL_URL_xxxx    The JIRA server base URL for project xxxx
  CCL_USER_xxxx   The user name for project xxxx to login to the server
  CCL_PASS_xxxx   The user password for project xxxx for login

  BB_HOST         Bitbucket host server with protocol: 'https://bitbucket.com'
  BB_USER         username for basic authentication
  BB_PASS         username's password
  BB_PROJECT      Bitbucket project slug.  Example: 'JIRA'
  BB_REPO         Bitbucket repository slug. Example: 'jira'
  BB_API_BASE     Example: "/rest/api/1.0/projects/$BB_PROJECT/repos/$BB_REPO"

EOHELP

desc = <<~EOS
  Create a CHANGELOG file from a git log that contains
  references to JIRA tickets that document the work effort.
EOS

# TODO: take multiple PR numbers from the command line.

cli_helper(desc) do |o|

  o.int     '-p', '--pull_request', 'Pull Request ID'
  o.path    '-w', '--work_dir',     'Working Directory (Default: $CWD)',        default: Pathname.pwd
  o.string  '-o', '--output',       'Output filename (Default: CHANGELOG.txt)', default: 'CHANGELOG.txt'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


unless configatron.work_dir.exist?
  error "Working Directory Does Not ExistL #{configatron.work_dir}"
else
  unless configatron.work_dir.directory?
    error "Working Directory must be a directory: #{configatron.work_dir}"
  end
end

abort_if_errors

#############################################################
# Validate the System Environment Variables

required_sev = %w[
  CCL_PROJECTS
  BB_HOST
  BB_USER
  BB_PASS
  BB_PROJECT
  BB_REPO
  BB_API_BASE
].map{|sev| sev.upcase}

sev_errors = []

required_sev.each do |sev|
  if ENV[sev].nil?  ||  ENV[sev].empty?
    sev_errors << sev
  end
end

unless sev_errors.include?('CCL_PROJECTS')
  CCL_PROJECTS = ENV['CCL_PROJECTS'].split(',').map{|proj_id| proj_id.strip.upcase}
else
  CCL_PROJECTS = []
end

unless sev_errors.empty?
  sev_errors.each do |sev|
    error "#{sev} is not defined."
  end
end

sev_warnings = []
CCL_PROJECTS.each do |proj_id|
  %w[ CCL_USER CCL_PASS CCL_URL ].each do |sev_base|
    sev = "#{sev_base}_#{proj_id}"
    if ENV[sev].blank?
      sev_warnings << sev
    end
  end
end

unless sev_warnings.empty?
  sev_warnings.each do |sev|
    warning "#{sev} is not defined."
  end
end

abort_if_errors

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
# Create a connection the REST API for bitbucket server

BB_HOST     = ENV['BB_HOST']      || 'https://bitbucket.com'
BB_USER     = ENV['BB_USER']      || 'username'
BB_PASS     = ENV['BB_PASS']      || 'password'
BB_PROJECT  = ENV['BB_PROJECT']   || 'PROJ'
BB_REPO     = ENV['BB_REPO']      || 'repo'
BB_API_BASE = ENV['BB_API_BASE']  || "/rest/api/1.0/projects/#{BB_PROJECT}/repos/#{BB_REPO}"

BB = Faraday.new(url: BB_HOST)
BB.basic_auth(BB_USER, BB_PASS)


#############################################################
# Adding a little sugar to String to support
# duck typing requirement of the extract_jira_tickets method

class String
  def join
    self
  end
end


# Sometimes the PR's description field is missing
class NilClass
  def chomp
    ''
  end
end

#############################################################
# build the command for retrieving the git log

git_log_command = "git -C #{configatron.work_dir} log --name-status"



#####################################################
## Helpers for Parsing Commit Entries in a GIT Log ##
#####################################################


def get_pull_request(pr_id)
  r = BB.get("#{BB_API_BASE}/pull-requests/#{pr_id}")
  raise "Gotta Problem: #{r.reason_phrase}" unless 'OK' == r.reason_phrase
  return JSON.parse(r.body)
end


def get_commits_for_pr(pr_id)
  r = BB.get("#{BB_API_BASE}/pull-requests/#{pr_id}/commits?limit=9999")
  raise "Gotta Problem: #{r.reason_phrase}" unless 'OK' == r.reason_phrase
  return JSON.parse(r.body)['values']
end


def extract_commit_ids(an_array)
  result = Array.new
  an_array.each do |commit|
    result << commit['displayId']
    commit['parents'].each do |commit_ref|
      result << commit_ref['displayId']
    end
  end
  return result.flatten.sort.uniq
end


def convert_unix_timestamp(an_integer)
  unix_timestamp = an_integer / 1000 # Drop the milliseconds
  return Time.at unix_timestamp
end


def format_pr_user(a_hash)
  formatted_name = a_hash['displayName'] + " (" + a_hash['emailAddress'] + ")"
  return formatted_name
end


# TODO: take multiple PR numbers from the command line.

puts "Retrieving PR ##{configatron.pull_request} ..." if verbose?

begin
  pr = get_pull_request configatron.pull_request
rescue
  error "Invalid Pull Request: #{configatron.pull_request}"
  # TODO: find out what the valid PRs values are and report them in the error message.
end

abort_if_errors


pr_author     = format_pr_user pr["author"]["user"]
pr_reviewers  = pr["reviewers"].map{ |reviewer| format_pr_user(reviewer['user']) }


pr_created_date = convert_unix_timestamp pr["createdDate"]
pr_updated_date = convert_unix_timestamp pr["updatedDate"]

commits_from_pr = get_commits_for_pr configatron.pull_request

pr_commits = extract_commit_ids commits_from_pr




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

at_exit do
  puts "Done." if verbose?
end


puts "Executing: #{git_log_command} ..." if verbose?

result = `#{git_log_command}`.split("\n")

max_commits   = 3000
commit_count  = 0
line_count    = 0

commit_start_index  = 0
commit_stop_index   = 0

commits = {} # key = id[0,11]
commit  = {}

jira_hash = Hash.new


puts "Parsing git log ..." if verbose?

result.each do |a_line|
  # NOTE: Running backwards in time
  if a_line.start_with?('commit')
    commit_count += 1

    commit_start_index  = commit_stop_index + 1
    commit_stop_index   = line_count - 1

    unless commit_stop_index <= commit_start_index
      commit = parse_commit(result[commit_start_index .. commit_stop_index])
      commits[commit[:id][0,11]] = commit
      commit[:jira_tickets].each do |key|
        unless jira_hash.include?(key)
          jira_hash[key] = {summary: '', description: '', files: []}
        end
        jira_hash[key][:files] << commit[:files]
      end
      exit if commit_count >= max_commits
    end
  end

  line_count += 1
end # result.each do |a_line|


#########################################################
# Do the CHANGELOG report

# FIXME: There is something wrong.  Not all JIRA tickets are being
#        shown in the report with impacted files.  The files are
#        showing up at the bottom of the PR's section and not after
#        the JIRA ticket to which they belong.

output_path = configatron.work_dir + configatron.output
backup_path = configatron.work_dir + (configatron.output + '.bak')


puts "Creating #{output_path} ..." if verbose?


if output_path.exist?
  output_path.rename(backup_path)
end

unless backup_path.exist?
  f = File.open(backup_path, 'w')
  f.close
end

OUTFILE = File.open(output_path, 'w')


jira  = []
files = []

pr_commits.each do |commit_key|
  unless commits[commit_key].present?
    OUTFILE.puts "WARNING: Commit not present: #{commit_key}"
    next
  end

  commit  = commits[commit_key]
  jira    << commit[:jira_tickets]
  files   << commit[:files]
end

jira  = jira.flatten.sort.uniq
files = files.flatten.sort.uniq


OUTFILE.puts <<EOS

----------------------------------------------------------------------------

Pull Request ID: #{pr['id']}  From: #{pr["fromRef"]["displayId"]}  To: #{pr["toRef"]["displayId"]}
   Created Date: #{pr_created_date.strftime('%c')}
   Updated Date: #{pr_updated_date.strftime('%c')}

          Title: #{pr['title']}

         Author: #{pr_author}

      Reviewers: #{pr_reviewers.join("\n                 ")}

#{pr['description'].chomp.strip}

This pull request contains the following JIRA tickets:

EOS

jira.each do |key|
  proj_id = key.split('-').first

  begin
    ticket = JIRA_CLIENT[proj_id].Issue.find(key)
  rescue
    ticket = OpenStruct.new(summary: 'not available', description: 'not available')
  end

  OUTFILE.puts "  #{key} - #{ticket.summary}"
  jira_hash[key][:files].flatten.sort.uniq.each {|f| OUTFILE.puts "    #{f.gsub("\t",'  ')}" }
  OUTFILE.puts
end

OUTFILE.puts <<EOS

This pull request impacted the following files:

  #{files.join("\n  ")}

EOS

OUTFILE.puts backup_path.read
OUTFILE.close


