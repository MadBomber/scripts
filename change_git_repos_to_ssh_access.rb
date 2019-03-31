#!/usr/bin/env ruby
# change_git_repos_to_ssh_access.rb
# Edits the 'git config remote.origin.url' from
# https://<user>@<stuff>
# to
# ssh://git@<stuff>
#
# BUT sometimes there is no "user@" pattern.

require 'debug_me'
include DebugMe


FIELD_NAME = 'remote.origin.url'
SSH_PREFIX = 'ssh://git@'

require 'pathname'  # STDLIB

here = Pathname.pwd

def update_to_ssh(a_directory)
  return unless (a_directory + '.git').exist?
  puts "\nUpdating to SSH access for #{a_directory.basename} ..."
  values = `cd #{a_directory} && git config --get #{FIELD_NAME}`.chomp.split('@')
  return if values.empty?
  new_value = SSH_PREFIX + values.last.gsub('https://','').gsub('http://','')
  `cd #{a_directory} && git config #{FIELD_NAME} #{new_value}`
end


if (here + '.git').exist?
  update_to_ssh(here)
else
  here.children.each do |dir|
    update_to_ssh(dir)
  end
end
