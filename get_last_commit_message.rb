#!/usr/bin/env ruby
# ~/scripts/get_last_commot_message.rb

require 'word_wrap'

raw_commit_text = `git show`.split("\n")[3..]
commit_text = ""

raw_commit_text.each do |a_line|
  break if a_line.start_with?("diff --git")
  commit_text += a_line.gsub(/^    /, '') + "\n"
end

wrapped_text = WordWrap.ww(%Q[#{commit_text}], 72, false)

puts wrapped_text
