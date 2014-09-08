#!/bin/env ruby
###################################################
###
##  File: relink_home_dirs.rb
##  Desc: prints out commands that will rename the
##        existing folders in HOME and then create
##        symbolic links for those same folders to
##        their counterparts on the /media/James disk.
#

require 'pathname'

def doit
  h=Pathname.new ENV['HOME']
  system "cd #{h}"
  mj=Pathname.new '/media/James'
  h.children.each do |c|
    next unless c.directory?
    b=c.basename
    ln=mj+b
    if ln.exist?
      puts "mv #{b} old_#{b}"
      puts "ln -s #{ln}"
      puts
    end
  end
  nil
end

doit

