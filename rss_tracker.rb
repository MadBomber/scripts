#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: rss_tracker.rb
##  Desc: Track and alert on new items from an RSS feed
##        Makes use of a rethinkdb cluster
##        SMELL: looks like its tightly coupled to a specific RSS feed
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#


require 'awesome_print'
require 'date'
require 'hashie'
require 'htmlentities'
require 'open-uri'

require 'rethinkdb'
include RethinkDB::Shortcuts

require 'simple-rss'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.2'

HELP = <<EOHELP
Important:

  The "cleanup" option is a one-off used to reformat
  database entries into the new keys used by the Story
  class.

EOHELP

cli_helper("__file_description__") do |o|

  o.bool    '-a', '--announce', 'Say the title of the article', default: false
  o.bool    '-c', '--cleanup',  'Cleanup the database',         default: false
  o.bool    '-s', '--save',     'Save to a database',           default: false
  o.string  '-u', '--url',      'URL for the RSS feed',         default: ENV['INFOWARS_RSS']

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

abort_if_errors





######################################################
# Local classes/methods

# An individual story from an RSS feed
class Story < Hashie::Dash
  include Hashie::Extensions::Dash::PropertyTranslation
  include Hashie::Extensions::Dash::Coercion
  include Hashie::Extensions::IgnoreUndeclared

  property :id,       from: 'id'
  property :title,    from: 'title',    required: true, coerce: ->(value){Html.decode(value)}
  property :link,     from: 'link',     required: true
  property :category, from: 'category',   default: 'Other News', coerce: ->(value){Html.decode(value)}

  property :author,   from: 'author',     required: true
  property :author,   from: :dc_creator,  required: true
  property :author,   from: 'dc_creator',  required: true

  property :description,  from: 'description',  required: true, coerce: ->(value){Html.decode(value)}

  property :published_on, from: 'published_on', required: true
  property :published_on, from: :pubDate,       required: true
  property :published_on, from: 'pubDate',       required: true

  # Use the system's text to speach capability
  def announce
    `say '#{text}'`
  end # def announce(an_item)


  def to_s
    a_string = <<~EOS
      Date: #{published_on}
      #{category}: #{title}
      #{description}
      #{link}
    EOS

    return a_string
  end

  ######################################################
  private
  def text
    "#{category}: #{title}; #{description}"
  end
end # class Story < Hashie::Dash


# SMELL: different feeds have different field names
class RssFeed
  def initialize(
      link:   ENV['INFOWARS_RSS'],
      rc:     nil,
      host:   'localhost',
      db:     'infowars',
      table:  'rss_feed'
    )

    @rss  = SimpleRSS.parse open(link)
    @rc   = rc || Pathname.new(ENV['HOME']) +
                  ".#{__FILE__.split('/').last.gsub('.rb','rc')}"

    begin
      @conn = r.connect(
                host:   host,
                port:   28015,        # default
                db:     db,
                table:  table,
              )
    rescue Errno::ECONNREFUSED => e
      STDERR.puts e
      STDERR.puts "rethinkdb may not be running on host: #{host}"
      exit(-1)
    end

    @db     = @conn.use(db)
    @table  = @db.table(table)

    cleanup if cleanup?
    get_last_pub_date # from the RC file
  end # def initialize(....


  # process each story in the RSS feed
  def process
    # Typical RSS feed starts with the latest story first
    stories = @rss
                .items.reverse
                .map{|item| Story.new(item)}
                .select{|story| story.published_on > @last_pub_date}

    stories.each do |story|
      puts "\n" + story.to_s  if verbose?
      story.announce          if announce?
      save story              if save?

      set_last_pub_date story.published_on
    end # stories.each do |story|

    set_last_pub_date stories.last.published_on unless stories.empty?
  end # def process


  ########################################################
  private
  # Save an RSS item into the database
  def save(story)
    @table.insert(story.to_h).run(@conn) unless duplicate?(story)
  end


  # Get the last publication date from the RC file
  def get_last_pub_date
    if @rc.exist?
      @last_pub_date = Time.parse @rc.read
    else
      @last_pub_date = Time.parse "1953-06-03 17:42:16 +0000"
      set_last_pub_date(@last_pub_date)
    end
  end


  # Save the last publication date into the RC file
  def set_last_pub_date(a_time)
    rc_file = File.open(@rc, 'w')
    rc_file.puts a_time.to_s
    rc_file.close
  end


  # Check the database to see if this story is a duplicate
  def duplicate?(story)
    # TODO: Assume that story.link is unique
    #       See if the link is already in the database
    #       if so, return true, otherwise false

    result = @table.get_all(story.link, index: 'link').count().run(@conn)
    puts "DUPLICATE" if result > 0

    return result > 0
  end # def duplicate?(story)


  # Before there was class there was raw dumping of RSS items
  # into the database.  This method reads all documents in the
  # database and replaces them with the current proper format.
  def cleanup
    tot_count = 0
    bad_count = 0
    @table.has_fields('pubDate').run(@conn).each do |item|
      tot_count += 1
      unless item.has_key? 'pubDate'
        print 'o'
        next
      end
      bad_count += 1
      print '.'
      begin
        story = Story.new(item)
      rescue => e
        STDERR.puts "\n\n" + e.to_s
        debug_me{[ :item ]}
      end
      @table.replace(story.to_h).run(@conn)
    end
    print "\n\n"
    debug_me{[ :tot_count, :bad_count ]}
  end # def cleanup
end # class RssFeed




######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

=begin
# A raw RSS item looks like this:
{
          :title => "Mysterious Wolf-like Creature Shot in Montana",
           :link => "https://www.infowars.com/mysterious-wolf-like-creature-shot-in-montana/",
    :description => "What is it?",
        :pubDate => 2018-05-25 13:12:21 +0000,
       :category => "Featured Stories",
     :dc_creator => "Kit Daniels"
}
=end

Html = HTMLEntities.new

the_feed = RssFeed.new
the_feed.process
