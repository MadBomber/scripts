#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: install_gems_from_file.rb
##  Desc: Take a list of gem names and installs them
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'yaml'
require 'ruby-progressbar'

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

cli_helper("return minimum set of gems to install") do |o|
  o.path    '-f', '--file',     'file containing gem names'
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

if configatron.file.nil?
  error("Argument is missing: -f/--file")
end

unless configatron.arguments.empty?
  warning("Unknown arguments ignored: #{configatron.arguments.join(' ')}")
end


abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  STDERR.puts
  STDERR.puts "Done."
  STDERR.puts
end

ap configatron.to_h  if verbose? || debug?


array_of_gems = configatron.file.read.split("\n")


gem_count   = array_of_gems.size
batch_size  = 10


progressbar = ProgressBar.create(
    title: 'Gems',
    total: gem_count / batch_size,
    format: '%t: [%B] %c/%C %j%% %e',
    output: STDERR
  )

array_of_gems.each_slice(batch_size) do |batch|
  progressbar.increment
  next if batch.nil? || batch.empty?

  `gem install #{batch.join(' ')}`
end

progressbar.finish
