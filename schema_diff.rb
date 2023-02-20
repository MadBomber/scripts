#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: schema_diff.rb
##  Desc: Diff the schema of two rails databases
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
#   Desc: compare the ActiveRecord schema(s) of two Rails environments
#

require 'pathname'

pwd         = Pathname.pwd
DB_DIR      = pwd + 'db'
BACKUP_DIR  = DB_DIR + 'backup'

def show_usage
  puts <<~EOS

    Usage: schema_diff.rb env1 env2

    Dumps the schema of two different environments
    then does a diff on them.

    This script is expected to be run from
    the root directory of a Rails application.

  EOS
end

unless DB_DIR.exist?
  error "Expecting to be run from a Rails.root directory; but, no 'db' sub-directory was found."
end

# Display the usage info
if  ARGV.size != 2 ||
    ARGV.include?('-h') || ARGV.include?('--help') 
  show_usage
  exit
end

env1 = ARGV[0]
env2 = ARGV[1]



######################################################
# Local methods

def error(msg)
  STDERR.print "\nERROR: #{msg}\n\n"
  exit(1)
end


def move_schemas_to (a_directory)
  puts "Saving schema(s) to #{a_directory.basename} ..."
  `mv #{DB_DIR}/*schema.rb #{a_directory}`
end


def backup_current_schema
  unless BACKUP_DIR.exist?
    BACKUP_DIR.mkdir
  end

  move_schemas_to BACKUP_DIR
end


def restore_current_schema
  unless BACKUP_DIR.exist?
    error "no db/backup directory was found"
  end

  puts "Restoring current schemas from backup ..."
  `mv #{BACKUP_DIR}/* #{DB_DIR}`
  `rm -fr #{BACKUP_DIR}`
end


def dump_schema(env)
  env_dir = DB_DIR + "#{env}_schema"
  env_dir.mkdir unless env_dir.exist?

  puts "dumping schema(s) for #{env} environment ..."

  `RAILS_ENV=#{env} bundle exec rake db:schema:dump`  
  move_schemas_to env_dir
end

def diff_schema(env1, env2)
  env1_dir = DB_DIR + "#{env1}_schema"
  env2_dir = DB_DIR + "#{env2}_schema"

  puts "Comparing the #{env1} and #{env2} environment schema(s) ..."

  `diff #{env1_dir} #{env2_dir}`
end

######################################################
# Main


backup_current_schema
dump_schema(env1)
dump_schema(env2)
restore_current_schema
diff = diff_schema(env1, env2)

if diff.empty?
  print "\nThe schemas are the same.\n\n"
else
  print "\nSchema differences are shown below ...\n\n"
  puts diff
  puts
end
