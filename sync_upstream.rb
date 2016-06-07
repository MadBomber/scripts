#!/usr/bin/env ruby
###################################################
###
##  File: sync_upstream.rb
##  Desc: Update all forked projects with their upstream master
##
##  NOTE: this has been replaced by gitup
##        brew install gitup
#

puts <<-EOS

This program has been replaced by gitup which is available via:
  brew install gitup

Invoking gitup ...

EOS

system "gitup #{ARGV.join(' ')}"

