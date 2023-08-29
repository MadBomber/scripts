#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: aip.rb
##  Desc: Use generative AI with saved prompts
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'pathname'

HOME            = Pathname.new( ENV['HOME'] )
PROMPT_DIR      = HOME + ".prompts"
PROMPT_EXTNAME  = ".txt"
AI_COMMAND      = "mods --no-limit --format"
KEYWORD_REGEX   = /(\[[A-Z _|]+\])/

require 'amazing_print'



require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("Use generative AI with saved prompts") do |o|

  o.string  '-p', '--prompt', 'The prompt name'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, %w[.txt .md])

if configatron.input_files.empty?
  error 'No text files were provided'
end

abort_if_errors


######################################################
# Local methods

# Returns an Array of keywords or phrases that look like:
#   [KEYWORD]
#   [KEYWORD|KEYWORD]
#   [KEY PHRASE]
#   [KEY PHRASE | KEY PHRASE | KEY_WORD]
#
def extract_keywords_from(prompt_raw)
  prompt_raw.scan(KEYWORD_REGEX).flatten.uniq
end

# get the replacements for the keywords
def replacements_for(keywords)
  replacements = {}

  keywords.each do |kw|
    print "#{kw} ? "
    replacements[kw] = gets.chomp
  end

  replacements
end

# substitute the replacements for the keywords
def replace_keywords_with replacements, prompt_raw
  prompt = prompt_raw.dup

  replacements.each_pair do |keyword, replacement|
    prompt.gsub!(keyword, replacement)
  end

  prompt
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?



prompt_path = PROMPT_DIR + (configatron.prompt + PROMPT_EXTNAME)

prompt_raw  = prompt_path.readlines
                .map{|a_line| a_line.chomp.strip}
                .reject do |a_line|
                  a_line.chomp.strip.start_with?('#')
                end
                .join(" ")

keywords      = extract_keywords_from prompt_raw
replacements  = replacements_for keywords

prompt = replace_keywords_with replacements, prompt_raw
ptompt = %Q{prompt}

command = AI_COMMAND + "\"#{prompt}\""

configatron.input_files.each do |input_file|
  command += " < #{input_file}"
end

puts command

puts "="*42

puts `#{command}`
