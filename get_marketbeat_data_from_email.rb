#!/usr/bin/env ruby
#########################################################
###
##  File: get_marketbeat_data_from_email.rb
##  Desc: Extract actionable info from the MarketBeat daily eMail
##        newsletter.  Save the information into a RethinkDB table
#

# FIXME: The rethinkdb_helper is not really helpful in this application
#        because of the aggregator not being forwarded.

# TODO:   Looks like I'm processing the eMail text component.  Refactor to
#         use the HTML component.

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors
require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'progress_bar'   # Simple Progress Bar for output to a terminal
require 'rethinkdb_helper'
include RethinkDB::Shortcuts

require 'date'           # STDLIB

require 'mail'           # Mail provides a nice Ruby DSL for making, sending and reading emails.

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'
configatron.days    = 7         # number of back days of newsletter to retrieve

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("__file_description__") do |o|
  o.bool          '--drop',     "drop the db and table",  default: false
  o.string  '-u', '--user',     "user's email account",   default: ENV['GMAIL_USER']
  o.string  '-p', '--password', "user's email password",  default: ENV['GMAIL_PASS']
end

if configatron.user.nil?  ||  configatron.user.empty?
  require 'io/console'
  print "gMail Username: "
  configatron.user = gets.chomp
  print "gMail Password: "
  configatron.password = STDIN.noecho(&:gets).chomp
  puts
end

######################################################
# Local methods

db = RDB.new( db: 'analyst_ratings', table: 'upsndowns', drop: configatron.drop, create_if_missing: true )

unless configatron.drop
  # NOTE: last_date is of class Time
  begin
    last_date         = r.table('upsndowns').max(index: 'date')['date'].run
    configatron.days  = Date.today.mjd - last_date.to_date.mjd
  rescue
    configatron.days  = 500
  end
else
  configatron.days    = 500 # get them all when --drop is specified
end

if 0 == configatron.days
  puts "Nothing to update."
  exit
else
  puts "Retrieving #{configatron.days} days worth of data."
end

###################################################################
## Regular Expressions to extract data from upgrades and downgrades

re = Array.new

# The first regular expression should get everything.
# company_name
# exchange
# ticker_symbol
# analyst
# from_rating
# to_rating
# price_target
# percent_change
# prev_close
re << /^(?<company_name>.*) \((?<exchange>.*):(?<ticker_symbol>.*)\).*analysts at (?<analyst>.*) from a.* "(?<from_rating>.*)" rating .* "(?<to_rating>.*)".*\$(?<price_target>[1-9]\d?(?:,\d{3})*(?:\.\d{2})?) price target.* (?<percent_change>.*)%.*\$(?<prev_close>[1-9]\d?(?:,\d{3})*(?:\.\d{2})?)/


# company_name, exchange, ticker_symbol, analyst, to_rating, price_target
re << /^(?<company_name>.*) \((?<exchange>.*):(?<ticker_symbol>.*)\).*analysts at (?<analyst>.*) to a.*"(?<to_rating>.*)" rating\. .* \(\$(?<price_target>\d+.\d+)\) price target/


# company_name, exchange, ticker_symbol, analyst, to_rating, prev_close
re << /^(?<company_name>.*) \((?<exchange>.*):(?<ticker_symbol>.*)\).*analysts at (?<analyst>.*) from a.*"(?<from_rating>.*)" rating to a.*"(?<to_rating>.*)" rating\. .*closing price of \$(?<prev_close>\d+.\d+)\./


# company_name, exchange, ticker_symbol, analyst, to_rating, prev_close
re << /^(?<company_name>.*) \((?<exchange>.*):(?<ticker_symbol>.*)\).*analysts at (?<analyst>.*) .*to a.*"(?<to_rating>.*)" rating\. .*closing price of \$(?<prev_close>\d+.\d+)\./


# The last regular expression should get only the most common.
# company_name, exchange, ticker_symbol, analyst, to_rating
re << /^(?<company_name>.*) \((?<exchange>.*):(?<ticker_symbol>.*)\).*analysts at (?<analyst>.*) from a.*"(?<from_rating>.*)".*to a.*"(?<to_rating>.*)" rating\./


# Shawbrook Group PLC (LON:SHAW)  was downgraded by analysts at Barclays to an "equal weight" rating.

# company_name, exchange, ticker_symbol, analyst, to_rating
re << /^(?<company_name>.*) \((?<exchange>.*):(?<ticker_symbol>.*)\).*analysts at (?<analyst>.*) .*to a.*"(?<to_rating>.*)" rating\./

########################################################


Mail.defaults do
  retriever_method :imap, address:    "imap.gmail.com",
                          port:       993,
                          user_name:  configatron.user,
                          password:   configatron.password,
                          enable_ssl: true
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

puts "Retrieving eMails ..."
emails = Mail.find( what:   :last,
                    count:  500, # configatron.days,      # how many days back from today
                    order:  :asc,
                    keys:   'FROM newsletters@analystratings.net')


bar = ProgressBar.new(emails.size)


# IMAPv4 RFC 3501 March 2003
# Section 6.4.4 the SEARCH command
# value for 'keys:' can take on these values

=begin

      ALL
         All messages in the mailbox; the default initial key for
         ANDing.

      ANSWERED
         Messages with the \Answered flag set.

      BCC <string>
         Messages that contain the specified string in the envelope
         structure's BCC field.

      BEFORE <date>
         Messages whose internal date (disregarding time and timezone)
         is earlier than the specified date.

      BODY <string>
         Messages that contain the specified string in the body of the
         message.

      CC <string>
         Messages that contain the specified string in the envelope
         structure's CC field.

      DELETED
         Messages with the \Deleted flag set.

      DRAFT
         Messages with the \Draft flag set.

      FLAGGED
         Messages with the \Flagged flag set.

      FROM <string>
         Messages that contain the specified string in the envelope
         structure's FROM field.

      HEADER <field-name> <string>
         Messages that have a header with the specified field-name (as
         defined in [RFC-2822]) and that contains the specified string
         in the text of the header (what comes after the colon).  If the
         string to search is zero-length, this matches all messages that
         have a header line with the specified field-name regardless of
         the contents.

      KEYWORD <flag>
         Messages with the specified keyword flag set.

      LARGER <n>
         Messages with an [RFC-2822] size larger than the specified
         number of octets.

      NEW
         Messages that have the \Recent flag set but not the \Seen flag.
         This is functionally equivalent to "(RECENT UNSEEN)".

      NOT <search-key>
         Messages that do not match the specified search key.

      OLD
         Messages that do not have the \Recent flag set.  This is
         functionally equivalent to "NOT RECENT" (as opposed to "NOT
         NEW").

      ON <date>
         Messages whose internal date (disregarding time and timezone)
         is within the specified date.

      OR <search-key1> <search-key2>
         Messages that match either search key.

      RECENT
         Messages that have the \Recent flag set.

      SEEN
         Messages that have the \Seen flag set.

      SENTBEFORE <date>
         Messages whose [RFC-2822] Date: header (disregarding time and
         timezone) is earlier than the specified date.

      SENTON <date>
         Messages whose [RFC-2822] Date: header (disregarding time and
         timezone) is within the specified date.

      SENTSINCE <date>
         Messages whose [RFC-2822] Date: header (disregarding time and
         timezone) is within or later than the specified date.

      SINCE <date>
         Messages whose internal date (disregarding time and timezone)
         is within or later than the specified date.

      SMALLER <n>
         Messages with an [RFC-2822] size smaller than the specified
         number of octets.

      SUBJECT <string>
         Messages that contain the specified string in the envelope
         structure's SUBJECT field.

      TEXT <string>
         Messages that contain the specified string in the header or
         body of the message.

      TO <string>
         Messages that contain the specified string in the envelope
         structure's TO field.

      UID <sequence set>
         Messages with unique identifiers corresponding to the specified
         unique identifier set.  Sequence set ranges are permitted.

      UNANSWERED
         Messages that do not have the \Answered flag set.

      UNDELETED
         Messages that do not have the \Deleted flag set.

      UNDRAFT
         Messages that do not have the \Draft flag set.

      UNFLAGGED
         Messages that do not have the \Flagged flag set.

      UNKEYWORD <flag>
         Messages that do not have the specified keyword flag set.

      UNSEEN
         Messages that do not have the \Seen flag set.

=end

#ap emails.first.methods


puts "Processing eMails ..."

Array(emails).each do |mail|
  bar.increment!
  next unless mail.from.include? "newsletters@analystratings.net"
  next unless mail.html_part.respond_to? :raw_source

  # puts "Date: #{mail.date}"

  # FIXME: refactor to use the HTML instead of TEXT

  raw_source = mail.html_part.raw_source
  processed_source = raw_source.
                        gsub("=\r\n",     '').
                        gsub('=3D',       '=').
                        gsub('=E2=80=99', "'").
                        gsub('=E2=80=9C', '"').
                        gsub('=E2=80=9D', '"').
                        gsub('=E2=80=A6', '...')



  f= File.open('content.html','w')
  f.puts processed_source
  f.close

  raw_text        = `html2text content.html`
  processed_text  = raw_text.
                        gsub("\n(\n", " (").
                        gsub("\n)", ")").
                        gsub("Read More\n.  \nTweet This\n.", '').
                        gsub(" \n", "\n").
                        gsub("analysts at\n", "analysts at ").
                        gsub("\nfrom", " from").
                        gsub(" \n", "\n")

  f= File.open('content.txt','w')
  f.puts processed_text
  f.close

  begin
    text_array = processed_text.split("\n")
  rescue
    text_array = []
  end

  upgrades    = []
  downgrades  = []

  collect_up  = false
  collect_down= false

  text_array.each do |t|
    next if t.empty?
    next unless collect_up || t.downcase.start_with?("analysts' upgrades")
    unless collect_up
      collect_up = true
      next
    end
    if t.downcase.include?("analysts' upgrades")
      collect_up = false
      next
    end
    upgrades << t
  end

  text_array.each do |t|
    next if t.empty?
    next unless collect_down || t.downcase.start_with?("analysts' downgrades")
    unless collect_down
      collect_down = true
      next
    end
    if t.downcase.include?("analysts' downgrades")
      collect_down = false
      next
    end
    downgrades << t
  end

  analysts_pronouncements = upgrades + downgrades

  analysts_pronouncements.each do |ac|
    record = Hash.new
    record[:date] = mail.date.to_time

    match_data = nil

    re.each do |r|
      match_data    = r.match ac
      break unless match_data.nil?
    end

    if match_data.nil?
      puts
      puts "ERROR: Need new regexp for:"
      puts ac
      puts
      next
    end

    %w[ company_name  exchange      ticker_symbol   analyst  from_rating
        to_rating     price_target  percent_change  prev_close
        ].each do |field|
      symbol = field.to_sym
      record[ symbol ] = match_data.names.include?(field)   ? match_data[symbol].strip : nil
    end

    db.insert(record)

  end

end # emails.each do |mail|

__END__

from irb sessions

require 'loofah'
require 'pathname'
require 'debug_me'
include DebugMe

###################################################################
## Regular Expressions to extract data from upgrades and downgrades

RE = Array.new

# The first regular expression should get everything.
# analyst
# from_rating
# to_rating
# price_target
# percent_change
# prev_close
RE << /.*analysts at (?<analyst>.*) from a.* "(?<from_rating>.*)" rating .* "(?<to_rating>.*)".*\$(?<price_target>[1-9]\d?(?:,\d{3})*(?:\.\d{2})?) price target.* (?<percent_change>.*)%.*\$(?<prev_close>[1-9]\d?(?:,\d{3})*(?:\.\d{2})?)/


# analyst, to_rating, price_target
RE << /.*analysts at (?<analyst>.*) to a.*"(?<to_rating>.*)" rating\. .* \(\$(?<price_target>\d+.\d+)\) price target/


# analyst, to_rating, prev_close
RE << /.*analysts at (?<analyst>.*) from a.*"(?<from_rating>.*)" rating to a.*"(?<to_rating>.*)" rating\. .*closing price of \$(?<prev_close>\d+.\d+)\./


# analyst, to_rating, prev_close
RE << /.*analysts at (?<analyst>.*) .*to a.*"(?<to_rating>.*)" rating\. .*closing price of \$(?<prev_close>\d+.\d+)\./


# The last regular expression should get only the most common.
# analyst, to_rating
RE << /.*analysts at (?<analyst>.*) from a.*"(?<from_rating>.*)".*to a.*"(?<to_rating>.*)" rating\./


# Shawbrook Group PLC (LON:SHAW)  was downgraded by analysts at Barclays to an "equal weight" rating.

# analyst, to_rating
RE << /.*analysts at (?<analyst>.*) .*to a.*"(?<to_rating>.*)" rating\./

########################################################

file_path = Pathname.new 'content.html'

HTML = file_path.read

DOC = Loofah.document(HTML).scrub!(:whitewash).scrub!(:unprintable)

SPANS = DOC.xpath '//span'  # There are 9 of them
5.times {|x| SPANS.shift} # only want the last 4

ULS = DOC.xpath('//ul'); nil
5.times {|x| ULS.shift} # only want the last 4

UPS     = ULS[0].children.select{|item| 7==item.children.size}; nil
DOWNS   = ULS[1].children.select{|item| 7==item.children.size}; nil
STARTS  = ULS[2].children.select{|item| 7==item.children.size}; nil
CHANGES = ULS[3].children.select{|item| 7==item.children.size}; nil

def get_items(data_source)
  result = Array.new
  data_source.each do |item|
    next unless 7 == item.children.size
    result << extract(item)
  end
  return result
end


def re_play(a_string)
  result = Hash.new
  # puts "\n\n================================"
  # puts "\nPlay with RE .... #{a_string}"
  RE.each_with_index do |r, which_one|
    # puts "-----------------------------------"
    # puts "RE[#{which_one}] -=> #{r}"
    data = r.match a_string
    next if data.nil?
    debug_me(header: false) {:data}
    data.names.map{|name| name.to_sym}.each do |field|
      result[field] = data[field]
    end

    break # The first non nil match is usually the best
  end
  return result
end


def extract(item)
  source        = item.to_s.gsub("\r\n",'')
  company_name  = item.children[1].text.strip.chomp

  exchange, ticker_symbol = item.children[3].text.strip.chomp.split(':')

  message    = item.children[4].text.chomp
  message[0] = ' ' # its alwasy a ')'
  message.strip!

  re_play(message)

  action  = if message.start_with? 'was upgraded'
      'upgrade'
    elsif message.start_with? 'was downgraded'
      'downgrade'
    elsif message.start_with? 'had its'
      'change'
    elsif message.start_with? 'is now'
      'start'
    else
      'unknown'
  end

  analyst         = nil
  from_rating     = nil
  to_rating       = nil
  price_target    = nil
  percent_change  = nil
  prev_close      = nil

  result = {
    source:         source,
    company_name:   company_name,
    exchange:       exchange,
    ticker_symbol:  ticker_symbol,
    action:         action,
    message:        message,
    analyst:        analyst,
    from_rating:    from_rating,
    to_rating:      to_rating,
    price_target:   price_target,
    percent_change: percent_change,
    prev_close:     prev_close,
  }

  return result.merge(re_play(message))
end



=> ["Analysts' Upgrades\r\n", "Analysts' Downgrades\r\n", "Analysts' New Coverage\r\n", "Analysts' Price Target Changes\r\n"]



There are 9 spans; each is followed by a <UL> list.  Only the last 4 are collected

SPANS[5..8].map{|s| s.text}
=> ["Analysts' Upgrades\r\n", "Analysts' Downgrades\r\n", "Analysts' New Coverage\r\n", "Analysts' Price Target Changes\r\n"]

actions look like this:

:action => "was upgraded by analysts at Benchmark Co. from a \"hold\" rating to a \"buy\" rating. current price of $82.13."

:action => "was downgraded by analysts at Sidoti from a \"buy\" rating to a \"neutral\" rating. current price of $29.70."

:action => "had its price target raised by analysts at Numis Securities Ltd from GBX 4,204 ($58.08) to GBX 4,310 ($59.55). They now have a \"buy\" rating on the stock."

:action => "is now covered by analysts at Shore Capital. They set an \"accumulate\" rating and a GBX 3.25 ($0.04) price target on the stock."

:action => "is now covered by analysts at Liberum Capital. They set an \"accumulate\" rating on the stock."

=end
