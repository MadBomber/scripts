#!/usr/bin/env ruby

require 'rubygems'

# Fetch the list of installed gems
installed_gems = Gem::Specification.sort_by { |gem| gem.name }

# Print the Markdown table header
puts "| Gem Name | Version | Description |"
puts "| --- | --- | --- |"

# Iterate over each gem and print its details in Markdown table format
installed_gems.each do |gem|
  gem_name    = gem.name
  version     = gem.version.to_s
  description = gem.summary || gem.description
  
  description.gsub!(/\R/, ' ') # Replace newlines with spaces
  description.gsub!(/\|/, '\|') # Escape pipe characters in Markdown 

  puts "| #{gem_name} | #{version} | #{description} |"
end

