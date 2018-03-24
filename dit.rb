#!/usr/bin/env ruby

require 'pathname'

$old = Pathname.new('old.xml').read.split("\n")
$new = Pathname.new('new.xml').read.split("\n")

def diff(a, b)
  return if a == b
  c = "^" * (a.size > b.size ? a.size : b.size)
  puts a
  puts b
  c.size.times do |char_index|
    c[char_index] = ' ' if a[char_index] == b[char_index]
  end
  puts c
  puts
end


def cf(start_line=0, end_line=$old.count)
  (start_line..end_line).each do |line|
    unless  $old[line] == $new[line]
      puts "#{line} ... "
      diff( $old[line], $new[line] )
    end
  end
end

cf
