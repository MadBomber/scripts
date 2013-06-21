#!/usr/bin/env ruby
###################################################
###
##  File: docx_draft_style.rb
##  Desc: Displays the paragraph style and contents of an MS Word *.docx file
#

#require 'awesome_print'

require 'pathname'

require 'docx'
require 'word_wrapper'

if ARGV.empty? or ARGV.first == "-h" or ARGV.first == "--help"
  puts
  puts "Usage: docx_draft_style.rb MS_WORD_DOCX++"
  puts
  puts "  Where:"
  puts "    MS_WORD_DOCX++    is one or more Microsoft Word DOCX filenames"
  puts
  exit
end

def paragraph_style(para)
  begin
    para.node.children.children.first.attributes.first.last.value
  rescue Exception => e
    #puts "ERROR: #{e}"
    #ap para.node
    "Normal"
  end
end

def paragraph_contents(para)
  para.to_s
end

style_width   = 20

ARGV.each do |param|

  given_document = Pathname.new(param)

  unless '.docx' == given_document.extname.downcase
    puts
    puts "WARNING: Not a *.docx file."
    puts "   File: #{given_document}"
    puts
    next
  end

  d = Docx::Document.open(given_document.to_s)

  puts
  puts "MS Word (docx) File Name:  #{given_document}"
  puts "Draft Layout Generated on: #{Time.now}"
  puts "-"*(30+given_document.to_s.length)
  puts

  d.paragraphs.each do |para|
    style     = paragraph_style(para)
    contents  = paragraph_contents(para)

    print style+" "*(style_width > style.size ? style_width-style.size : 3)
    lines = WordWrapper::MinimumRaggedness.new(style_width*3, contents).wrap.split("\n")
    x=1
    lines.each do |a_line|
      puts a_line
      x-=1
      print " "*style_width unless x>0
    end
    puts

  end


end # end of ARGV.each do |param|
