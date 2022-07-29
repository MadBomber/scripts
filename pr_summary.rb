#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: pr_summary.rb
##  Desc: Format a Summary of Pull Requests
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# INPUT
#   JSON data from Github
#     provided by a file or coming directly
#     from the results of a GH command.
#
#                                           owner/repo_name
GITHUB_REPO = ENV.fetch('GITHUB_REPO', 'MadBomber/scripts')

# List of GitHub account user names for the current team
TEAM = %w[ MadBomber rileygelwicks huezoaa roger88ist RobGelbman]

require 'date'
require 'ffi_yajl'

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:
  The 'gh' CLI for github must be setup in your environment.

  brew install gh

  The 'gh' application needs to be authorized in your
  github.com account.

  The system environment variable GITHUB_API_TOKEN should be setup
  in your shell.

  Use the --repo option to over-ride the value in the system environment
  variable GITHUB_REPO which is in the normal form owner/repo_name.
EOHELP

cli_helper("Format a Summary of Pull Requests") do |o|

  o.string  '-r', '--repo', 'owner/repo_name', default: GITHUB_REPO

end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, '.json')

if configatron.input_files.empty?
  STDERR.puts 'INFO: No JSON files were provided.  Using "GH" command.'
  if  !configatron.repo.include?('/') ||
       configatron.repo.include?(' ')
    error "GITHUB_REPO is badly formatted: '#{configatron.repo}'"
  end
end

abort_if_errors


GH_COMMAND = <<~SHELL_COMMAND
  gh api \
  -H "Accept: application/vnd.github+json" \
  /repos/#{configatron.repo}/pulls \
  --paginate
SHELL_COMMAND


STDERR.puts "INFO: This is the GH COMMAND ..."
STDERR.puts GH_COMMAND


options_hash = {
  symbolize_keys:         true,
  allow_multiple_values:  true
}

parser        = FFI_Yajl::Parser.new( options_hash )

######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

# Report Title
puts "Tean Open PRs"
print "Source: "

if configatron.input_files.empty?
  json_data = `#{GH_COMMAND}`

  if '[' == json_data[0]
    puts "#{configatron.repo}"
  else
    error_message = parser.parse( json_data )

    STDERR.puts <<~EOS

      ERROR:  #{error_message.pretty_inspect}
              Most likely cause is that the repo
              owner or name is incorrect ...
              Using: '#{configatron.repo}'

    EOS
    exit(1)
  end
else
  # TODO: support multiple files
  json_file_path  = configatron.input_files.first
  json_data       = json_file_path.read
  puts json_file_path.basename.to_s
end

puts

pull_requests = parser.parse( json_data ).flatten


counter = 0

pull_requests.each do |pr|
  assignee = pr.dig(:assignee, :login)
  next unless TEAM.include? assignee

  counter += 1

  labels  = pr[:labels].map{|e| e[:name]}.join(", ")
  age     = (Date.today - Date.parse(pr[:created_at])).to_i

  reviewers  = pr[:requested_reviewers].map{|e| e[:login]}.join(", ")

  target_branch = pr.dig(:base, :ref)
  source_branch = pr.dig(:head, :ref)

  puts <<~END_OF_PR

    #{pr[:draft] ? "DRAFT:  " : "PR:     "} #{pr[:number]}  (#{pr[:state]}) Labels: #{labels}    
    Title:   #{pr[:title]}
      
      Created: #{pr[:created_at]}   AGE: #{0==age ? '': age} #{0==age ? 'New Created Today': 1==age ? 'day' : 'days'}
      Github:  #{pr[:html_url]}

      Merge:   #{target_branch}  <=- #{source_branch}
      Diff:    #{pr[:diff_url]}

      Assignee:  #{assignee}
      Reviewers: #{reviewers}

  END_OF_PR
end




__END__

These are all of the keys to a PR Hash

 :id,
 :node_id,
 :html_url, xxx
 :diff_url,
 :patch_url,
 :issue_url,
 :number, xxx
 :state, xxx
 :locked,
 :title, xxx
 :user,
 :body,
 :created_at, xxx
 :updated_at, xxx
 :closed_at,
 :merged_at,
 :merge_commit_sha,
 :assignee, xxx
 :assignees,
 :requested_reviewers, xxx
 :requested_teams,
 :labels, xxx
 :milestone,
 :draft, xxx
 :commits_url,
 :review_comments_url,
 :review_comment_url,
 :comments_url,
 :statuses_url,
 :head, xxx
 :base, xxx
 :_links,
 :author_association,
 :auto_merge,
 :active_lock_reason
