#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: ppsql.rb
##  Desc: Pretty Print SQL files
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

INDENTER_STRING = '  '

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Consider using the utility 'pg_format' instead
  of this program.  You can get it using

    brew install pgformatter

EOHELP

cli_helper("Pretty Print SQL files") do |o|

  o.path    '-o', '--output',   'Output file'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check you stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, '.sql')

if configatron.input_files.empty?
  error 'No SQL files were provided for pretty printing'
end

abort_if_errors

STRING_CONSTANT_MARKER1 = '__STRING_CONSTANT_1__'
STRING_CONSTANT_MARKER2 = '__STRING_CONSTANT_2__'
TEMPLATE_MARKER = '__TEMPLAGE_MARKER__'

KEYWORDS_BEFORE = %w{
  --
  (
  )
  and
  case
  create
  delete
  drop
  else
  end
  from
  full
  group
  having
  inner
  insert
  intersect
  into
  left
  or
  order
  select
  set
  then
  truncate
  union
  update
  when
  where
  where
  with
}

KEYWORDS_AFTER = %w{
  (
  )
  ,
}

KEYWORDS_INDENT = %w{
  (
  with
  select
  from
  where
  order
  group
}

KEYWORDS_OUTDENT = %w{
  )
  select
  from
  where
  order
  group
}


######################################################
# Local methods

def pack_sql(an_sql_file)
  # SMELL: does not account for strings within quotes
  an_sql_file.read.gsub("\n",' ').gsub("\t",' ').gsub("\\",'').squeeze(" ").strip.downcase
end


def mark_string_constants(a_string)
  # TODO: put those string constants into a holding array
  a_string = replace_single_quoted_constant(a_string)
  a_string = replace_double_quoted_constant(a_string)
  return replace_template_markers(a_string)
end


def add_newlines(a_string)
  KEYWORDS_AFTER.each do |a_word|
    a_string.gsub!(" #{a_word}", " #{a_word}\n")
  end
  KEYWORDS_BEFORE.each do |a_word|
    a_string.gsub!(" #{a_word}", "\n#{a_word}")
  end
  return a_string.gsub("\n ","\n").squeeze("\n")
end


def replace_single_quoted_constant(a_string)
  q_start = a_string.index("'")
  return(a_string) if q_start.nil?
  q_end = a_string[q_start+1,999999].index("'")
  $string_constants1 << a_string[q_start, q_end+2]
  a_string[q_start, q_end+2] = STRING_CONSTANT_MARKER1
  replace_single_quoted_constant(a_string)
end


def replace_double_quoted_constant(a_string)
  q_start = a_string.index('"')
  return(a_string) if q_start.nil?
  q_end = a_string[q_start+1,999999].index('"')
  $string_constants2 << a_string[q_start, q_end+2]
  a_string[q_start, q_end+2] = STRING_CONSTANT_MARKER2
  replace_double_quoted_constant(a_string)
end


def replace_template_markers(a_string)
  q_start = a_string.index('${')
  return(a_string) if q_start.nil?
  q_end = a_string[q_start,999999].index('}')
  $template_constants << a_string[q_start, q_end+1]
  a_string[q_start, q_end+1] = TEMPLATE_MARKER
  replace_template_markers(a_string)
end


def isolate_punction(a_string)
  a_string.gsub('(',' ( ').gsub(')',' ) ').gsub(',', ' , ').squeeze(' ')
end


def insert_indentation(a_string)
  level = 0
  an_array = a_string.split("\n")
  an_array.each_index do |x|
    a_line = an_array[x]
    first_word = a_line.split.first

    # TODO: check to see if first word is also in the outdent keywords.
    if KEYWORDS_INDENT.include?(first_word)
      puts ">>>>>>>>>>>>>>>>>> INDENT #{first_word}"  if debug?
      level -= 1 if KEYWORDS_OUTDENT.include?(first_word)  &&  level > 0
      a_line = (INDENTER_STRING*level) + a_line
      level += 1
    elsif KEYWORDS_OUTDENT.include?(first_word)
      puts "OUTDENT <<<<<<<<<<<<<<<<<< #{first_word}"  if debug?
      level -= 1
      a_line = (INDENTER_STRING*level) + a_line
    else
      a_line = (INDENTER_STRING*level) + a_line
    end
    an_array[x] = a_line
  end
  return(an_array.join("\n"))
end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


configatron.input_files.each do |a_file|

  $string_constants1  = Array.new
  $string_constants2  = Array.new
  $template_constants = Array.new

  puts
  puts "="*45
  puts "== #{a_file}"
  puts

  raw_sql = pack_sql(a_file)

  puts raw_sql
  puts

  puts insert_indentation(
    add_newlines(
      isolate_punction(
        mark_string_constants(' '+raw_sql))))

  debug_me{[ '$string_constants1', '$string_constants2', '$template_constants' ]}


end




