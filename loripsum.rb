#!/usr/bin/env ruby
# This is the main file from the loripsum-client gem version 0.1
# It extracts text from the loripsum.net website

require 'rest-client'
require 'optparse'


module Loripsum

  class OptionsParser
    LENGTHS = %w(short medium long verylong)

    def self.parse!
      options = {}

      options[:plaintext] = false
      options[:prude]     = false
      options[:allcaps]   = false
      options[:headers]   = false
      options[:code]      = false
      options[:bq]        = false
      options[:dl]        = false
      options[:ul]        = false
      options[:ol]        = false
      options[:decorate]  = false
      options[:link]      = false

      OptionParser.new do |opts|
        opts.banner = "Usage: loripsum.rb [options]"

        opts.on("-n", "--number [NUMBER]", Integer, "The number of paragraphs to generate") do |number|
          options[:number] = number
        end

        opts.on("-l", "--length [LENGTH]", String, "The average length of a paragraph") do |length|
          unless LENGTHS.include?(length)
            raise("#{length} was not valid length. Expected one of the following: #{LENGTHS}")
          end
          options[:length] = length
        end

        opts.on("-p", "--decorate", "Add bold, italic, and marked text") do
          options[:decorate] = true
        end

        opts.on("-a", "--links", "Add links") do
          options[:link] = true
        end

        opts.on("-u", "--unordered-lists", "Add unordered lists") do
          options[:ul] = true
        end

        opts.on("-o", "--ordered-lists", "Add ordered lists") do
          options[:ol] = true
        end

        opts.on("-d", "--description-lists", "Add description lists") do
          options[:dl] = true
        end

        opts.on("-b", "--block-quotes", "Add blockquotes") do
          options[:bq] = true
        end

        opts.on("-c", "--code-samples", "Add code samples") do
          options[:code] = true
        end

        opts.on("-h", "--headers", "Add headers") do
          options[:headers] = true
        end

        opts.on("-C", "--all-caps", "Use ALL CAPS") do
          options[:allcaps] = true
        end

        opts.on("-s", "--prude", "Prude version") do
          options[:prude] = true
        end

        opts.on("-t", "--text", "Return plain text, no HTML") do
          options[:plaintext] = true
        end

      end.parse!
      options
    end
  end

  module Client
    BASE_URL = 'loripsum.net/api'

    def self.generate_url(options)
      url = BASE_URL
      enabled_options = options.select {|_, value| value }
      if enabled_options.include?(:number)
        url = "#{url}/#{enabled_options[:number]}"
        enabled_options.delete(:number)
      end
      if enabled_options.include?(:length)
        url = "#{url}/#{enabled_options[:length]}"
        enabled_options.delete(:length)
      end

      enabled_options.keys.each do |key|
        url = "#{url}/#{key}"
      end
      url
    end

    def self.generate
      options = OptionsParser.parse!
      if options[:headers]
        generate_with_headers(options)
      else
        url = generate_url(options)
        RestClient.get url
      end
    end

    def self.generate_with_headers(options)
      url = generate_url(options)
      result = RestClient.get url
      split = result.split("\n\n")
      {header: split[0], body: split[1, split.size]}
    end

    def self.run!
      $stdout << self.generate
    end
  end


end

Loripsum::Client.run! if __FILE__ == $0