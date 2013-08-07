#!/usr/bin/env ruby
###########################################################
###
##  File: uninstall_all_gems.rb
##  Desc: Acutally its an uninstall action
#

`gem up --system`

gem_list = `gem list`.split("\n")

gem_list.each do |gem|
  puts gem_name = gem.split.first
  `gem uninstall -a -I -x #{gem_name}`
end
