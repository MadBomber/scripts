#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
##########################################################
###
##  File: get_historical_stock_data.rb
##  Desc: get_historical_stock_data
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#
# TODO: Add access to the rethinkdb stock price database
#

require 'csv'
require 'date'

class Date
  def self.yesterday
    today - 1
  end
  def self.tomorrow
    today + 1
  end
end

require 'awesome_print'
require 'faraday'
require 'faraday_middleware'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.2'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("get_historical_stock_data") do |o|
  o.string  '-t', '--ticker=symbol',  'Ticker Symbol'
  o.bool    '-f', '--full_history',   'Retrieve Full History',   default: false
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
  end_date    = Date.yesterday
  start_date  = end_date - days

  a_url = <<~ENDURL
    http://quotes.wsj.com/#{ticker_symbol.upcase}/historical-prices/download?
    MOD_VIEW=page
    &num_rows=6299.041666666667
    &range_days=6299.041666666667
    &startDate=#{start_date.strftime("%m/%d/%Y")}
    &endDate=#{end_date.strftime("%m/%d/%Y")}
  ENDURL

  return a_url.gsub("\n",'')
end


def get_csv_from(a_url)
  Faraday.new(a_url) { |b|
    b.use FaradayMiddleware::FollowRedirects
    b.adapter :net_http
  }.get.body.gsub(' ','')
end


def get_array_of_hash(an_array)
  headers = an_array.shift.map!{|key| key.downcase }
  an_array
    .map{|row| headers.zip(row).to_h.merge('ticker' => configatron.ticker.upcase)}
    .map{|a_hash| normalize_hash(a_hash)}
end


def normalize_hash(a_hash)
  integer_keys  = %w[ volume ]
  float_keys    = %w[ open high low close ]

  integer_keys.each {|key| a_hash[key] = Integer(a_hash[key])}
  float_keys.each   {|key| a_hash[key] = Float(a_hash[key])}

  a_hash['date'] = Date.strptime(a_hash['date'], '%m/%d/%y')

  return a_hash
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?


csv_hash = get_array_of_hash(
  CSV.parse(
    get_csv_from(
      full_history? ? full_url_for(configatron.ticker) : update_url_for(configatron.ticker)
    )
  )
)

debug_me {[ "csv_hash" ]}
