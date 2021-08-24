#!/usr/bin/env ruby
##############################################
## File: compare_to_master.rb
## Compare To Master

=begin

  The idea is that you need to compare some file or directory
  to the same location within the master branch.
  Need to use direnv's .envrc to set the MASTER_BRANCH_DIR

=end

require 'pathname'

require 'debug_me'
include DebugMe


rr_dir      = Pathname.new(ENV['RR'])
master_dir  = Pathname.new(ENV['MASTER_BRANCH_DIR'])
here_dir    = Pathname.pwd

if ARGV.empty?
  puts 'Where are the params?'
  exit 1
end

file_paths = ARGV.map{|f| here_dir + f}

debug_me{[
  :rr_dir,
  :master_dir,
  :here_dir,
  :file_paths
]}

# TODO: figure out what you want to do then implement it
