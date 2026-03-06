#!/usr/bin/env ruby
# remadd - Add reminders using natural language date/time expressions
#
# Uses the Chronic gem to parse natural language into dates,
# then writes a properly formatted entry to a remind(1) file.
#
# Usage:
#   remadd "Call dentist" tomorrow
#   remadd "Team lunch" next friday at noon
#   remadd "Sprint review" in 3 days at 10am
#   remadd "Standup" every monday at 9am
#   remadd "Quilt Guild" second thursday at 0930 for 2 hours
#   remadd "Quilt Guild" second thursday from 0930 to 1130
#   remadd "Stretch" daily at 1030
#   remadd "Standup" weekdays at 9am
#   remadd "Pay bills" monthly on the 15th
#   remadd "Sync" every other friday at 2pm
#   remadd "Conference" third thursday in november at 9am
#   remadd "Project" next monday at 9am until december 31
#   remadd -r "Thu 8 ++7 AT 09:30 MSG Quilt Guild %"
#   remadd -f work "Deploy" next wednesday at 1500
#   remadd -a 7 "License renewal" september 1
#   remadd --list
#   remadd --help

require 'chronic'
require 'date'
require 'optparse'
require 'fileutils'

REMIND_DIR  = ENV.fetch('REMIND_DIR', File.expand_path('~/Documents/reminders'))
MONTH_NAMES = Date::MONTHNAMES  # nil-indexed: MONTH_NAMES[1] = "January"
DAY_NAMES   = Date::DAYNAMES

FILE_MAP = {
  'personal' => '040-personal.rem',
  'work'     => '030-work.rem',
  'health'   => '020-health.rem',
  'recurring'=> '010-recurring.rem',
}

ORDINALS = {
  'first' => 1, 'second' => 8, 'third' => 15,
  'fourth' => 22, 'last' => 25,
  '1st' => 1, '2nd' => 8, '3rd' => 15, '4th' => 22,
}

DAY_ABBREVS = DAY_NAMES.map { |d| d[0..2] }

###############################################
## Helper methods

# Convert 24-hour time (e.g. "0930", "1445") to "9:30am", "2:45pm"
# so Chronic can parse it.
def normalize_24hr(expr)
  expr.gsub(/\b(\d{4})\b/) do |match|
    h, m = match[0..1].to_i, match[2..3].to_i
    next match if h > 23 || m > 59
    next match if h > 1900
    period = h >= 12 ? 'pm' : 'am'
    h = h % 12
    h = 12 if h == 0
    m == 0 ? "#{h}#{period}" : "#{h}:%02d#{period}" % m
  end
end

def remind_date(parsed)
  month = MONTH_NAMES[parsed.month][0..2]
  "#{month} #{parsed.day} #{parsed.year}"
end

def remind_time(parsed)
  "AT %02d:%02d" % [parsed.hour, parsed.min]
end

def remind_day_abbrev(day_name)
  day_name.capitalize[0..2]
end

def has_time?(parsed, time_expr)
  parsed.hour != 0 || parsed.min != 0 || time_expr =~ /at\s/i
end

###############################################
## Duration parsers

# "for 3 hours", "dur 90m", "duration 2h30m"
FOR_RE = /\b(?:for|dur(?:ation)?)\s+(.+?)$/i

def parse_for_duration(expr)
  match = expr.match(FOR_RE)
  return nil unless match

  dur_str = match[1].strip
  total_minutes = 0

  if dur_str =~ /^(\d+(?:\.\d+)?)\s*h(?:(?:ou)?rs?)?(?:\s*(\d+)\s*m(?:in(?:ute)?s?)?)?$/i
    total_minutes = ($1.to_f * 60).to_i
    total_minutes += $2.to_i if $2
  elsif dur_str =~ /^(\d+)\s*m(?:in(?:ute)?s?)?$/i
    total_minutes = $1.to_i
  else
    return nil
  end

  return nil if total_minutes <= 0

  duration = "%d:%02d" % [total_minutes / 60, total_minutes % 60]
  rest = expr.sub(FOR_RE, '').strip
  [duration, rest]
end

# "between 0930 and 1130" or "from 9am to 11:30am"
BETWEEN_RE = /\b(?:between|from)\s+(.+?)\s+(?:and|to)\s+(.+?)$/i

def parse_between(expr)
  match = expr.match(BETWEEN_RE)
  return nil unless match

  raw_start = normalize_24hr(match[1].strip)
  raw_end   = normalize_24hr(match[2].strip)

  t_start = Chronic.parse("today at #{raw_start}")
  t_end   = Chronic.parse("today at #{raw_end}")
  return nil unless t_start && t_end

  diff = ((t_end - t_start) / 60).to_i
  if diff <= 0
    $stderr.puts "Error: end time must be after start time"
    exit 1
  end

  duration = "%d:%02d" % [diff / 60, diff % 60]
  [t_start, duration]
end

# "until december 31" or "until Dec 31 2027"
UNTIL_RE = /\buntil\s+(.+?)$/i

def parse_until(expr)
  match = expr.match(UNTIL_RE)
  return nil unless match

  parsed = Chronic.parse(match[1].strip)
  return nil unless parsed

  rest = expr.sub(UNTIL_RE, '').strip
  [parsed, rest]
end

###############################################
## Composite time+duration parser

# Parse time and optional duration from a trailing expression.
# Handles: "at 0930 for 3 hours", "between 9am and 11am", "from 9 to 11", "at 2pm"
def _parse_time_and_duration(rest)
  return "" if rest.nil? || rest.strip.empty?

  between = parse_between(rest)
  if between
    t_start, duration = between
    return " #{remind_time(t_start)} DURATION #{duration}"
  end

  for_result = parse_for_duration(rest)
  if for_result
    duration, time_part = for_result
    time_part = time_part.sub(/^at\s+/i, '').strip
    result = ""
    if time_part.length > 0
      parsed = Chronic.parse("today at #{time_part}")
      result += " #{remind_time(parsed)}" if parsed && has_time?(parsed, rest)
    end
    result += " DURATION #{duration}"
    return result
  end

  time_part = rest.sub(/^at\s+/i, '')
  parsed = Chronic.parse("today at #{time_part}")
  return " #{remind_time(parsed)}" if parsed && has_time?(parsed, rest)
  ""
end

###############################################
## Pattern matchers (order matters)

ORDINAL_RE = /^(#{ORDINALS.keys.join('|')})\s+(#{DAY_NAMES.join('|')})\b(.*)$/i

# "third thursday in november at 9am"
ORDINAL_MONTH_RE = /^(#{ORDINALS.keys.join('|')})\s+(#{DAY_NAMES.join('|')})\s+(?:in|of)\s+(#{MONTH_NAMES.compact.join('|')})\b(.*)$/i

def build_reminder(message, time_expr, advance:, until_date: nil)
  time_expr = normalize_24hr(time_expr)

  # Check for UNTIL clause first and extract it
  if until_date.nil?
    until_result = parse_until(time_expr)
    if until_result
      until_date, time_expr = until_result
    end
  end

  until_clause = until_date ? " UNTIL #{remind_date(until_date)}" : ""

  # --- daily at 9am [for 2 hours] ---
  if time_expr =~ /^daily\b(.*)$/i
    rest = $1.strip
    line = "REM"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- weekdays at 9am [for 30m] ---
  if time_expr =~ /^weekdays?\b(.*)$/i
    rest = $1.strip
    line = "REM Mon Tue Wed Thu Fri"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- weekends at 10am ---
  if time_expr =~ /^weekends?\b(.*)$/i
    rest = $1.strip
    line = "REM Sat Sun"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- monthly on the 15th [at 9am] ---
  if time_expr =~ /^monthly\s+(?:on\s+)?(?:the\s+)?(\d+)(?:st|nd|rd|th)?\b(.*)$/i
    day_of_month = $1.to_i
    rest = $2.strip
    line = "REM #{day_of_month}"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- every other friday [at 2pm] ---
  if time_expr =~ /^every\s+other\s+(#{DAY_NAMES.join('|')})\b(.*)$/i
    day = remind_day_abbrev($1)
    rest = $2.strip
    # Remind doesn't have native biweekly; use SATISFY with week parity
    line = "REM #{day}"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += " SATISFY [trigger(trigdate()) && ((coerce(\"INT\", trigdate()) / 7) % 2) == 0]"
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- third thursday in november [at 9am] ---
  ordinal_month_match = time_expr.match(ORDINAL_MONTH_RE)
  if ordinal_month_match
    start_day = ORDINALS[ordinal_month_match[1].downcase]
    day = remind_day_abbrev(ordinal_month_match[2])
    month = ordinal_month_match[3].capitalize[0..2]
    rest = ordinal_month_match[4].strip
    line = "REM #{day} #{month} #{start_day} ++7"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- second thursday [at 0930 for 2 hours] ---
  ordinal_match = time_expr.match(ORDINAL_RE)
  if ordinal_match
    start_day = ORDINALS[ordinal_match[1].downcase]
    day = remind_day_abbrev(ordinal_match[2])
    rest = ordinal_match[3].strip
    line = "REM #{day} #{start_day} ++7"
    line += " +#{advance}" if advance > 0
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- every monday [at 9am] ---
  recurring_match = time_expr.match(/^every\s+(#{DAY_NAMES.join('|')})\b(.*)/i)
  if recurring_match
    day = remind_day_abbrev(recurring_match[1])
    rest = recurring_match[2].strip
    line = "REM #{day}"
    line += _parse_time_and_duration(rest)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- between/from-to in one-off reminders ---
  between = parse_between(time_expr)
  if between
    date_expr = time_expr.sub(BETWEEN_RE, '').strip
    t_start, duration = between

    if date_expr.length > 0
      parsed = Chronic.parse(date_expr)
      unless parsed
        $stderr.puts "Error: Could not parse date '#{date_expr}'"
        exit 1
      end
      line = "REM #{remind_date(parsed)}"
    else
      line = "REM #{remind_date(Time.now)}"
    end

    line += " +#{advance}" if advance > 0
    line += " #{remind_time(t_start)} DURATION #{duration}"
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- for duration in one-off reminders ---
  for_result = parse_for_duration(time_expr)
  if for_result
    duration, date_time_expr = for_result
    parsed = Chronic.parse(date_time_expr)
    unless parsed
      $stderr.puts "Error: Could not parse '#{date_time_expr}'"
      exit 1
    end

    line = "REM #{remind_date(parsed)}"
    line += " +#{advance}" if advance > 0
    line += " #{remind_time(parsed)} DURATION #{duration}" if has_time?(parsed, date_time_expr)
    line += until_clause
    line += " MSG #{message} %"
    return line
  end

  # --- plain date/time (Chronic handles the rest) ---
  parsed = Chronic.parse(time_expr)
  unless parsed
    $stderr.puts "Error: Could not parse '#{time_expr}'"
    exit 1
  end

  line = "REM #{remind_date(parsed)}"
  line += " +#{advance}" if advance > 0
  line += " #{remind_time(parsed)}" if has_time?(parsed, time_expr)
  line += until_clause
  line += " MSG #{message} %"
  line
end

###############################################
## Main

options = { file: 'personal', advance: 0 }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: remadd [options] \"message\" <natural language date/time>"

  opts.on('-f', '--file KEY', FILE_MAP.keys.join(', '),
          "Target file (default: personal)") do |f|
    options[:file] = f
  end

  opts.on('-a', '--advance DAYS', Integer,
          "Days of advance warning (default: 0)") do |a|
    options[:advance] = a
  end

  opts.on('-r', '--raw REMINDER', "Raw remind(1) syntax passthrough") do |r|
    options[:raw] = r
  end

  opts.on('--list', "Show recent additions") do
    options[:list] = true
  end

  opts.on('--files', "Show available target files") do
    options[:show_files] = true
  end

  opts.separator ""
  opts.separator "Examples:"
  opts.separator '  remadd "Call dentist" tomorrow at 2pm'
  opts.separator '  remadd "Sprint review" next friday at 10am'
  opts.separator '  remadd "Check build" in 3 days'
  opts.separator '  remadd "Standup" daily at 9am'
  opts.separator '  remadd "Standup" weekdays at 9am'
  opts.separator '  remadd "Standup" every monday at 9am'
  opts.separator '  remadd "Sync" every other friday at 2pm'
  opts.separator '  remadd "Quilt Guild" second thursday at 0930 for 2 hours'
  opts.separator '  remadd "Quilt Guild" second thursday from 0930 to 1130'
  opts.separator '  remadd "Pay rent" first monday'
  opts.separator '  remadd "Pay bills" monthly on the 15th'
  opts.separator '  remadd "Conference" third thursday in november at 9am'
  opts.separator '  remadd "Project" next monday at 9am until december 31'
  opts.separator '  remadd "Yoga" every tuesday at 6am for 90 minutes'
  opts.separator '  remadd -f work "Deploy" next wednesday at 3pm'
  opts.separator '  remadd -a 7 "Birthday party" june 15'
  opts.separator '  remadd -r "Thu 8 ++7 AT 09:30 MSG Quilt Guild %"'
end

parser.parse!

if options[:show_files]
  FILE_MAP.each do |key, filename|
    path = File.join(REMIND_DIR, filename)
    exists = File.exist?(path) ? "exists" : "missing"
    puts "  %-12s -> %s (%s)" % [key, filename, exists]
  end
  exit 0
end

if options[:list]
  target = File.join(REMIND_DIR, FILE_MAP[options[:file]])
  if File.exist?(target)
    lines = File.readlines(target).reject { |l| l.strip.empty? || l.start_with?('#') }
    puts lines.last(10).join
  else
    puts "File not found: #{target}"
  end
  exit 0
end

# Raw passthrough
if options[:raw]
  reminder = options[:raw].strip
  reminder = "REM #{reminder}" unless reminder.start_with?('REM ')
  target = File.join(REMIND_DIR, FILE_MAP[options[:file]])
  FileUtils.mkdir_p(REMIND_DIR)
  File.open(target, 'a') { |f| f.puts reminder }
  puts "Added to #{FILE_MAP[options[:file]]}:"
  puts "  #{reminder}"
  exit 0
end

if ARGV.length < 2
  puts parser.help
  exit 1
end

message   = ARGV.shift
time_expr = ARGV.join(' ')

reminder = build_reminder(message, time_expr, advance: options[:advance])
target   = File.join(REMIND_DIR, FILE_MAP[options[:file]])

FileUtils.mkdir_p(REMIND_DIR)
File.open(target, 'a') { |f| f.puts reminder }

puts "Added to #{FILE_MAP[options[:file]]}:"
puts "  #{reminder}"
