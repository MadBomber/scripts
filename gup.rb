#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: gup.rb
##  Desc: gem update | gemt
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

gup_filename = "~/temp/gup.txt"

system "gem up | tee #{gup_filename}"

log = `cat #{gup_filename}`

gems = log.split("\n").
            select {|g| g.start_with?('Updating') && g != 'Updating installed gems' }.
            map{|g| g.split(' ').last}

system "gemt #{gems.join(' ')}" unless gems.empty?




