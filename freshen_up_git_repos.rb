#!/usr/bin/env ruby
# freshen_up_git_repos.rb
# brew install git-fresh
#
# This program does basically the same as gitup
# brew install gitup


require 'pathname'

here = Pathname.pwd

if (here + '.git').exist?

  puts "\nFreshinging #{here.basename} ..."
  system "git-fresh"

else

  here.children.each do |dir|
    if (dir + '.git').exist?
      puts "\nFreshinging #{dir.basename} ..."
      system "cd #{dir} && git-fresh"
    end
  end

end
