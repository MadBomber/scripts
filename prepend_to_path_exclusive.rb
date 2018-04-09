#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: prepend_to_path_exclusive.rb
##  Desc: Reorder the $PATH variable
##        Puts the paths from ARGV in front of all other in $PATH
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

old_PATH = ENV['PATH'].split(':')

ARGV.each do |a_param|
  if old_PATH.include? a_param
    its_index = old_PATH.index a_param
    old_PATH[its_index] = nil unless its_index.nil?
  end
end

new_PATH = ARGV + old_PATH.compact

puts new_PATH.join(':')


