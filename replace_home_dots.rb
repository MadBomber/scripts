#!/bin/env ruby
###################################################
###
##  File: replace_home_dots.rb
##  Desc: prints out commands that will rename the
##        existing dot files in HOME and then copy
##        same from the /media/James/dot_files folder.
#

require 'pathname'

def doit
  h   = Pathname.new ENV['HOME']
  mjd = Pathname.new '/media/James/dot_files'

  mjd.children.each do |c|
    b   = c.basename

    if (h+b).exist?
      puts "mv #{h+b} #{h+b}_old"
    end

    puts "cp #{c.directory? ? "-R" : "" } #{c} #{h}"
  end
  nil
end

doit

