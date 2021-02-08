#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: working_directory_from.rb
##  Desc: Create a git working directory for a specific branch based upon a JIRA ticket
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# TODO: flesh tgis out - add meat to the bones

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

cli_helper("Create a git working directory for a specific branch based upon a JIRA ticket") do |o|

  o.bool    '-b', '--bool',   'example boolean parameter',   default: false
  o.string  '-s', '--string', 'example string parameter',    default: 'IamDefault'
  o.int     '-i', '--int',    'example integer parameter',   default: 42
  o.float   '-f', '--float',  'example float parameter',     default: 123.456
  o.array   '-a', '--array',  'example array parameter',     default: [:bob, :carol, :ted, :alice]
  o.path    '-p', '--path',   'example Pathname parameter',  default: Pathname.new('default/path/to/file.txt')
  o.paths         '--paths',  'example Pathnames parameter', default: ['default/path/to/file.txt', 'file2.txt'].map{|f| Pathname.new f}

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

puts <<~IDEA

  Implement a similar process to that incoded in the 'cui' script.

  Given a base directory that has a tree structure like:

    Project
    .
    ├── master
    ├── release
    ├── review    <=- primary development branch name
    └── working
        ├── bugfix
        ├── chore
        ├── dewayne   <=- branch without a preview
        ├__ feature
            ├── AR-162755560
            └── AR-162755622

  Use system environment variables to config the basic sutt like:

    WDF_BASE_DIR=$HOME/sandbox/git_repos/athn
    WDF_DEV_DIR=$WDF_BASE_DIR/review
    WDF_WORK_DIR=$WDF_BASE_DIR/working
    WDF_JIRA_PROJECT_PREFIX=AR
    WDF_JIRA_TICKET_EXAMPLE=162755560
    # Use some of open_jira.rb

    when 'wdf 560' is entered then the following actions are taken:

      1. cp -R $WDF_DEV_DIR $WDF_WORK_DIR/<constuct directory name from branch name>
      2. cd $WDF_WORK_DIR/<constuct directory name from branch name>
      3. git checkout <branch name>
      4. bundle install
      5. <some other initialization stuff>

      maybe steps 4 and 5 can be retrieved from some common file for the project.


IDEA

__END__

Project
.
├── master
├── release
├── review
└── working
    ├── bugfix
    ├── chore
    ├── dewayne
    ├── feature
    │   ├── AR-162755560
    │   └── AR-162755622
    └── messed_up_AR-162755560
