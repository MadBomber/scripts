#!/usr/bin/env ruby
# ~/scripts/headlines.rb
#
# Print recent news headlines for a ticker symbol using the
# Alpha Vantage NEWS_SENTIMENT API.
#
# Usage: headlines.rb [ticker]   (default: AAPL)
# Uses:  ENV['ALPHAVANTAGE_API_KEY']

require 'json'      # STDLIB
require 'net/http'  # STDLIB
require 'uri'       # STDLIB

ALPHA_VANTAGE_URL = 'https://www.alphavantage.co/query'

def news_url(ticker, api_key)
  uri       = URI(ALPHA_VANTAGE_URL)
  uri.query = URI.encode_www_form(
    function: 'NEWS_SENTIMENT',
    tickers:  ticker.upcase,
    apikey:   api_key
  )
  uri
end

def headlines_from(json_text)
  data = JSON.parse(json_text)
  abort "Alpha Vantage: #{data['Information'] || data['Note'] || data['Error Message']}" unless data.key?('feed')

  data['feed'].map { it['title'] }
end

ticker  = ARGV.first || 'AAPL'
api_key = ENV.fetch('ALPHAVANTAGE_API_KEY') { abort 'ALPHAVANTAGE_API_KEY is not set' }

puts headlines_from(Net::HTTP.get(news_url(ticker, api_key)))
