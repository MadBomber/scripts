#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: create_working_directory.rb
##  Desc: Create a git-based working directory for a specific ticket
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# This program depends on the ability to do `git up` which is
# provided by the gem "git-up"   so: gem install git-up
#
# System Environment Variables Used:
# PROJECT_DIR  The absolute path to the top-level git project directory

if ENV['PROJECT_DIR'].nil? || ENV['PROJECT_DIR'].empty?
  ENV['PROJECT_DIR'] = ENV['HOME'] + '/sandbox/git_repos/athn/advoy-rails'
end

# TODO: bring these branch names in from system environment variables

source_branch    = 'review'  # NOTE: 'development' and 'develop' are more common
update_branches  = %w[ master release ] << source_branch
working_dir_name = 'working'

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

NOT_PROVIDED = '** Not Provided **'

def not_provided?(thing)
  thing == NOT_PROVIDED
end

HELP = <<EOHELP
Important:

  The default value for the project root directory is:
    #{ENV['PROJECT_DIR']}

EOHELP


cli_helper("Create a git-based working directory for a specific ticket") do |o|

  o.string  '-b', '--branch-name',  'Branch Name [required]', default: NOT_PROVIDED
  o.path    '-p', '--project-dir',  'Project Directory Root', default: Pathname.new(ENV['PROJECT_DIR'])

end

# Error check your stuff; use error('some message') and warning('some message')

if not_provided?(configatron.branch_name)
  error 'The branch name is a required parameter; use -h or --help for usage instructions'
end

if String == configatron.project_dir.class
  configatron.project_dir = Pathname.new(configatron.project_dir)
end

unless configatron.project_dir.exist?  &&  configatron.project_dir.directory?
  error "Project directory root is invalid: #{configatron.project_dir}"
end

abort_if_errors


######################################################
# Local methods

def do_command(command)
  if debug? || verbose?
    puts "Command: #{command} ..."
  end
  result = `#{command}`
end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

# Make sure that the source working directories are up to date.
# There is a base director where all work on this project is happening
# In this case its $HOME/sandbox/git_repos/athn/advoy-rails
# Call this $PROJECT_DIR

PROJECT_DIR   = configatron.project_dir
WORKING_ROOT  = PROJECT_DIR + working_dir_name


update_branches.each do |branch|
  do_command "cd #{PROJECT_DIR + branch} && git up"
end


SOURCE_DIR = PROJECT_DIR + source_branch

target_branch  = configatron.branch_name
TARGET_DIR     = WORKING_ROOT + target_branch

# do_command "mkdir -p #{TARGET_DIR}"


# recurisvely copy the source WD to the target WD
# may need to mkdir [feature|bugfix|chore] if it does not already exist

do_command "cp -R #{SOURCE_DIR} #{TARGET_DIR}"



# GoTo the new WD and do a git checkout of the target branch
# This assumes that the target branch already exists

# TODO: configatron.branch_name is already a branch?  If not,
#       then need to create the branch before checking it out.

do_command "cd #{TARGET_DIR} && git checkout #{target_branch}"


# Do a git status to update all of the junk in the .git directory

do_command "cd #{TARGET_DIR} && git status"



# If a file '.envrc' exists then do 'direnv allow'

ENVRC = TARGET_DIR + '.envrc'

if ENVRC.exist?
  do_command "cd #{TARGET_DIR} && direnv allow"
end

PREP_SCRIPT = 'prepare_default_config_for_development'
PREP_FILE   = TARGET_DIR + PREP_SCRIPT

if PREP_FILE.exist?  &&  PREP_FILE.file?  &&  PREP_FILE.executable?
  do_command "cd #{TARGET_DIR} && ./#{PREP_SCRIPT}"
end




# TODO: on previous project-specific version of this kind of script
#       there was some additional steps that followed on like
#         bundle install; database rebuild
#       Might have a project-specific script at the working root that
#       gets invoked with the branch name as a parameter.  The script
#       would then cd into the branch's working directory and do initialization
#       stuff.

__END__

PROJECT_DIR
|-- update_branch_1   'master'
|-- update_branch_2   'release'
|-- source_branch     'review' | 'development' | 'develop'
|__ working
    |-- simple_ticket_with_no '/'
    |-- 'bugfix'
    |__ 'feature'
    |   |__ ticket_id
    |__ level_1
        |__ level_2 ...
            |__ ticket_id

