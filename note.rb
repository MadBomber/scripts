#!/usr/bin/env ruby

require 'clipboard'
require 'pathname'

NOTES_FILENAME  = "_notes.txt"
notes_dir       = Pathname.pwd
HOME_PATH       = Pathname.new ENV['HOME']

# NOTE: recursive go up the current working directory path looking
#       for a notes file.  Stop at the $HOME directory; create one
#       there or use an existing one.
def get_relevant_notes_file(a_path)
  if a_path.children.include?(a_path + NOTES_FILENAME)
    return a_path + NOTES_FILENAME
  else
    if a_path == HOME_PATH
      return HOME_PATH + NOTES_FILENAME
    else
      return get_relevant_notes_file a_path.parent
    end
  end
end

notes_file = get_relevant_notes_file Pathname.pwd

File.open(notes_file, "a") do |f|
  f.print "\n--- #{Time.now}\n"
  f.print "\t#{ARGV.join(' ')}\n\n" unless ARGV.empty?  # .join(' ')
  f.print "\t" + Clipboard.paste.split("\n").join("\n\t")
  f.print "\n\t"*3
end

system "#{ENV['EDITOR']} #{notes_file} &" if ARGV.empty?  &&  !ENV['EDITOR'].nil?

