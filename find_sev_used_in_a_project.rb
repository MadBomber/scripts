#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: find_sev_used_in_a_project.rb
##  Desc: Search a directory of source code (ruby) extracting a list of all
##        system environment variables used.
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("__file_description__") do |o|

  o.path    '-p', '--project_root',   'Project root directory'

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')


abort_if_errors


######################################################
# Local methods

def normalize_sev(a_string)


  a_string.strip!
  x = a_string.size - 1

# debug_me{[ :a_string, :x ]}

  return a_string if x<=0

  if [ "'", '"' ].include? a_string[x]
    a_string = a_string[0, x]
  end

  if [ "'", '"' ].include? a_string[0]
    a_string = a_string[1, a_string.size]
  end

  [ "&quot;", "&#39;" ].each do |html_junk|
    a_string.gsub!(html_junk, '')
  end

  return a_string

end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

results = `fgrep -n -R "ENV[" #{configatron.project_root}`.split("\n")

ap results if debug?

sev_hash = Hash.new

results.each do |a_line|
  parts                 = a_line.split(':')
  a_filename            = parts.shift + ":" + parts.shift
  sev_hash[a_filename]  = [] unless sev_hash.include? a_filename
  rest_of_line          = parts.join(':')
  parts                 = rest_of_line.split('ENV[')

  parts.each_slice(2) do |sev_string|
    # debug_me {['sev_string.class']}
    sev_name = normalize_sev(sev_string.last.split(']').shift)
    sev_hash[a_filename] << sev_name unless sev_hash[a_filename].include? sev_name
  end
end

sev_hash_inverted = Hash.new

sev_hash.each_pair do |k, v|
  v.each do |sev|
    sev_hash_inverted[sev] = [] unless sev_hash_inverted.include? sev
    sev_hash_inverted[sev] << k unless sev_hash_inverted[sev].include? k
  end
end

puts "\nThe following system environment variables are used in the project:"
puts configatron.project_root

sev_hash_inverted.each_pair do |sev, file_list|
  puts "\n#{sev}"
  file_list.each {|a_path| puts "\t#{a_path}" }
end



