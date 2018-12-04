#!/usr/bin/env ruby
# clean_up_gems.rb

gems = `gem list`
          .split("\n")
          .select{|g| g.include?(', ')}
          .reject{|g| g.include?('default')}
          .reject{|g| g.include?('darwin')}
          .map{|g| [g.split().first, g.split().last.gsub(')','')]}

gems.each{|g| puts "gem unins #{g.first} -I -x -v #{g.last}"}

