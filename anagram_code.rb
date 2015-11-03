#!/usr/bin/env ruby

if ARGV.empty?
  STDERR.puts
  STDERR.puts 'ERROR: This program needs a sentence without punction as parameters'
  STDERR.puts
  exit
end


table = Hash.new { |h,k|
  h[k] = []
}



words     = ARGV.map{|w| w.downcase}

anagram_code = words.map{|w| w.chars.sort.join}.sort


puts anagram_code.join(' ')

