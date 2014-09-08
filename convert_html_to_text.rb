#!/bin/env ruby
####################################################################
###
##  File: convert_html_to_text.rb
##  Desc: Convert *.htm and *.html files within a directory
##        into text files - strip all the HTML tags, etc.
#

require 'pathname'

cwd = Pathname.pwd

files = cwd.children.select do |c|
  c.file? and
  ( '.htm' == c.extname.downcase or '.html' == c.extname.downcase )
end

files.each do |f|
  fin   = f.to_s
  fout  = fin.dup
  case f.extname.downcase
    when '.htm' then
      fout[-3,3] = 'txt'
    when '.html' then
      fout[-4,4] = 'txt'
  end
  puts "#{fin} ..."
  system "html2text #{fin} > #{fout}"
end

