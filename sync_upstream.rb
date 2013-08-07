#!/usr/bin/env ruby
###################################################
###
##  File: sync_upstream.rb
##  Desc: Update all forked projects with their upstream master
#

require 'pathname'

pgm_name = Pathname.new(__FILE__).basename

def usage
  puts <<-EOS

Sync a git repo with its upstream remote
Sync a directory of git repos with their upstream remotes

Usage:  #{pgm_name} [directory]

Where:

  directory (optional)    a path to a directory of github repos
                          or to a specific repo directory.
                          Default is the current working directory.

EOS

end


if ARGV.empty?
  github_account_dir = Pathname.pwd
elsif '-h' == ARGV.first  or  '--help' == ARGV.first
  usage
  exit
else
  github_account_dir = Pathname.new(ARGV.shift)
  unless github_account_dir.directory?
    puts "ERROR: not a valid directory."
    puts "       #{github_account_dir}"
    usage
    exit 1
  end

end


if (github_account_dir+'.git').exist?
  git_repos = [ github_account_dir ]
else
  git_repos = github_account_dir.children
end

git_repos.each do |repo|

	unless repo.directory?  and  (repo+'.git').exist?  and  (repo+'.git').directory?
		next
	end

	system(<<EOS)
cd #{repo}
echo #{"="*55}
echo "== Syncing: `pwd`"
git fetch upstream &&
git checkout master &&
git merge upstream/master &&
git push
EOS

end

