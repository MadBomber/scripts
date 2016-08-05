#!/usr/bin/env ruby
#########################################################
###
##  File: get_marketbeat_data_from_email.rb
##  Desc: Extract actionable info from the MarketBeat daily eMail
##        newsletter.  Save the information into a RethinkDB table
#

# FIXME: The rethinkdb_helper is not really helpful in this application
#        because of the aggregator not being forwarded.

require 'awesome_print'
require 'debug_me'
include DebugMe

require 'progress_bar'
require 'rethinkdb_helper'
include RethinkDB::Shortcuts

require 'date'

require 'mail'

require 'cli_helper'
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
  last_date         = r.table('upsndowns').max(index: 'date')['date'].run
  configatron.days  = Date.today.mjd - last_date.to_date.mjd
else
  configatron.days  = 500 # get them all when --drop is specified
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


if 1 == configatron.days
  emails = [ emails ]
end
  
puts "Processing eMails ..."

emails.each do |mail|
  bar.increment!
  next unless mail.from.include? "newsletters@analystratings.net"
  next unless mail.html_part.respond_to? :raw_source

  # puts "Date: #{mail.date}"

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

  text_array = processed_text.split("\n")

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
      record[ symbol ] = match_data.names.include?(field)   ? match_data[symbol] : nil
    end

    db.insert(record)

  end

end # emails.each do |mail|

