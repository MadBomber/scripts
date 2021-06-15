#!/usr/bin/env ruby
######################################################
###
##  File: blessing.rb
##  Desc: Say a blessing
#

require 'pathname'

blessings_path = Pathname.new(__FILE__).parent + 'blessings.txt'

require 'os'  # Simple and easy way to know if you're on windows or not (reliably), as well as how many bits the OS is, etc.


blessings = blessings_path
              .readlines
              .reject{|entry| entry.start_with?('#')}
              .reject{|entry| 0 == entry.chomp.strip.size}

finished = false

until ( finished ) do
  blessing = blessings.sample

  puts blessing
  system "say '#{blessing}'" if OS.mac?

  print "\nWant another?  (Y/n) "
  want_another = gets().downcase.chomp.strip
  finished = true if !want_another.empty? && want_another.start_with?('n')
  puts
end