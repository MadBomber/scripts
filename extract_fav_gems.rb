#!/bin/env ruby
###############################################
## extract_fav_gems.rb
## An html file obtained from twitter.com is passed
## on the command line.  The file is the favorite tweets
## of a specific user.  Tweets from RubyGems are reviewed
## abd the gem name extracted.  If the gem is not currently
## installed it will be nominated for installation.  Gems
## are not installed automatically.  The gem install command
## line containing the nominated gems is printed to stdout
## so that the user can copy/paste as a command if desired.

usage_msg = <<EOS

Extract favorite tweets of nominated Ruby gems worth investigation

Usage: #{$0} <filename>

  where <filename> is the complete path to an HTML file obtained
                   from twitter.com of the list of favorite tweets.

EOS

if ARGV.empty?
  puts usage_msg
  exit
end


require 'pathname'
require 'systemu'

signal_line = '@rubygems' # 'rubygems</a>'

jruby_indicators  = %w[jruby java]

favorites_file = Pathname.new ARGV[0]

unless favorites_file.exist?
  puts "\nERROR: #{favorites_file} does not exist"
  puts usage_msg
  exit(-1)
end


fav_gems    = Array.new
jruby_gems  = Array.new

extract_next_line = 0

puts "Extracting RubyGem Names from Webpage"

a_line_cnt = 1

favorites_file.readlines.each do |a_line|

#puts "#{a_line_cnt} #{a_line}"
a_line_cnt += 1

  extract_next_line -= 1
  if 0 == extract_next_line
    gem_name = a_line.split()[0]
#puts "#{gem_name} ..."
    
    # SMELL: This does not get the full description.
    jruby_gem = false
    jruby_indicators.each do |i|
      jruby_gem = true if a_line.downcase.include?(i)
    end
    
    if jruby_gem
      jruby_gems  << gem_name unless fav_gems.include? gem_name
    else
      fav_gems    << gem_name unless fav_gems.include? gem_name
    end
    
  elsif a_line.strip == signal_line
    # MAGIC: 3 is how many lines to skip after finding the signal line before
    #        the line that contains the gem name is found.
#puts "MARKER"
    extract_next_line = 1 # 3
  end
end

puts "Obtaining Installed Gem Names"

a,gem_list,c = systemu 'gem list'

installed_gems = Array.new

gem_list.split("\n").each do |a_line|
  installed_gems << a_line.split[0]
end

gem_install_command = "gem install"

fav_gems.each do |gem|
  gem_install_command += " " + gem unless installed_gems.include? gem
end

# MAGIC: -2 accounts for the constant 'gem' and 'install' tokens
puts "Found #{gem_install_command.split.length - 2} new gems worth investigating."
puts
puts gem_install_command
puts

#############################################
## JRuby gems

gem_install_command = "gem install"

jruby_gems.each do |gem|
  gem_install_command += " " + gem
end

# MAGIC: -2 accounts for the constant 'gem' and 'install' tokens
puts "Found #{gem_install_command.split.length - 2} new gems for JRuby worth investigating."
puts
puts gem_install_command
puts

puts "Done."


