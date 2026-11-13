#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: fix_perms.rb
##  Desc: Fix file/directory permissions
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'
require 'pathname'

FILE_PERM = 0644  # rw-r--r--
DIR_PERM  = 0755  # rwxr-xr-x
HERE      = Pathname.pwd

######################################################
# Local methods

def fix_dir(dir_path)
  puts dir_path.relative_path_from(HERE)

  kids = dir_path.children 
  kids.each do |a_path|
    next if '.git' == a_path.basename.to_s

    if a_path.directory?
      a_path.chmod(DIR_PERM)
      fix_dir(a_path)
    else
      a_path.chmod(FILE_PERM)
    end
  end
end

at_exit do
  puts
  puts "Done."
  puts
end

def restore_git_perm(a_path)
  puts a_path   # .relative_path_from(HERE.realpath)
  diff = IO.popen(['git', 'diff', '--', a_path.to_s], &:read).split("\n")
  if 3 == diff.size
    diff_perm = Integer(diff[1][11..])
    a_path.chmod(diff_perm)
  end
end

######################################################
# Main

# fixx all files even the untracked ones
fix_dir(HERE)

# Now for those that are tracked, if they differ from what
# they should be according to git, then restore the mode that
# git wants.

# --relative gives paths from the current directory, not the repo top
files = IO.popen(%w[git diff --name-only --relative -z], &:read).split("\0").map{|f| Pathname.new(f)}

files.each do |f|
  restore_git_perm(f)
end
