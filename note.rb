#!/usr/bin/env ruby

notes_file = "#{ENV['HOME']}/_notes.txt"

File.open(notes_file, "a") do |f|
  f.print "--- #{Time.now}\n\t"
  f.print "#{ARGV.join(' ')}\n\n" unless ARGV.empty?  # .join(' ')
end

system "#{ENV['EDITOR']} #{notes_file} &" if ARGV.empty?  &&  !ENV['EDITOR'].nil?

