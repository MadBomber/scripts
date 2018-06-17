#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: rss_tracker.rb
##  Desc: Track and alert on new items from an RSS feed
##        Makes use of a rethinkdb cluster
##
##  System Environment Variables:
##    RSS_FEEDS: semi-colon seperated list of URLS
##
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors
require 'date'           # STDLIB
require 'json'           # STDLIB
require 'hashie'         # Your friendly neighborhood hash library.
require 'htmlentities'   # Encode/decode HTML entities
require 'open-uri'       # STDLIB

require 'rethinkdb'      # This package provides the Ruby driver library for the RethinkDB database server.
include RethinkDB::Shortcuts

require 'rssable'        # Access the RSS channel of any webiste without worrying about the engine

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.3'

HELP = <<EOHELP
Important:

  The "cleanup" option is a one-off used to reformat
  database entries into the new keys used by the Story
  class.

  The "remove" options is also basically a one-off.  It
  looks at the database for entries with duplication link
  values.  It keeps the last duplicate and deletes the rest
  on the theory that the last entry has an updated meta-data.

EOHELP

cli_helper("__file_description__") do |o|

  o.bool    '-a', '--announce', 'Say the title of the article', default: false
  o.bool    '-c', '--cleanup',  'Cleanup the database',         default: false
  o.integer '-l', '--last',     'List last X stories',          default: 0
  o.bool    '-r', '--remove',   'Remove duplicate links',       default: false
  o.bool    '-s', '--save',     'Save to a database',           default: false
  o.string  '-u', '--url',      'URL for the RSS feed',         default: ENV['RSS_FEEDS']

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

if ARGV.include?("-l") || ARGV.include?("--last")
  if 0 == configatron.last
    warning "You specificed the --last parameter but you forgot to say how many."
  end
end


######################################################
# Local classes/methods

# TODO: Add ability to sort stories on published_on dates
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

  property :published_on, from: 'published_at', required: true
  property :published_on, from: 'published_on', required: true
  property :published_on, from: :pubDate,       required: true
  property :published_on, from: 'pubDate',       required: true

  # Use the system's text to speach capability
  def announce
    sayable_text = text.gsub("'","")
    `say '#{sayable_text}'`
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
    "#{category}: #{title}; #{description}".gsub(/<\/?[^>]*>/, "")
  end
end # class Story < Hashie::Dash


# NOTE: orinally used the gem 'simple-rss' which returned the item
#       as a Hash.  Switched to the STDLIB rss which does not...
#       and switched to the gem "rssable" which also does not.
def hashify(item)
  result = Hash.new
  keys = %w[ title link author description published_at tags ]
  keys.each do |key|
    result[key] = item.send(key)
  end
  result['published_on'] = Time.parse item.published_at
  result['category'] = result['tags'].first
  return result
end # def hashify(item)

# SMELL: different feeds have different field names
# SMELL: different feeds have different last_pub_date
class RssFeed
  class NoLinkGivenError < RuntimeError; end
  class NoRssFeedFoundError < RuntimeError; end

  def initialize(
      links:  nil,
      rc:     nil,
      host:   'localhost',
      db:     'infowars',
      table:  'rss_feed'
    )

    raise NoLinkGivenError if links.nil?

    @rss  = Array(links).map{|link| RSSable.subscribe(link) }.compact

    raise NoRssFeedFoundError if @rss.nil?  ||  @rss.empty?


    @rc   = rc || Pathname.new(ENV['HOME']) +
                  ".#{__FILE__.split('/').last.gsub('.rb','rc.json')}"


    # @last_pub_dates is a Hash keyed by rss link, value is Time
    if @rc.exist?
      @last_pub_dates = JSON.parse @rc.read
    else
      @last_pub_dates = Hash.new
      @rss.each do |rss_feed|
        @last_pub_dates[rss_feed.link] = "June 3, 1953 13:00:00 -0500"
      end
    end

    # convert the time_strings into Time objects for comparison
    @last_pub_dates.each_pair do |link, time_string|
      @last_pub_dates[link] = Time.parse time_string
    end

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

    cleanup           if cleanup?
    remove_duplicates if remove?
    show_last_stories(configatron.last) unless configatron.last.nil?
  end # def initialize(....


  # process each story in the RSS feed
  def process
    # Typical RSS feed starts with the latest story first
    stories = Array.new

    # Collect all the stories from all the feeds.
    # ASSUMES: the different feeds present the stories in the same date order
    @rss.each do |rss_feed|
      last_pub_date = @last_pub_dates[rss_feed.link]
      last_pub_date = Time.parse last_pub_date if String == last_pub_date.class
      stories += rss_feed
                    .items.reverse
                    .map{|item|
                      # debug_me{[ 'item' ]}
                      Story.new(hashify(item))
                    }
                    .select{|story|
                      # debug_me{[ 'last_pub_date.class', 'last_pub_date',
                      #  'story.published_on.class', 'story.published_on' ]}
                      story.published_on > last_pub_date
                    }

      @last_pub_dates[rss_feed.link] = stories.last.published_on unless stories.empty?
    end # @rss.each do |rss_feed|

    stories.each do |story|
      unless duplicate?(story)
        puts "\n" + story.to_s  if verbose?
        story.announce          if announce?
        save story              if save?
      end
    end # stories.each do |story|

    rc_file = File.open(@rc, 'w')
    rc_file.puts @last_pub_dates.to_json
    rc_file.close
  end # def process


  ########################################################
  private

  # Save an RSS item into the database
  def save(story)
    @table.insert(story.to_h).run(@conn) unless duplicate?(story)
  end


  # Check the database to see if this story is a duplicate
  def duplicate?(story)
    return false
    result = @table.get_all(story.link, index: 'link').count().run(@conn)
    # puts "DUPLICATE" if result > 0

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
        debug_me(file: STDERR){[ :item ]}
      end
      @table.replace(story.to_h).run(@conn)
    end
    print "\n\n"
    debug_me{[ :tot_count, :bad_count ]}
  end # def cleanup


  # Before there was class there was no check for duplication.
  # This methods removes duplicate entries based upon the value of
  # link which is assumed to be unique on the website.
  def remove_duplicates
    before_count = @table.count().run(@conn)

    dups = @table.group('link').count().run(@conn).select{|link, count| count > 1}

    deleted_count = 0
    dups.each_pair do |link, count|
      results = @table
                  .get_all(link, index: 'link')
                  .order_by('published_on')
                  .run(@conn)
      (count-1).times do
        dup = results.shift
        @table.get(dup['id']).delete.run(@conn)
        deleted_count += 1
        puts "deleted id: #{dup['id']}"
      end
    end

    after_count = @table.count().run(@conn)

    debug_me{[ :before_count, :deleted_count, :after_count ]}
  end # def remove_duplicates


  def show_last_stories(how_many=10)
    @table
      .order_by(index: r.desc('published_on'))
      .limit(how_many)
      .run(@conn)
      .map{|item| Story.new(item)}
      .each do |story|
        puts "\n" + story.to_s
        story.announce    if announce?
      end
  end # def show_last_stories(how_many=10)
end # class RssFeed




######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end



Html = HTMLEntities.new

urls = configatron.url.split(';')

the_feeds = RssFeed.new links: urls
the_feeds.process

