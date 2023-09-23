#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: aip.rb
##  Desc: Use generative AI with saved parameterized prompts
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
##  brew install mods the-silver-searcher
#     mods is the AI CLI program
#     the-silver-searcher (aka ag) is the content searcher
#
# Summary:
#   The program is a Ruby script that utilizes the mods gpt-based CLI
#   tool to use generative AI with saved parameterized prompts. The script
#   allows the user to select a prompt from a list of available prompts,
#   edit the text of a prompt, list the available prompts, or search for a
#   prompt based on a keyword. The program also reads in input files and uses
#   the AI CLI program to generate an output based on the chosen prompt. The
#   output is then written to a file. The program also logs the prompt, the
#   generated output, and the timestamp of the generation.
#
#
# TODO: I think this script has readed the point where
#       it is ready to become a proper gem.
#

require 'pathname'
HOME = Pathname.new( ENV['HOME'] )

AI_CLI_PROGRAM  = "mods"
ai_default_opts = "--no-limit -f"
ai_options      = ai_default_opts.dup

extra_inx       = ARGV.index('--')

if extra_inx
  ai_options += " " + ARGV[extra_inx+1..].join(' ')
  ARGV.pop(ARGV.size - extra_inx)
end

AI_COMMAND        = "#{AI_CLI_PROGRAM} #{ai_options} "
EDITOR            = ENV['EDITOR']
PROMPT_DIR        = HOME + ".prompts"
PROMPT_LOG        = PROMPT_DIR + "_prompts.log"
PROMPT_EXTNAME    = ".txt"
DEFAULTS_EXTNAME  = ".json"
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
require 'readline'
require 'tty-prompt'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '1.0.0'

AI_CLI_PROGRAM_HELP = `#{AI_CLI_PROGRAM} --help`

HELP = <<EOHELP
AI CLI Program
==============

The AI cli program being used is: #{AI_CLI_PROGRAM}

The defaul options to #{AI_CLI_PROGRAM} are:
  "#{ai_default_opts}"

You can pass additional CLI options to #{AI_CLI_PROGRAM} like this:
  "#{my_name} my options -- options for #{AI_CLI_PROGRAM}"

#{AI_CLI_PROGRAM_HELP}

EOHELP

cli_helper("Use generative AI with saved parameterized prompts") do |o|

  o.string  '-p', '--prompt', 'The prompt name',      default: ""
  o.bool    '-e', '--edit',   'Edit the prompt text', default: false
  o.bool    '-l', '--list',   'List the prompts',     default: false
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

if configatron.list
  puts <<~LIST

    Available Prompts
    =================

    #{ AVAILABLE_PROMPTS_HELP }

  LIST
  exit(0)
end



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
    a_string          = Readline.readline('> ', true)
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


def log(prompt_path, prompt_raw, answer)
  f = File.open(PROMPT_LOG, "ab")

  f.write <<~EOS
    =======================================
    == #{Time.now}
    == #{prompt_path}

    PROMPT: #{prompt_raw}

    RESULT:
    #{answer}

  EOS
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if debug?


configatron.prompt_raw  = extract_raw_prompt

puts
print "PROMPT: "
puts configatron.prompt_raw
puts


keywords      = extract_keywords_from configatron.prompt_raw
replacements  = replacements_for keywords

prompt = replace_keywords_with replacements, configatron.prompt_raw
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

result = `#{command}`

configatron.output.write result

log configatron.prompt_path, prompt, result
