#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: rss_tracker.rb
##  Desc: Track and alert on new items from an RSS feed
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'simple-rss'
require 'open-uri'
require 'htmlentities'
require 'date'

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

  o.bool    '-a', '--announce', 'Say the title of the article', default: false
  o.string  '-u', '--url',      'URL for the RSS feed',         default: ENV['INFOWARS_RSS']

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

abort_if_errors

Html = HTMLEntities.new

home    = Pathname.new ENV['HOME']
configatron.rc_path = home + ".#{my_name.to_s.gsub('.rb','')}rc"

######################################################
# Local methods

def announce(an_item)
  text = Html.decode("#{an_item.category}: #{an_item.title}; #{an_item.description}")
  system("say '#{text}'") if announce?
  show_ref(an_item) if verbose?
end

def show_ref(an_item)
  puts
  puts Html.decode(an_item.title)
  puts an_item.link
end

def last_pub_date
  Time.parse configatron.rc_path.read
end

def set_last_pub_date(a_time)
  rc_file = File.open(configatron.rc_path, 'w')
  rc_file.puts a_time.to_s
  rc_file.close
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

unless configatron.rc_path.exist?
  set_last_pub_date("1953-06-03 17:42:16 +0000")
end


print "Retrieving latest articles ... " if verbose?

rss = SimpleRSS.parse open(ENV['INFOWARS_RSS'])

puts rss.channel.title + ' loaded.' if verbose?

=begin
{
          :title => "Mysterious Wolf-like Creature Shot in Montana",
           :link => "https://www.infowars.com/mysterious-wolf-like-creature-shot-in-montana/",
    :description => "What is it?",
        :pubDate => 2018-05-25 13:12:21 +0000,
       :category => "Featured Stories",
     :dc_creator => "Kit Daniels"
}
=end
rss.items.reverse.each do |item|
  next if item[:pubDate] < last_pub_date

  announce(item)

  set_last_pub_date item[:pubDate]
end # rss.channel.title


