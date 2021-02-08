#!/usr/bin/env ruby
##########################################
###
##  File: comment_require
##  Desc: Add comments to "require" statements for individual
##        *.rb file, a collection of *.rb files or all that are
##        in a directory.  Is not recursive.
##
#

USAGE = <<~EOS

  Usage: __FILE__ path_to_rb_file+

  Where:

    path_to_rb_file is one or more paths to Ruby source files

EOS

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pathname'       # STDLIB

class NilClass
  def split(*args)
    [" "]
  end
  def strip
    ""
  end
  def to_s
    ""
  end
end

STDLIBS = %w[
  abbrev
  base64 benchmark bigdecimal
  cgi cmath coverage csv
  date dbm debug delegate digest drb
  e2mmap English erb etc expect extmk
  fcntl fiddle fileutils find forwardable
  gdbm getoptlong
  io/console io/nonblock io/wait ipaddr irb
  json
  logger
  mathn matrix mkmf monitor mutex_m
  net/ftp net/http net/imap net/pop net/smtp net/telnet nkf
  objspace observer open-uri open3 openssl optparse ostruct
  pathname prettyprint prime profile profiler pstore psych pty
  racc racc/parser rake rdoc readline resolv resolv-replace rexml rinda ripper rss rubygems
  scanf sdbm securerandom set shell shellwords singleton socket stringio strscan sync syslog
  tempfile thwait time timeout tmpdir tracer tsort
  un unicode_normalize uri
  weakref webrick win32ole
  yaml
  zlib
]

GEMS = Hash.new

Gem::Specification.all.each do |gs|
  GEMS[gs.name] = gs.summary
end


def get_gem_summary(a_string)
  gem_name = a_string.
                gsub('(','').gsub(')','').
                gsub('"','').gsub("'",'')
  return 'STDLIB' if STDLIBS.include? gem_name
  if gem_name.include? '/'
    gem_name = gem_name.split('/').first
  end

  GEMS[gem_name].to_s
end

DEFAULT_START_COL   = 30

if ARGV.empty?
  STDERR.puts USAGE
  exit(-1)
else
  PATHS = ARGV.map{|path| Pathname.new(path)}
end

errors = Array.new

PATHS.each do |path|
  unless path.exist?  &&  (path.directory? || '.rb' == path.extname.downcase)
    errors << path
  end
end # PATHS.each do |path|


unless errors.empty?
  STDERR.puts "\nInvalid parameters.  Must be a path or *.rb file"
  errors.each do |path|
    STDERR.puts "\t#{path}"
  end
  STDERR.puts
  exit(-1)
end

def document_require(rbfile)
  print "#{rbfile.basename} ... "

  last_desc_start_col = DEFAULT_START_COL
  rbfile_bak          = Pathname.new (rbfile.to_s + '.bak')

  rbfile.rename( rbfile_bak )

  rb_file = rbfile.open('w')

  rbfile_bak.readlines.each do |a_line|
    if a_line.include?('#')
      # don't document something that is already documented
      rb_file.print a_line
      last_desc_start_col = a_line.index('#')
      next
    end

    a_line.chomp!

    if a_line.strip.start_with? 'require'
      parts       = a_line.split(/ |\(/)

      summary     = get_gem_summary(parts[1])

      unless summary.empty?
        sz          = a_line.length
        spacer_cnt  = last_desc_start_col - sz

        if spacer_cnt <= 0
          spacer_cnt          = 2               # number of spaces past end of current line
          last_desc_start_col = sz + spacer_cnt
        end

        a_line += (" "*spacer_cnt) + "# #{summary}"
      end # unless summary.empty?
    end # if a_line.strip.start_with? 'require'

    rb_file.puts a_line
  end # rbfile_bak.readlines.each do |a_line|

  rb_file.close
  puts "done"
end # def document_require(rbfile)


PATHS.each do |path|

  if path.directory?
    path.children.each do |rbfile|
      next unless '.rb' == rbfile.extname.downcase
      document_require(rbfile)
    end # rbfile_path.children.each do |rbfile|
  else # its a file
    document_require(path)
  end

end # PATHS.each do |path|
