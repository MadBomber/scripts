#!/usr/bin/env ruby -W0
###################################################
###
##  File: docx_extract_bodytext.rb
##  Desc: Displays the "BodyText" styled paragraphs of *.docx files
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors

require 'pathname'       # STDLIB

require 'docx'           # a ruby library/gem for interacting with .docx files




if ARGV.empty? or ARGV.first == "-h" or ARGV.first == "--help"
  puts
  puts "Usage: docx_draft_style.rb [options] MS_WORD_DOCX++"
  puts
  puts "  Where:"
  puts "    MS_WORD_DOCX++    is one or more Microsoft Word DOCX filenames"
  puts
  puts "    options are:"
  puts
  puts "      -h or --help    This usage message is produced"
  puts
  exit
end






# SMELL: This returns a string in which the spaces have been squeezed out
# TODO: Move to the lib/*.rb file

def paragraph_style(para)

  begin
    style_element = para.node.children.children.first.attributes.first.last
    #ap style_element
    style_element.value.to_s
  rescue Exception => e
    #puts "ERROR: #{e}"
    #ap para.node
    "Normal"
  end

end # of def paragraph_style(para)




######################################################################
## Main Loop around the ARGV which should contain only file names

out_file  = STDOUT

ARGV.each do |param|

  given_document = Pathname.new(param)

  unless '.docx' == given_document.extname.downcase
    STDERR.puts
    STDERR.puts "WARNING: Not a *.docx file -- skipping."
    STDERR.puts "   File: #{given_document}"
    STDERR.puts
    next
  end

  d = Docx::Document.open(given_document.to_s)

  d.paragraphs.each do |para|
    style     = paragraph_style(para)
    puts "\n" + para.text if 'BodyText' == style
  end

  puts

end # end of ARGV.each do |param|
