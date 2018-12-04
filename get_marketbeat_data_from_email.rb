#!/usr/bin/env ruby
#########################################################
###
##  File: get_marketbeat_data_from_email.rb
##  Desc: Extract actionable info from the MarketBeat daily eMail
##        newsletter.  Save the information into a RethinkDB table
##
##  NOTE: Since this data is coming from eMail the format of the eMail
##        content changes over time.
#

require 'date'          # STDLIB
require 'load_gems'     # from my lib/ruby directory

load_gems %w[ awesome_print cli_helper debug_me loofah mail progress_bar rethinkdb_helper ]

include DebugMe
include CliHelper
include RethinkDB::Shortcuts

configatron.version = '0.1.0'

HELP = <<EOHELP
Important:

  Use --no-save option to disable saving to database.

EOHELP

cli_helper("__file_description__") do |o|
  o.bool          '--drop',     "drop the db and table",    default: false
  o.integer       '--days',     'Number of days for mail',  default: 0
  o.bool    '-s', '--save',     'Save to database',         default: true
  o.string  '-u', '--user',     "user's email account",     default: ENV['GMAIL_USER']
  o.string  '-p', '--password', "user's email password",    default: ENV['GMAIL_PASS']
end

if configatron.user.nil?  || configatron.user.empty?
  print "gMail Username: "
  configatron.user = STDIN.gets.chomp
end

if configatron.password.nil?  || configatron.password.empty?
  print "gMail Password: "
  configatron.password = STDIN.noecho(&:gets).chomp
  puts
end

######################################################
# Local methods
if save?

  DB = RDB.new(
            db:     'analyst_ratings',
            table:  'upsndowns',
            drop:   configatron.drop,
            create_if_missing: true
        )
end

unless configatron.drop
  # NOTE: last_date is of class Time
  begin
    last_date         = r.table('upsndowns').max(index: 'date')['date'].run
    configatron.days  = Date.today.mjd - last_date.to_date.mjd if 0==configatron.days
  rescue
    configatron.days  = 500 if 0==configatron.days
  end
else
  configatron.days    = 500 if 0==configatron.days
end

if 0 == configatron.days
  puts "Nothing to update."
  exit
else
  puts "Retrieving #{configatron.days} days worth of data."
end

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


RE << /.*had its price target .* by analysts at (?<analyst>.*) from \$(?<old_price_target>\d+.\d+) to \$(?<price_target>\d+.\d+).*have a \"(?<to_rating>.*)\" rating.*.* (?<percent_change>\d+.\d+)%.* current price of \$(?<prev_close>\d+.\d+)\./

#   "is now covered by analysts at Canaccord Genuity. They set a \"hold\" rating and a $336.00 price target on the stock. 4.3% downside from the current price of $351.19.",
# analyst, to_rating, price_target, precent_change, prev_close
RE << /.*covered by analysts at (?<analyst>.*) They set a.*"(?<to_rating>.*)" rating .*\$(?<price_target>\d+.\d+) price target.* (?<percent_change>\d+.\d+)%.* current price of \$(?<prev_close>\d+.\d+)\./


# analyst, to_rating, price_target
RE << /.*analysts at (?<analyst>.*) to a.*"(?<to_rating>.*)" rating\. .* \(\$(?<price_target>\d+.\d+)\) price target/


# analyst, to_rating, prev_close
RE << /.*analysts at (?<analyst>.*) from a.*"(?<from_rating>.*)" rating to a.*"(?<to_rating>.*)" rating\. .*[closing|current] price of \$(?<prev_close>\d+.\d+)\./


# analyst, to_rating, prev_close
RE << /.*analysts at (?<analyst>.*) .*to a.*"(?<to_rating>.*)" rating\. .*[closing|current] price of \$(?<prev_close>\d+.\d+)\./


# The last regular expression should get only the most common.
# analyst, to_rating
RE << /.*analysts at (?<analyst>.*) from a.*"(?<from_rating>.*)".*to a.*"(?<to_rating>.*)" rating\./


# Shawbrook Group PLC (LON:SHAW)  was downgraded by analysts at Barclays to an "equal weight" rating.

# analyst, to_rating
RE << /.*analysts at (?<analyst>.*) .*to a.*"(?<to_rating>.*)" rating\./

########################################################


Mail.defaults do
  retriever_method :imap, address:    "imap.gmail.com",
                          port:       993,
                          user_name:  configatron.user,
                          password:   configatron.password,
                          enable_ssl: true
end


def get_items(data_source)
  data_source.each do |item|
    extract(item) if item.children.size >= 5
  end
end


def re_play(a_string)
  result = Hash.new
  puts "\n\n================================"     if debug?
  puts "\nPlay with RE .... #{a_string}"          if debug?
  RE.each_with_index do |r, which_one|
    puts "-----------------------------------"    if debug?
    puts "RE[#{which_one}] -=> #{r}"              if debug?
    data = r.match a_string
    next if data.nil?
    debug_me(header: false) {:data}               if debug?
    data.names.map{|name| name.to_sym}.each do |field|
      result[field] = data[field]
    end

    break # The first non nil match is usually the best
  end

  debug_me{:result}  if debug?

  return result
end


def extract(item)
  source        = item.to_s.gsub("\r\n",'')
  kids = item.children.map{|k| k.text.strip}
  debug_me{[ :source, :kids ]}                if debug?

  company_name  = kids[0]

  exchange, ticker_symbol = kids[2].split(':')

  message    = kids[3]
  message[0] = ' ' # its alwasy a ')'
  message.strip!

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
    date:           DATE,
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
  }.merge(re_play(message))

  debug_me{:result} if debug?

  DB.insert result    if save?
end


def kill_bad_characters(a_string)
  return a_string.
            gsub("=\r\n",     '').
            gsub('=3D',       '=').
            gsub('=E2=80=99', "'").
            gsub('=E2=80=9C', '"').
            gsub('=E2=80=9D', '"').
            gsub('=E2=80=A6', '...')
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
emails = Array(
            Mail.find( what:   :last,
                    count:  configatron.days,      # how many days back from today
                    order:  :asc,
                    keys:   'FROM newsletters@analystratings.net')
          )


bar = ProgressBar.new(emails.size)




puts "Processing eMails ..."

emails.each do |mail|
  bar.increment!

  next unless mail.from.include? "newsletters@analystratings.net"
  # next unless mail.html_part.respond_to? :raw_source


  if mail.html_part.nil?
    raw_source = kill_bad_characters(mail.body.raw_source)
  else
    raw_source = kill_bad_characters(mail.html_part.body.raw_source)
  end

  f= File.open('content.html','w')
  f.puts raw_source
  f.close

  DATE =  mail.date.to_time   # RethinkDB only supports the Time class.

  doc = Loofah.document(raw_source)
              .scrub!(:whitewash)


  spans     = doc.xpath('//span')
                .scrub!(:whitewash)

  spans = spans[-4..spans.size-1]

  sections  = doc.xpath('//ul')
                .scrub!(:whitewash)

  next if sections.nil? || sections.size < 4  # Strange format not to have any <ul> tags

  sections = sections[-4..sections.size-1]

=begin
  spans.each do |span|
    STDERR.puts span.text
  end
=end

  upgrades            = sections[0].children #.select{|item| 7==item.children.size}
  downgrades          = sections[1].children #.select{|item| 7==item.children.size}
  start_coverage      = sections[2].children #.select{|item| 7==item.children.size}
  change_target_price = sections[3].children #.select{|item| 7==item.children.size}

  get_items(upgrades)
  get_items(downgrades)
  get_items(change_target_price)
  get_items(start_coverage)

end # emails.each do |mail|

__END__

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
