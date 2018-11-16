#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: get_historical_stock_data.rb
##  Desc: get_historical_stock_data
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'
require 'faraday'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("get_historical_stock_data") do |o|

  o.string  '-t', '--ticker',       'Ticker Symbol'
  o.bool    '-f', '--full_history', 'Retrieve Full History',   default: false

  # o.int     '-i', '--int',    'example integer parameter',   default: 42
  # o.float   '-f', '--float',  'example float parameter',     default: 123.456
  # o.array   '-a', '--array',  'example array parameter',     default: [:bob, :carol, :ted, :alice]
  # o.path    '-p', '--path',   'example Pathname parameter',  default: Pathname.new('default/path/to/file.txt')
  # o.paths         '--paths',  'example Pathnames parameter', default: ['default/path/to/file.txt', 'file2.txt'].map{|f| Pathname.new f}

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


# used to download a complete history for the
# ticker_symbol upto today as a CSV file.
def full_url_for(ticker_symbol)
  "http://download.macrotrends.net/assets/php/stock_data_export.php?t=#{ticker_symbol.upcase}"
end


def update_url_for(ticker_symbol, days: 5)
  "http://app.quotemedia.com/quotetools/getHistoryDownload.csv?&webmasterId=501&startDay=1&startMonth=1&startYear=2018&endDay=15&endMonth=11&endYear=2018&isRanged=true&symbol=#{ticker_symbol.upcase}"
end


def get_csv_from(a_url)
  Faraday.get(a_url).body
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


csv_data = get_csv_from(full_history? ? full_url_for(configatron.ticker) : update_url_for(configatron.ticker))

puts "\n#{configatron.ticker}\n\n"

puts csv_data

