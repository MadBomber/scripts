#!/usr/bin/env ruby
# freshen_up.rb

require 'pathname'

here = Pathname.pwd

here.children.each do |dir|
  if (dir + '.git').exist?
    puts "\nFreshinging #{dir.basename} ..."
    system "cd #{dir} && git-fresh"
  end
end
