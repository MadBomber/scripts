#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: set_upstream.rb
##  Desc: Set the remote upstream value
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'


HELP = <<EOHELP
Important:

  The format of the text file must contain lines that
  are in the pattern:

    forked from account/repo_name

  Have not found a github API that returns the
  foked from value.  I created the file by hand
  using the github.com > my profile > repositories > forks
  doing a select all and a copy then a paste into a
  text file.

EOHELP

cli_helper("Set the upstream remote for github forked clones") do |o|

  o.path    '--dir',   'Directory containing sub-directories of github-based clones',
    default: Pathname.new(Nenv.home+'/sandbox/git_repos/madbomber')
  o.path    '-u', '--upstream',   'Text file of forked from lines',
    default: Pathname.new('upstream.txt')

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

unless configatron.upstream.exist?
  error "File does not exist:  #{configatron.upstream}"
else
  lines = configatron.upstream.read.split("\n").map{|v|v.chomp.strip}
  lines.select!{|v| v.start_with?('forked from')}
  if lines.empty?
    error "File is not formatted correctly.  See --help"
  else
    lines.map! do |a_line|
      a_line.split.last
    end
  end
end

unless configatron.dir.directory?
  error "Directory does not exist: #{configatron.dir}"
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

lines.each do |upstream|
  repo_name = upstream.split('/').last
  repo_path = configatron.dir + repo_name
  puts
  print upstream + " ... "

  unless repo_path.directory?
    `cd #{configatron.dir} && git clone https://madbomber@github.com/MadBomber/#{repo_name}.git`
    print 'CLONED '
  end

  puts

  remotes = `cd #{repo_path} && git remote -v`
  puts remotes
  unless remotes.include?('upstream')
    puts `cd #{repo_path} && git remote add upstream https://github.com/#{upstream}.git`
  end

end
