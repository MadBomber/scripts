#!/usr/bin/env ruby
###################################################
###
##  File: sync_upstream.rb
##  Desc: Update all forked projects with their upstream master
#

require 'pathname'

pgm_name = Pathname.new(__FILE__).basename

if ARGV.empty?
  github_account_dir = Pathname.pwd
else
  github_account_dir = Pathname.new(ARGV.first)
  unless github_account_dir.directory?
    puts "ERROR: not a valid directory."
    puts "       #{ARGV.first}"
    ARGV[0] = '--help' # force the usage message
  end
end

if '-h' == ARGV.first  or  '--help' == ARGV.first
  puts <<-EOS

Usage:  #{pgm_name} [directory]

Where:

  directory (optional)    a path to a directory of github repos
                          or to a specific repo directory.
                          Default is the current working directory.

EOS
exit
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

	system(<<EOF)
cd #{repo} &&
pwd &&
git fetch upstream &&
git checkout master &&
git merge upstream/master &&
git push
EOF

end

