#! /usr/bin/env ruby
# encoding: UTF-8

require "wordy"

m = ARGV.shift || "body"

if m.to_i > 0
  c = m.to_i
  m = ARGV.shift || "body"
else
  c = 1
end

if m && Wordy.respond_to?(m)
  puts Wordy.send(m, c)
elsif m == "-v"
  puts "Wordy v#{Wordy::VERSION}"
else
  puts "Invalid option. Please try one of the following..."
  puts "=> word words sentence sentences paragraph paragraphs body"
  puts "   You can also use the form:  3 words; 2 paragraphs; etc."
end
