#!/usr/bin/env ruby

require 'clipboard'

notes_file = "#{ENV['HOME']}/_notes.txt"

File.open(notes_file, "a") do |f|
  f.print "\n--- #{Time.now}\n"
  f.print "\t#{ARGV.join(' ')}\n\n" unless ARGV.empty?  # .join(' ')
  f.print "\t" + Clipboard.paste.split("\n").join("\n\t")
  f.print "\n\t"*3
end

system "#{ENV['EDITOR']} #{notes_file} &" if ARGV.empty?  &&  !ENV['EDITOR'].nil?

