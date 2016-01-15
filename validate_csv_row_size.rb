#!/usr/bin/env ruby

if ARGV.empty?          ||
   ARGV.include?('-h')  ||
   ARGV.include?('--help')
puts <<-EOS

Validates the size of every record of a CSV file 
based on the size of the first record.

  Usage: #{__FILE__.split('/').last} filename.csv

EOS
exit
end


require 'csv'
require 'debug_me'
include DebugMe

the_size  = 0
row_count = 0

CSV.foreach(ARGV.first, quote_char: '"', col_sep: ',', row_sep: :auto, headers: false) do |row|
  row_count += 1
  if the_size == 0
    the_size = row.size 
    puts "The first row's size: #{the_size}"
    debug_me('First Row Content'){[ :row ]}
    next
  end
  unless row.size == the_size
    puts "Row Number: #{row_count} has invalid size: #{row.size}" 
  end
end

