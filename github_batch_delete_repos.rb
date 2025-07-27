#!/usr/bin/env ruby
# ~/scripts/batch_delete_repos.rb

require 'debug_me'
include DebugMe

def usage
  puts
  puts "Usage: batch_delete_repos.rb path/to/file"
  puts
  exit 1
end

require 'octokit'
require 'pathname'
require 'json'

if ARGV.size != 1
  usage
end

filepath = Pathname.new(ARGV[0])

# Ensure JSON is used for serialization
Sawyer::Agent.serializer = Sawyer::Serializer.new(JSON)

# Configure your GitHub personal access token
ACCESS_TOKEN = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']

# List of repositories to delete (format: 'username/repo_name')
repos = filepath.readlines.map { |line| line.split('#')[0].strip }

debug_me{[
  :repos
]}

# Initialize the Octokit client
client = Octokit::Client.new(access_token: ACCESS_TOKEN)

# Iterate through the list of repositories and delete them
repos.each do |repo|
  puts "Attempting to delete repository: #{repo}"
  client.delete_repository(repo)
  puts "Successfully deleted repository: #{repo}"
rescue Octokit::NotFound
  puts "Error: Repository #{repo} not found or you lack permission to delete it."
rescue Octokit::Error => e
  puts "Error deleting repository #{repo}: #{e.message}"
end

puts 'Batch deletion process completed.'
