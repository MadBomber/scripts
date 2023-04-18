#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: convert_vcr_response_to_fixture.rb
##  Desc: Change a VCR cassette response into a fixture
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'pathname'

SPEC_DIR      = Pathname.new(__dir__)
FIXTURES_DIR  = SPEC_DIR + "fixtures"
CASSETTE_DIR  = SPEC_DIR + "vcr_cassettes"

require 'bundler/inline'

print "Installing gems as necessary ... "
gemfile do
  source 'https://rubygems.org'
  # gem 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
  gem 'multi_json'
  gem 'yaml'
end
puts "done."



def pretty_print_json(text)
  hash = MultiJson.load( text )
  MultiJson.dump( hash, {pretty: true}  )
end


###################################################
## Main
#
# breath first directory/sub-directory processing ...

sub_directories = [CASSETTE_DIR]

sub_directories.each do |cassette_dir|
  cassette_dir.children.each do |cassette|
    if cassette.directory?
      sub_directories << cassette 
      next
    end

    next unless '.yml' == cassette.extname

    filename_yml  = cassette.basename.to_s
    yaml_hash     = YAML.load(cassette.read)

    next unless yaml_hash.is_a? Hash
    next unless yaml_hash.has_key? "http_interactions"

    # Some VCR cassettes have multiple request/response pairs

    yaml_hash["http_interactions"].each_with_index do |entry, inx|
      if 0 == inx
        filename_json = filename_yml.gsub('.yml', '.json')
      else
        filename_json = filename_yml.gsub('.yml', "_#{inx}.json")
      end
    
      json_response_text = entry.dig('response', 'body', 'string')

      next if json_response_text.chomp.strip.empty?

      source_dir  = cassette_dir.to_s
      target_dir  = Pathname.new source_dir.gsub(CASSETTE_DIR.to_s,FIXTURES_DIR.to_s)

      json_path   = target_dir + filename_json
      json_path.write pretty_print_json(json_response_text)
    end
  end
end 
