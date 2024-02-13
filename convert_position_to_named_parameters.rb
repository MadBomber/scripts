#!/usr/bin/env ruby
# ~/scripts/convert_positional_to_named_parameters.rb
#
# Usage: run it with a ruby source file as a parameter
#   redirect STDOUT to a temp.rb file
#   then run rubocop temp,rb to reformat the file.

require 'pathname'

source_file = ARGV[0]
unless source_file
  puts "Usage: ruby transform_methods.rb <source_file>"
  exit 1
end

lines = Pathname.new(source_file).readlines.map(&:strip)

lines.each do |a_line|
  if a_line.start_with? 'def '
    unless a_line.include? ':'
      a_line.gsub!(',', ':,')
      a_line.gsub!(' = ', ': ')
      a_line.gsub!(': nil:,', ': nil,')
    end
  end

  puts a_line
end
