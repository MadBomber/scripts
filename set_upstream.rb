#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: set_upstream.rb
##  Desc: Set the remote upstream value
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# Uses:
#   ENV['GITHUB_ACCOUNT']
#   ENV['GITHUB_API_TOKEN']
#
# TODO: add support for bitbucket.com hosted clones

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors

require 'github_api'

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

# SMELL: this is overkill since there is only one parameter
require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.2'

DEFAULT_LOCALTION_OF_CLONES   =
  Pathname.new(Nenv.home) + 'sandbox' + 'git_repos' + 'madbomber'

HELP = <<~EOHELP
  Important:

    Only works with working directories of clones that are
    hosted on github.com

    The default --dir path is
      #{DEFAULT_LOCALTION_OF_CLONES}

EOHELP

cli_helper("\nSet the upstream remote for github forked clones") do |o|
  o.path    '--dir',   'Directory containing sub-directories of github-based clones',
    default: DEFAULT_LOCALTION_OF_CLONES
end

unless configatron.dir.directory?
  error "Directory does not exist: #{configatron.dir}"
end

abort_if_errors


######################################################
# Local methods

# If the repository cloned into the working directory
# is forked from someone that is not me, then set the
# upstream remote to that original repository if its
# not already set.
def set_upstream(clone_path, upstream_url)
  remotes = `cd #{clone_path} && git remote -v`
  unless remotes.include?('upstream')
    puts `cd #{clone_path} && git remote add upstream #{upstream_url}`
  end
end # def set_upstream(clone_path, upstream_url)

# obtain the github.com hosted repository details
# of the cloned working directories
def get_github_repos_already_cloned
  repos = Array.new

  configatron.dir.children.each do |repo_name|
    if repo_name.directory?
      begin
        repo = Github.repos.get(
          user:         ENV['GITHUB_ACCOUNT'],
          oauth_token:  ENV['GITHUB_API_TOKEN'],
          repo:         repo_name.basename.to_s
        )
      rescue Exception => e
        puts "\n#{e}"
        next
      end
      repos << repo if repo.fork
    end
  end # configatron.dir.children.each do |repo_name|

  return repos
end # def def get_github_repos_already_cloned

# The main() process
def process_github_clones
  repos = get_github_repos_already_cloned
  repos.each do |r|
    # SMELL: does not work if the working copy directory does
    #        not match the repo name
    clone_path = configatron.dir + r.name
    set_upstream(clone_path, r.parent.html_url)
  end
end # def process_github_clones

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

process_github_clones

