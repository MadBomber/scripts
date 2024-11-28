#!/usr/bin/env ruby
# ~/scripts/headlines.rb

require 'alphavantage'

Alphavantage.configure do |config|
  config.api_key = ENV['ALPHAVANTAGE_API_KEY']
end


client = Alphavantage::Client.new 
stock = client.stock symbol: 'AAPL'
news = stock.news
puts news.headlines
