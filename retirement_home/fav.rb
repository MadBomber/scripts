#!/usr/bin/env ruby
##########################################
###
##  File: fav.rb
##  Desc: Build gem install command
##
##  Input is STDIN a list of gem names, 1 per line
#

#require 'amazing_print'
require 'systemu'

installed_gems = systemu("gem list")[1].split("\n").map {|g| g.split(' ').first if g.include?("(")}

fav_gems = ARGF.read.split("\n")

cmd = ""

java_gems = Array.new

fav_gems.uniq.each do |fav_all|

  fav = fav_all.split(' ').first

  fav_all.downcase!

  unless installed_gems.include?(fav)
    unless fav_all.include?('java') or fav_all.include?('jruby') or fav_all.include?('jar')
      cmd += " "+fav
    else
      java_gems << fav
    end
  end
end

puts "\ngem install" + cmd unless cmd.empty?

unless java_gems.empty?
  puts
  puts "rvm use jruby; sleep 1; gem install "+java_gems.join(' ')
end

puts

__END__

macruby-0.12 - #importing default gemsets, this may take time...............
^CError running '__rvm_with macruby-0.12 /Users/dvanhoozer/.rvm/scripts/gemsets initial',
please read /Users/dvanhoozer/.rvm/log/macruby-0.12/1370961061_gemsets.initial.log
Saving wrappers to '/Users/dvanhoozer/.rvm/wrappers/macruby-0.12'....................


