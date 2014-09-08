#!/bin/env ruby

require 'systemu'
require 'pp'
require 'json'

s_added   = 'curl "https://rubygems.org/api/v1/activity/latest.json"'
s_updated = 'curl "https://rubygems.org/api/v1/activity/just_updated.json"'

puts
puts "fetching NEW gems using #{s_added}"

a,b,c=systemu s_added

j = JSON.parse( b )

j.select! {|gem| gem unless '0' == gem['version'][0] }

puts "Found #{j.length} new gems worth taking a look."
puts

#pp j

puts "fetching UPDATED gems using #{s_updated}"

a,b,c=systemu s_updated

j2 = JSON.parse( b )

puts "Found #{j2.length} updated gems."
puts


[j,j2].flatten.each do | gem |

  puts "\n#{gem['name']} v#{gem['version']} - #{gem['info']}"
  home  = gem["homepage_uri"]
  doc   = gem["documentation_uri"]
  src   = gem["source_code_uri"]
  
  puts "Home: #{home}"  unless home.nil? or home.empty?
  puts "Src:  #{src}"   unless src.nil?  or src.empty?
  puts "Doc:  #{doc}"   unless doc.nil?  or doc.empty?

end

puts

