#!/usr/bin/env ruby
###################################################
###
##  File: docx_style_lister.rb
##  Desc: Displays the paragraph style names of an MS Word *.docx file
#

require 'pp'
require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pathname'       # STDLIB

require 'docx'           # a ruby library/gem for interacting with .docx files
require 'docx_helpers'
include DocxHelpers



me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s


$options  = {
  verbose:    false,
  recursive:  false,
  quite:      false
}

def verbose?
  $options[:verbose]
end

def recursive?
  $options[:recursive]
end

def quite?
  $options[:quite]
end

usage = <<EOS

List the paragraph and character styles used by MS Word documents.

Usage: #{my_name} [options] (file|directory)+

Where:

  options           are optional (default is to just list non-compliant filenames)
    -h --help       displays this usage message
    -v --verbose    provides a detailed listing of the style names used
    -q --quite      surpress warnings
    -R --recursive  process sub-directories of a given directory

  (file|directory)+ one or more file or directory names

Limitations:

  File and Directory names
    * can not start with the '-' character
    * have space characters escaped or have the entire name
      enclosed in quotes

EOS

# Check command line for Problems with Parameters
errors = []

if  ARGV.empty?             ||
    ARGV.include?('-h')     ||
    ARGV.include?('--help')
  puts usage
  exit
end

%w[ -v --verbose ].each do |param|
  if ARGV.include? param
    $options[:verbose] = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

%w[ -q --quite ].each do |param|
  if ARGV.include? param
    $options[:quite] = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

%w[ -R --recursive ].each do |param|
  if ARGV.include? param
    $options[:recursive] = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

ARGV.compact!




ARGV.each do |param|
  errors << "does not exist: #{param}" unless File.exists?(param)
end



unless errors.empty?
  puts
  puts "Correct the following errors and try again:"
  puts
  errors.each do |e|
    puts "\t#{e}"
  end
  puts
  exit(1)
end



########################################################
## Hack around MS Word unique style ID naming convention
## Style names of 'Cover Title' and 'CoverTitle' will produce
## Style IDs of 'CoverTitle0' and 'CoverTitle1'
## Valid Upper Room style names have no spaces.

class String
  def last
    unless self.empty?
      self[self.length-1]
    else
      self
    end
  end
  def digit?
    1 == self.length and "0123456789".include?(self)
  end
end


#######################################################
## do the work on a file

def process_a_file(given_document)

  unless '.docx' == given_document.extname.downcase
    unless quite?
      STDERR.puts
      STDERR.puts "WARNING: Not a *.docx file -- skipping."
      STDERR.puts "   File: #{given_document}"
      STDERR.puts
    end
    return
  end

  d = Docx::Document.open(given_document.to_s)

  if verbose?
    puts
    puts "MS Word (docx) File Name:  #{given_document}"
    puts "Style Names Extracted on: #{Time.now}"
    puts "-"*(30+given_document.to_s.length)
    puts
  end

  paragraph_styles  = []
  character_styles  = []

  d.paragraphs.each do |para|
    paragraph_styles  << get_paragraph_style_name(para)
    character_styles  << get_character_styles(para)
  end

  paragraph_styles.flatten!
  paragraph_styles.uniq!
  character_styles.flatten!
  character_styles.uniq!

  debug_me {[ :paragraph_styles, :character_styles ]}


  unless paragraph_styles.empty?
    paragraph_styles.collect! {|ps| ps.last.digit? ? ps[0,ps.length-1] : ps }
  end

  unless character_styles.empty?
    character_styles.collect! {|cs| cs.last.digit? ? cs[0,cs.length-1] : cs }
  end

  bad_style_names   = []
  # bad_style_names   += paragraph_styles - $approved_paragraph_style_names
  # bad_style_names   += character_styles - $approved_character_style_names

  if verbose?
    print "Paragraph Style Names Used:\n\n"
    puts paragraph_styles.join("\n") unless paragraph_styles.empty?

    print "\nCharacter Style Names Used:\n\n"
    puts character_styles.join("\n") unless character_styles.empty?

    print "\nNon-compliant Style Names Used:\n\n"
    puts bad_style_names.join("\n")

    puts
  else
    unless bad_style_names.empty?
      puts "#{given_document}\t(#{bad_style_names.join(', ')})"
    end
  end

end   #   def process_a_file(given_document)


########################################################
## do a directory full of files

def process_a_directory(this_param)

  this_param.children.each do |a_child|
    if a_child.file?
      process_a_file(a_child)
    else
      process_a_directory(a_child) if recursive?
    end
  end

end # def process_a_directory(this_param)


######################################################################
## Main Loop around the ARGV which should contain only file names

ARGV.each do |param|

  this_param = Pathname.new(param)

  if this_param.file?
    process_a_file(this_param)
  else
    process_a_directory(this_param)   # do the a first level directory
  end   # unless given_document.directory?

end # end of ARGV.each do |param|
