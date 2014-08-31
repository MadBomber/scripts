#!/bin/env ruby
####################################################################
###
##  File: summarize_file.rb
##  Desc: prints to stdout a summary of a file
#

require 'pathname'
require 'summary'
require 'systemu'
require 'pp'

if 0 == ARGV.length or ARGV[0].downcase.include? '-h'
  puts
  puts "Usage: summarize_file file_name [character_count]"
  puts
  puts "  where file_name is the name of a text file and"
  puts "        character_count is the size of the summary desired"
  puts
  exit
end

fp = Pathname.new ARGV[0]

fext = fp.extname.downcase

case fext

  when '.html', '.htm' then
    #puts "Convert #{fext} file to '.txt' ..."
    a,b,c = systemu "html2text #{fp.to_s}"

  when '.pdf' then
    #puts "Convert #{fext} file to '.txt' ..."
    a,b,c = systemu "pdf2txt #{fp.to_s}"

  when '.txt' then
    b = fp.read
    
  else
    puts
    puts "ERROR: File type '#{fext}' not supported.  Must be of type 'txt, pdf, html or htm'"
    puts
    exit -1

end


char_count = ARGV[1] || 1000
char_count = char_count.to_i




puts b.summary char_count, " "



