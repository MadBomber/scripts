#!/usr/bin/env ruby
# de_dog_da_log.rb
# removes the datadog junk in front of a JSON log
#
# intended to front a jq process
# brew install jq

target = '{"host"'

File.open(ARGV[0], 'r').read.split("\n").each do |a_line|
  x = a_line.index(target)
  next if x.nil?; puts a_line[x..]
end

__END__

Usage Example:

de_dog_da_log.rb ~/Downloads/30lines.log | \
  jq -r '.timestamp + " " + .level + " " + .name + " " + .message'
