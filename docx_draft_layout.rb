#!/usr/bin/env ruby
###################################################
###
##  File: docx_draft_style.rb
##  Desc: Displays the paragraph style and contents of an MS Word *.docx file
#

require 'docx'
require 'word_wrapper'

if ARGV.empty? or ARGV.first == "-h" or ARGV.first == "--help"
  puts
  puts "Usage: docx_draft_style.rb MS_WORD_DOCX"
  puts
  puts "  Where:"
  puts "    MS_WORD_DOCX    is a Microsoft Word DOCX file"
  puts
  exit
end

def paragraph_style(para)
  para.node.children.children.first.attributes.first.last.value
end

def paragraph_contents(para)
  para.to_s
end

d = Docx::Document.open(ARGV.first)

style_width   = 20


puts
puts "File: #{ARGV.first}"
puts "-"*60
puts

d.paragraphs.each do |para|
  style     = paragraph_style(para)
  contents  = paragraph_contents(para)

  print style+" "*(style_width-style.size)
  lines = WordWrapper::MinimumRaggedness.new(style_width*3, contents).wrap.split("\n")
  x=1
  lines.each do |a_line|
    puts a_line
    x-=1
    print " "*style_width unless x>0
  end
  puts

end
