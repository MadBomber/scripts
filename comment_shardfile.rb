#!/usr/bin/env ruby
##########################################
###
##  File: comment_shardfile.rb
##  Desc: Do things to the "shard.yml" file
##
#
GITHUB_API_TOKEN  = ENV['HOMEBREW_GITHUB_API_TOKEN']
SHARD_FILENAME    = 'shard.yml'

puts "processing #{SHARD_FILENAME} ..."

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'github_api'

GITHUB = Github.new( oauth_token: GITHUB_API_TOKEN)


require 'pathname'       # STDLIB
require 'yaml'


# TODO:  Add cli_helper and some command line options.
def normalize?
  true
end

$shard_hash = Hash.new

last_desc_start_col = 30  # Pick an acceptable starting place


if ARGV.empty?
  shardfile_path = Pathname.pwd
else
  shardfile_path = Pathname.new ARGV.first
end

shardfile = shardfile_path.directory? ? shardfile_path + SHARD_FILENAME : shardfile_path


unless shardfile.exist?
  puts
  puts "ERROR: Invalid path - '#{SHARD_FILENAME}' does not exist"
  puts "       #{shardfile.parent}"
  puts
  exit(1)
end

shardfile_bak = Pathname.new (shardfile.to_s + '.bak')

shardfile.rename( shardfile_bak )

SHARDFILE = shardfile.open('w')


# TODO: process the file as a YAML file instead of simple text.

lines = shardfile_bak.read.split("\n")

lines.each do |a_line|

  if a_line.include?("\t")
    STDERR.puts "ERROR: Found a tab ..."
    STDERR.puts a_line
  end

  if a_line.include?('#')
    # don't document something that is already documented
    SHARDFILE.puts a_line.chomp
    last_desc_start_col = a_line.index('#')
    next
  end

  if normalize?
    # if github: entry exists convert it to a plain git: entry
    # and add a "desc:" element to the shard
    if a_line.strip.start_with? 'github'
      repo  = a_line.split(':')[1].strip
      repo  = repo.gsub(/\.git$/,'') if repo.end_with?('.git')

      repo_account, repo_name = repo.split('/')

      begin
        desc  = GITHUB.repos.get(repo_account, repo_name)['description']
      rescue Exception => e
        STDERR.puts "ERROR: #{e}"
        STDERR.puts "while processing #{repo}"
        desc = "unknown"
      end

      desc = "unknown" if desc.nil?

      puts "#{repo_account}/#{repo_name} #{desc}"

      link  = "https://github.com/#{repo}"

      a_line.gsub!('github', 'git')
      a_line.gsub!(repo, link)

      # TOdO: what if there is already a "desc:" element?
      a_line += "\n    desc: '" + desc.gsub("'","") + "'"
    end
  end # if normalize?

  SHARDFILE.puts a_line
end # lines.each do |a_line|

SHARDFILE.close
