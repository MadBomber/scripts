#!/usr/bin/env ruby
# ~/scripts/bible_semantic_search.rb
# Use a vector store to search for relevant bible verses

require "net/http"
require "uri"
require "json"
require "word_wrapper"      # Pure ruby word wrapping

def fetch_bible_verses(query)
  # Prepare the URI with the encoded query
  encoded_query = URI.encode_www_form_component(query)
  uri = URI.parse("https://bible-search.antioch.tech/api/search?verse_query=#{encoded_query}")

  # Create a new HTTP request
  response = Net::HTTP.get_response(uri)

  # Check if the request was successful
  if response.is_a?(Net::HTTPSuccess)
    # Parse the JSON response
    verses = JSON.parse(response.body)
    return verses
  else
    puts "HTTP Request failed (status code: #{response.code})"
    return nil
  end
end

def usage
  puts "Usage: ruby bible_semantic_search.rb <search term>"
  puts "Search for Bible verses that relate to the provided search term."
  puts
  puts "Options:"
  puts "  -h, --help    Show this help message"
  puts
end

# Check for command-line arguments
if ARGV.empty? || ARGV.include?("-h") || ARGV.include?("--help")
  usage
  exit
end

# Get the search term from the command line argument
search_term = ARGV.join(" ")
bible_verses = fetch_bible_verses(search_term)

if bible_verses && !bible_verses.empty?
  puts "\nBible verses related to '#{search_term}':\n\n"

  bible_verses.each do |verse|
    puts
    puts WordWrapper::MinimumRaggedness.new(
      60,
      verse["verse_text"]
    ).wrap

    puts "\t\t-- #{verse["book_name"]} #{verse["chapter_number"]}:#{verse["verse_number"]} (#{verse["translation_name"]})"
  end
else
  puts "No verses found or there was an error."
end

puts
