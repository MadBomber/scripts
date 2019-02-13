#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: camels2snakes2camels.rb
##  Desc: Converts CamelCaseStrings to snake_case_strings and
#         snake_case_strings to CamelCaseStrings
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'mods/string_mods'  # from lib/ruby

if ARGV.empty?
  puts <<~USAGE

    camels2snakes2camels.rb [CamelCaseString|snake_case_string]+

    Cpnverts CamelCased strings to snake_case strings.
    Cpnverts snake_case strings to CamelCased strings.

    The original case of the string is determined by whether or
    not it contains the underscore character.

  USAGE
  exit(0)
end

puts
ARGV.each do |a_string|
  transform = a_string.include?('_') ? :camelcase : :snakecase
  puts a_string.send transform
end
puts

