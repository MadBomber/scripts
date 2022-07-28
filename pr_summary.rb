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
#   A JSON file from Github
#

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

  Put important stuff here.

EOHELP

cli_helper("Format a Summary of Pull Requests") do |o|

  o.bool    '-b', '--bool',   'example boolean parameter',   default: false
  o.string  '-s', '--string', 'example string parameter',    default: 'IamDefault'

end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, '.json')

if configatron.input_files.empty?
  error 'No JSON files were provided'
end

abort_if_errors


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


json_file_path = configatron.input_files.first

options_hash = {
  symbolize_keys:         true,
  allow_multiple_values:  true
}

parser        = FFI_Yajl::Parser.new( options_hash )
pull_requests = parser.parse( json_file_path.read ).flatten


counter = 0

team = %w[ MadBomber rileygelwicks huezoaa roger88ist RobGelbman]

pull_requests.each do |pr|
  assignee = pr.dig(:assignee, :login)
  next unless team.include? assignee

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

These are all of the keys to a PR

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
