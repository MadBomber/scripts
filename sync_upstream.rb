#!/usr/bin/env ruby
###################################################
###
##  File: sync_upstream.rb
##  Desc: Update all forked projects with their upstream master
#

require 'date'
require 'pathname'

require 'awesome_print'

github_account_dir	= ENV['HOME']+'/sandbox/github_repos/madbomber'
git_repos 					= Pathname.new(github_account_dir).children


git_repos.each do |repo|

	unless repo.directory?
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

