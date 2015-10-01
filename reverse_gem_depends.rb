#!/usr/bin/env ruby

# TODO: turn this into a cli tool
abort "Not ready"

require 'net/http'
require 'json'

gem_name = "debug_me"

def rubygems_get(gem_name: "", endpoint: "")
  path = File.join("/api/v1/gems/", gem_name, endpoint).chomp("/") + ".json"
  JSON.parse(Net::HTTP.get("rubygems.org", path))
end

results = rubygems_get(gem_name: gem_name, endpoint: "reverse_dependencies")

weighted_results = {}
results.each do |name|
  begin
    weighted_results[name] = rubygems_get(gem_name: name)["downloads"]
  rescue => e
    puts "#{name} #{e.message}"
  end
end

weighted_results.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }.first(50).each_with_index do |(k, v), i|
  puts "#{i}) #{k}: #{v}"
end
