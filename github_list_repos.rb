#!/usr/bin/env ruby
# ~/scripts/batch_;ost_repos.rb

require 'debug_me'
include DebugMe

class NilClass
  def to_s
    ''
  end
end

require 'net/http'
require 'json'
require 'uri'

# Get GitHub Personal Access Token from environment
token = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']
unless token
  puts "Error: GITHUB_PERSONAL_ACCESS_TOKEN environment variable not set"
  exit 1
end

# Set the user whose repositories you want to list
user = 'MadBomber'

# Make direct API call to GitHub
uri = URI("https://api.github.com/users/#{user}/repos?per_page=100")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri)
request['Authorization'] = "token #{token}"
request['User-Agent'] = 'Ruby GitHub Repo Lister'

response = http.request(request)

if response.code == '200'
  repos = JSON.parse(response.body)
  # debug_me{[
  #   'repos.first.keys'
  # ]}
  repos.each do |repo|
    puts user + '/' + repo['name'] + "\t\t# " + repo['description'].to_s
  end
else
  puts "Error: #{response.code} - #{response.message}"
  puts response.body
end
