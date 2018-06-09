#!/usr/bin/env ruby
###################################################
###
##  File: wcml_draft_layout.rb
##  Desc: Displays the story title and contents of an InCopy *.wcml file
##
##  Note: The variable 'style' is a hold-over from when I was dealing with
##        MS Word files.  The way I was treating paragraph style names back then
##        is how I am treating story titles now within InCopy documents.  I
##        left the variable the same name to make it a little easier when I
##        decide to combine the old MS Word version of this program with this one.
#

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'pathname'  # STDLIB

require 'nokogiri'  # Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser
require 'word_wrapper'  # Pure ruby word wrapping

require('wcml_helpers')
include WcmlHelpers


me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:            false,
  show_hidden: 		    false,
  style_width:        20,
  line_width:         80,
  html_desired:       false,
  show_char_styles:   true,
  debug: 			  false
}

def debug?
  $options[:debug]
end

def style_width
  $options[:style_width]
end

def line_width
  $options[:line_width]
end

def verbose?
  $options[:verbose]
end

def html_desired?
  $options[:html_desired]
end

def show_char_styles?
  $options[:show_char_styles]
end

def show_hidden?
  $options[:show_hidden]
end


usage = <<EOS

Usage: #{my_name} [options] INCOPY_WCML++

  Where:

    INCOPY_WCML++      is one or more Adobe InCopy WCML filenames

    options are:

       -h or --help    This usage message is produced
       --html          Produces an HTML file for each input file
       --no-char       Do not show character styles within content
       --hidden        prints __SPACES__ and __TAB__ and __RETURN__
       				   also identifies __SPACES-AT-BEGINNING__ and
       				                   __SPACES-AT-END__

NOTE:

  Do not know how to handle character styles.

EOS


$errors = []

if  ARGV.empty?             ||
    ARGV.include?('-h')     ||
    ARGV.include?('--help')
  puts usage
  exit
end

%w[ -v --verbose ].each do |param|
  if ARGV.include? param
    $options[:verbose] = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

%w[ -d --debug ].each do |param|
  if ARGV.include? param
    $options[:debug] 			= true
    ARGV[ ARGV.index(param) ] 	= nil
  end
end

if ARGV.include?('--html')
  $options[:html_desired] 		= true
  ARGV[ ARGV.index('--html') ] 	= nil
end

if ARGV.include?('--no-char')
  $options[:show_char_styles] 		= false
  ARGV[ ARGV.index('--no-char') ] 	= nil
end

if ARGV.include?('--hidden')
  $options[:show_hidden] 		 = true
  ARGV[ ARGV.index('--hidden') ] = nil
end


ARGV.compact!


class String
  def wrap_with_style(style)
    if html_desired?
      "&lt;#{style}&gt;" + self + "&lt;/#{style}&gt;"
    else
  	  "<#{style}>" + self + "</#{style}>"
  	end
  end # def wrap_with_style
end # class String



def story_contents(a_story)

  contents_string = get_text(a_story)

  if show_hidden?
  	contents_string.gsub!(/(  )+/, ' __SPACES__ ')
  	if show_char_styles?
  	  if html_desired?
    	contents_string.gsub!('&lt;tab&gt;', ' __TAB__ ')
    	contents_string.gsub!('&lt;/tab&gt;', '')
  	  else
    	contents_string.gsub!('<tab>', ' __TAB__ ')
    	contents_string.gsub!('</tab>', '')
  	  end
  	else
  	  contents_string.gsub!("\t", ' __TAB__ ')
	end
	contents_string = '__SPACES-AT-BEGINNING__' + contents_string if contents_string.start_with?(' ')
	contents_string += '__SPACES-AT-END__' if contents_string.end_with?(' ')
  	contents_string += '__RETURN__'
  end

  return contents_string

end # def story_contents(a_story)


######################################################################
## Main Loop around the ARGV which should contain only file names


pp $options if verbose?  ||  debug?


out_file  = STDOUT

ARGV.each do |param|

  given_document = Pathname.new(param)

  unless '.wcml' == given_document.extname.downcase
    STDERR.puts
    STDERR.puts "WARNING: Not a *.wcml file -- skipping."
    STDERR.puts "   File: #{given_document}"
    STDERR.puts
    next
  end

  d = open_wcml(given_document)


  if html_desired?

    html_pathname = given_document.dirname + ( given_document.basename.to_s + ".html" )
    out_file      = html_pathname.open("w")

    out_file.puts "<html><head><title>#{given_document}</title></head>"
    out_file.puts "<body>"
    out_file.puts '<a href="javascript:window.print()">Send to Printer</a><br /><br />'
    out_file.puts "<pre>"
  end

  out_file.puts
  out_file.puts "InCopy (wcml) File Name:  #{given_document}"
  out_file.puts "Draft Layout Generated on: #{Time.now}"
  out_file.puts "-"*(30+given_document.to_s.length)
  out_file.puts

  get_stories(d).each do |a_story|

    style     = get_story_title(a_story)

    contents  = [story_contents(a_story)]
    contents  = story_contents(a_story).split("\n") if 'Body Text' == style

    contents.each do |a_para|

      out_file.print style+" "*(style_width > style.size ? style_width-style.size : 3)

      lines = WordWrapper::MinimumRaggedness.new(line_width, a_para).wrap.split("\n")
      x = 1

      lines.each do |a_line|
        out_file.puts a_line
        x -= 1
        out_file.print " "*style_width unless x > 0
      end

      out_file.puts

    end

  end

  out_file.puts

  if html_desired?
    out_file.puts "</pre>"
    out_file.puts "</body>"
    out_file.puts "</html>"
    #out_file.close
  end

end # ARGV.each do |param|
