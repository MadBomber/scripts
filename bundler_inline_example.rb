#!/usr/bin/env ruby
# bundler_inline_example.rb

require 'bundler/inline'

print "Installing gems as necessary ... "
gemfile do
    source 'https://rubygems.org'
    gem 'json', require: false
    gem 'nap', require: 'rest'
    gem 'cocoapods', '~> 0.34.1'
end

puts 'done'
puts "The nap gem is at version #{REST::VERSION}"
