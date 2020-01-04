#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: erd_for.rb
##  Desc: Create ERD files for given database models
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'pathname'

RAILS_ROOT      = Pathname.new( ENV['RR']  ||  ENV['RAILS_ROOT']  ||  ENV['PWD'] )
DEFAULT_OUT_DIR = RAILS_ROOT + 'etc/doc'

require 'mods/string_mods'  # from lib/ruby

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Create ERD files for given database models") do |o|

  o.string  '-t', '--type',    'Type of Output File',              default: 'pdf'
  o.int     '-r', '--recursion_depth', 'Recursive Depth of Relationships', default: 1
  o.array   '-m', '--models',  'Model names seperated by comma'
  o.path    '-o', '--outdir',  'Directory to save ERD files',      default: DEFAULT_OUT_DIR

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')



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


base_command = %w[
  bundle exec erd
    --orientation=vertical
    --cluster
    --prepend_primary=true
    --sort=true
    --direct
].join(' ') + " --only_recursion_depth=#{configatron.recursion_depth}"


configatron.models.each do |model|
  command = base_command.dup

  puts
  puts "============================================================"
  puts "Generating ERD for #{model} ... "

  command += " --title='#{model} ERD'"
  command += " --only='#{model},'"

  model_filename = model.snakecase.gsub('/', '_')

  command += " --filename=#{configatron.outdir}/#{model_filename}_erd"
  command += " --filetype=#{configatron.type}"

  puts "Command:  #{command}"

  `#{command}`

end

