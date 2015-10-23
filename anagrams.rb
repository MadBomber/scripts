#!/usr/bin/env ruby

if ARGV.empty?
  STDERR.puts
  STDERR.puts 'ERROR: This program needs some words as a parameter.'
  STDERR.puts
  exit
end


table = Hash.new { |h,k|
  h[k] = []
}

anagrams = Hash.new { |h,k|
  h[k] = []
}


IO.foreach("/usr/share/dict/words") do |line|
  word = line.chomp
  key  = word.downcase.chars.sort.join
  table[key] << word
end

words    = ARGV.map{|w| w.downcase}

max_word_length = 0
words.each do |word|
  max_word_length = word.length if word.length > max_word_length
  anagrams[word] = table[word.chars.sort.join]
end

#anagrams.map!(&:downcase)

#anagrams.delete(word)

anagrams.each_pair do |k,v|
  puts "#{k} #{'.'*(max_word_length-k.size+3)} #{v.join(', ')}"
end
