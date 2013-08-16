#!/usr/bin/env ruby
########################################################
###
##  File: mbox_finder.rb 
##  Desc: Finds mbox files and prints out subject and date lines
#
# TOdO: Consider passing individual *.mbox files as arguments
#       in addition to the ability to pass a directory
#

require 'pathname'
#require 'awesome_print'

pgm_name = Pathname.new(__FILE__).basename

usage = <<EOS

Find interesting eMail messages in old *.mbox files

Usage:  #{pgm_name} top_level_directory key_word(s)

  Where:

    top_level_directory     The directory to start the search for *.mbox files
                            All sub-directories are also searched.

    key_word(s)             One or more key words (or phrases) that would
                            make an eMail interesting.  Searches are done
                            case insensitive for ANY of the interesting words.

Examples:

  #{pgm_name} . backpack "pressure cooker" Boston

EOS


if ARGV.empty?  or  ARGV.include?("-h")  or  ARGV.include?("--help")
  puts usage
  exit
end

top_level_directory = Pathname.new(ARGV.shift)

unless top_level_directory.exist?  and  top_level_directory.directory?
  puts
  puts "ERROR:  Invalid top_level_directory"
  puts "        #{top_level_directory}"
  puts usage
  exit
end

if ARGV.empty?
  puts
  puts "ERROR: no key_words were specified"
  puts usage
  exit
end

$key_words = ARGV.map { |a_word| a_word.downcase }

puts
puts "Starting Top-level Directory: #{top_level_directory.realpath}"
puts
puts "Reviewing *.mbox files for messages that contain the following strings:"
puts ARGV.join(', ')
puts

# TODO: Keep track of which $key_words caused a hit on the eMail
def is_interesting?(a_line)
  a_downcased_line  = a_line
  is_interesting    = false
  $key_words.each do |a_word|
    is_interesting  ||= a_downcased_line.include?(a_word)
    break if is_interesting
  end
  return is_interesting
end


def print_subject_date(a_filepath)

  puts
  puts "="*55
  puts a_filepath.to_s

  a_subject           = ''
  a_date              = ''
  line_number         = 0
  msg_starts          = 0
  interesting_message = false
  message_content     = Array.new

  begin
    all_lines = a_filepath.read.split("\r")
  rescue
    all_lines = ["From: Dewayne's scanner", "Subject: Error in Dewayne's scanner", "Date: Now"]
  end

  all_lines.each do |a_line|

    line_number += 1
        
    message_content << a_line

    a_subject = a_line    if a_line.start_with?('Subject')
    a_date    = a_line    if a_line.start_with?('Date')
    
    interesting_message = is_interesting?(a_line) unless interesting_message

    if a_line.start_with?('From ')
      if interesting_message
        puts
        puts "\t"+("-"*45)
        puts("\t#{msg_starts}  " + a_subject + "\t" + a_date)
        # TODO: print which $key_words caused the hit on this message
        puts "\t\t#{message_content.join("\n\t\t")}"
      end
      msg_starts          = line_number
      interesting_message = false
      message_content     = Array.new
    end

  end

  if interesting_message
    puts("\t#{msg_starts}  " + a_subject + "\t" + a_date)
    # TODO: print which $key_words caused the hit on this message
    puts "\t\t#{message_content.join("\n\t\t")}"
  end

end # def print_subject_date(a_filepath)


def scan_directory(a_directory)

  a_directory.children.each do |a_child|
    scan_directory(a_child) if a_child.directory?
    print_subject_date(a_child) if '.mbox' == a_child.extname
  end

end # def scan_directory(a_directory)

scan_directory(top_level_directory)

