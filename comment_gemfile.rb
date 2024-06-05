#!/usr/bin/env ruby
##########################################
###
##  File: comment_gemfile
##  Desc: Build gem install command
##
#

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pathname'       # STDLIB

class NilClass
  def split(*args)  = [" "]
  def strip         = ""
  def to_s          = ""
end

$gem_hash = Hash.new

Gem::Specification.all.each do |gs|
  $gem_hash[gs.name] = gs.summary
end

def gem(*args)
  $gem_hash[args.first].to_s
end

last_desc_start_col = 30  # Pick an acceptable starting place


if ARGV.empty?
  gemfile_path = Pathname.pwd
else
  gemfile_path = Pathname.new ARGV.first
end

gemfile = gemfile_path.directory? ? gemfile_path + 'Gemfile' : gemfile_path
gemfile = (gemfile_path + 'gems.rb') unless gemfile.exist?


unless gemfile.exist?
  puts
  puts "ERROR: Invalid path - 'Gemfile' or 'gems.rb' does not exist"
  puts "       #{gemfile.parent}"
  puts
  exit(1)
end

gemfile_bak = Pathname.new (gemfile.to_s + '.bak')

gemfile.rename( gemfile_bak )

GEMFILE = gemfile.open('w')

start_flags = ['# START_ADDING_COMMENTS']   # SMELL: unused
end_flags   = ['__END__', '# STOP_ADDING_COMMENTS']

process_the_line = true # once you hit the end flag, stop processing

gemfile_bak.readlines.each do |a_line|
  process_the_line = false if end_flags.any? {|flag| a_line.start_with? flag}

  if process_the_line
    if a_line.include?('#')
      # don't document something that is already documented
      GEMFILE.puts a_line.chomp
      last_desc_start_col = a_line.index('#')
      next
    end

    a_line.chomp!

    if a_line.strip.start_with? 'gem'

      summary     = eval(a_line)

      unless summary.empty?

        sz          = a_line.length
        spacer_cnt  = last_desc_start_col - sz

        if spacer_cnt <= 0
          spacer_cnt          = 2               # number of spaces past end of current line
          last_desc_start_col = sz + spacer_cnt
        end

        a_line += (" "*spacer_cnt) + "# #{summary}"

      end

    end
  end # if process_the_line

  GEMFILE.puts a_line

end # of gemfile.readlines.each do |a_line|


GEMFILE.close




