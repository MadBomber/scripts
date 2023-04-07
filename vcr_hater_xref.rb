#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: vcr_hater_xref.rb
##  Desc: xref vcr cassette to spec file abd viz-a-viz
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#   Use `ag use_cassette spec > temp.txt` from Rails.root
#   then manually edit the temp.txt file to get
#   rid of text that is not the cassette name
#

require 'hash_array' # from my lib/ruby directory
require 'pathname' 

DIR = Pathname.pwd

######################################################
# Local methods

def puts_xref(title, xref)
  file_path = DIR + (title.downcase.gsub(' ','_')+".txt")

  buffer =  "#{title}" + "\n"
  buffer += "="*title.length
  buffer += "\n"

  xref.keys.sort.each do |key|
    buffer += "\n" + key + "\n"
    buffer += "  "
    buffer += xref[key].sort.join("\n  ")
    buffer += "\n"
  end

  file_path.write buffer
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

in_path = Pathname.pwd + 'temp.txt'

# key is cassette, value is spec file
s2c_xref = HashArray.new
c2s_xref = HashArray.new

# establish scope
spec      = ""
cassette  = ""


in_path.readlines.each do |this_line|
  a_line = this_line.chomp 

  next if a_line.empty?

  if a_line.start_with? "spec"
    spec = a_line
  else
    cassette = a_line.split(':').last + ".yml"
    s2c_xref[spec]      << cassette unless s2c_xref[spec].include? cassette
    c2s_xref[cassette]  << spec     unless c2s_xref[cassette].include? spec
  end

end

puts_xref "Spec file to Cassette XREF", s2c_xref
puts_xref "Cassette to Spec file XREF", c2s_xref
