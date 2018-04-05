#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: shc.rb
##  Desc: Section Header Comment
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'pathname'
me = Pathname.new(__FILE__).basename


unless ARGV.empty?
  if %w[-h --help].include? ARGV.shift
    puts <<~USAGE

      Section Header Comment generator

      Usage: #{me} [filename]

      Examples:

        echo "some text" | #{me}
        #{me} < some_file.*     # only "text" files no binary
        #{me} some_file.*       # only "text" files no binary
        #{me}                   # enter text at prompt; control-d when done
        #{me} -h
        #{me} --help

    USAGE
    exit
  end
end

stuff = ARGF.read

lines = stuff.gsub("\t",'  ').split("\n")

leader      = '##  '
max_length  = lines.map{|s|s.length}.max + 2*leader.length

puts
puts
puts '#' * max_length
puts '#'+leader
print leader
puts lines.join("\n#{leader}")
puts '#'
puts
