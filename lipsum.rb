#!/usr/bin/env ruby
###############################################################
###
##  File: lipsum.rb
##  Desc: Puts some filler text to STDOUT
#

require 'lipsum'  # Get placeholder text from lipsum.com

if ARGV.empty? or ARGV.first == '-h' or ARGV.first == '--help'
  puts
  puts "Usage: lipsum NUMBER"
  puts
  puts "  Where:  NUMBER is the number of paragraphs desired."
  puts
  exit
end

number_of_paragraphs  = ARGV.first.to_i

puts
puts Lipsum::paragraphs[number_of_paragraphs]
puts
