#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: aip.rb
##  Desc: Use generative AI with saved prompts
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
##  brew install mods the-silver-searcher
#     mods is the AI client
#     the-silver-searcher (aka ag) is the content searcher

require 'pathname'

EDITOR            = ENV['EDITOR']
HOME              = Pathname.new( ENV['HOME'] )
PROMPT_DIR        = HOME + ".prompts"
PROMPT_EXTNAME    = ".txt"
DEFAULTS_EXTNAME  = ".json"
AI_COMMAND        = "mods --no-limit -f "
SEARCH_COMMAND    = "ag -l"
KEYWORD_REGEX     = /(\[[A-Z _|]+\])/

AVAILABLE_PROMPTS = PROMPT_DIR
                      .children
                      .select{|c| PROMPT_EXTNAME == c.extname}
                      .map{|c| c.basename.to_s.split('.')[0]}



AVAILABLE_PROMPTS_HELP  = AVAILABLE_PROMPTS
                            .map{|c| "  * " + c}
                            .join("\n")

require 'amazing_print'
require 'json'
require 'tty-prompt'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Available Prompts:

#{ AVAILABLE_PROMPTS_HELP }

EOHELP

cli_helper("Use generative AI with saved prompts") do |o|

  o.string  '-p', '--prompt', 'The prompt name',      default: ""
  o.bool    '-e', '--edit',   'Edit the prompt text', default: false
  o.path    '-o', '--output', 'The output file',      default: Pathname.pwd + "temp.md"
  o.string  '-s', '--search', 'Search for prompt',    default: ""
end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end

def choose_prompt(choices) = TTY::Prompt.new.select('Use which prompt:', choices)

configatron.input_files = get_pathnames_from( configatron.arguments, %w[.rb .txt .md])

if configatron.prompt.empty? && configatron.search.empty?
  choices             = AVAILABLE_PROMPTS.map{|p| {name: p, value: p}}
  configatron.prompt  = choose_prompt(choices)
end

unless configatron.search.empty?
  paths               = `#{SEARCH_COMMAND} "#{configatron.search}" #{PROMPT_DIR}/*#{PROMPT_EXTNAME}`.split("\n")
  choices             = paths.map{|v| v.split('/').last.gsub(PROMPT_EXTNAME,'')}
                          .map{|p| {name: p, value: p}}
  configatron.prompt  = choose_prompt(choices)
end

configatron.prompt_path   = PROMPT_DIR + (configatron.prompt + PROMPT_EXTNAME)
configatron.defaults_path = PROMPT_DIR + (configatron.prompt + DEFAULTS_EXTNAME)

if  !configatron.prompt_path.exist? &&
    !configatron.edit
  choices             = AVAILABLE_PROMPTS.select{|p| p.start_with?(configatron.prompt)}
                          .map{|p| {name: p, value: p}}
  if choices.empty? && !configatron.edit
    error "This prompt does not exist: #{configatron.prompt}\n"
  else
    configatron.prompt  = choose_prompt(choices)
  end
end

configatron.prompt_path   = PROMPT_DIR + (configatron.prompt + PROMPT_EXTNAME)
configatron.defaults_path = PROMPT_DIR + (configatron.prompt + DEFAULTS_EXTNAME)


abort_if_errors

if configatron.edit
  configatron.prompt_path.write "# #{configatron.prompt_path}\n# DESC: " unless configatron.prompt_path.exist?
  system "#{EDITOR} #{configatron.prompt_path}"
  exit(0)
end


######################################################
# Local methods

def extract_raw_prompt
  array_of_strings = ignore_after_end
  print_header_comment(array_of_strings)

  array_of_strings.reject do |a_line|
                    a_line.chomp.strip.start_with?('#')
                  end
                  .join("\n")
end


def ignore_after_end
  array_of_strings  = configatron.prompt_path.readlines
                        .map{|a_line| a_line.chomp.strip}

  x = array_of_strings.index("__END__")

  unless x.nil?
    array_of_strings = array_of_strings[..x-1]
  end

  array_of_strings
end


def print_header_comment(array_of_strings)
  print "\n\n" if verbose?

  x = 0

  while array_of_strings[x].start_with?('#') do
    puts array_of_strings[x]
    x += 1
  end

  print "\n\n" if x>0 && verbose?
end


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
  replacements = load_default_replacements

  keywords.each do |kw|
    default = replacements[kw]
    print "#{kw} (#{default}) ? "
    a_string          = STDIN.gets().chomp.strip
    replacements[kw]  = a_string unless a_string.empty?
  end

  save_default_replacements(replacements)

  replacements
end


def load_default_replacements
  if configatron.defaults_path.exist?
    JSON.parse(configatron.defaults_path.read)
  else
    {}
  end
end


def save_default_replacements(a_hash)
  return if a_hash.empty?
  defaults = a_hash.to_json
  configatron.defaults_path.write defaults
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

ap configatron.to_h  if debug?


prompt_raw  = extract_raw_prompt

puts
print "PROMPT: "
puts prompt_raw
puts


keywords      = extract_keywords_from prompt_raw
replacements  = replacements_for keywords

prompt = replace_keywords_with replacements, prompt_raw
ptompt = %Q{prompt}

command = AI_COMMAND + '"' + prompt + '"'

configatron.input_files.each do |input_file|
  command += " < #{input_file}"
end


print "\n\n" if verbose? && !keywords.empty?

if verbose?
  puts "="*42
  puts command
  puts "="*42
  print "\n\n"
end

configatron.output.write `#{command}`
