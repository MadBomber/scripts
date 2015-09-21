#!/usr/bin/env ruby

if ARGV.empty? || ARGV.size > 1
  STDERR.puts
  STDERR.puts 'ERROR: This program news a single word as a parameter.'
  STDERR.puts
  exit
end


table = Hash.new { |h,k|
  h[k] = []
}

IO.foreach("/usr/share/dict/words") do |line|
  word = line.chomp
  key  = word.downcase.chars.sort.join
  table[key] << word
end

word     = ARGV[0].downcase
anagrams = table[word.chars.sort.join]

anagrams.map!(&:downcase)

anagrams.delete(word)

if anagrams.any?
  puts "Anagrams for '#{word}': #{anagrams.join(", ")}"
else
  puts "Sorry, no anagrams for '#{word}'"
end
