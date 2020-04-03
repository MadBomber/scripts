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

configatron.version = '0.0.2'

HELP = <<EOHELP
Important:

  Use --group to generate one ERD that has all the models listed.
  Without --group individual ERD files will be created for each model.

  If --group then --title should also be used otherwise the title
  will be the name of the first model in the list.

  Note that --exclude will not automatically exclude models that are
  "downstream" from the excluded models.  i.e. the excluded model's
  relationships.  To exclude those models as well they MUST be in
  the list of models excluded.

EOHELP

cli_helper("Create ERD files for given database models") do |o|

  o.string  '-t', '--type',    'Type of Output File',                       default: 'pdf'
  o.int     '-r', '--recursion_depth', 'Recursive Depth of Relationships',  default: 1
  o.array   '-e', '--exclude', 'Exclude model names seperated by comma',    default: []
  o.array   '-m', '--models',  'Model names seperated by comma'
  o.string  '-T', '--title',   'Title defaults to Model Name',            default: ''
  o.boolean '-g', '--group',   'Group models together into one ERD',      default: false
  o.path    '-o', '--outdir',  'Directory to save ERD files',             default: DEFAULT_OUT_DIR
  o.string  '-f', '--filename', 'Base name of the output file',           default: ''
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

base_command += " --exclude #{configatron.exclude.join(',')}," unless configatron.exclude.empty?


configatron.models.each do |model|
  command = base_command.dup

  puts
  puts "============================================================"

  if group?
    puts "Generating ERD for #{configatron.models.join(', ')} ... "
    all_models = configatron.models.join(',')
    command += " --only='#{all_models},'"
  else
    puts "Generating ERD for #{model} ... "
    command += " --only='#{model},'"
  end

  command += configatron.title.empty? ? " --title='#{model} ERD'" : " --title='#{configatron.title}'"

  if configatron.filename.empty?
    model_filename = model.snakecase.gsub('/', '_')
    command += " --filename=#{configatron.outdir}/#{model_filename}_erd"
  else
    command += " --filename=#{configatron.outdir}/#{configatron.filename}"
  end

  command += " --filetype=#{configatron.type}"

  puts "Command:  #{command}"

  `#{command}`

  break if group?

end

