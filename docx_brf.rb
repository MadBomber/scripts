#!/usr/bin/env ruby
##########################################################
###
##  File: docx_brf.rb
##  Desc: Finds valid bible references in text
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pp'

require 'pathname'       # STDLIB
require 'pathname_helpers'

require 'bible_gateway'
require 'pericope'

require 'docx'           # a ruby library/gem for interacting with .docx files
require 'docx_helpers'
include DocxHelpers

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  docx_paths:     []
}

def verbose?
  $options[:verbose]
end

usage = <<EOS

Finds valid bible references in MS Word *.docx files

Usage: #{my_name} [options] docx_files

Where:

  options               Do This
  -h or --help          Display this message
  -v or --verbose       Display progress

  docx_files            List of *.docx files

EOS

# Check command line for Problems with Parameters
errors = []

if  ARGV.empty?             or
    ARGV.include? '-h'      or
    ARGV.include?'--help'
  puts usage
  exit
end

if ARGV.include?('-v')
  $options[:verbose] = true
  i = ARGV.index '-v'
  ARGV[i] = nil
end

if ARGV.include?('--verbose')
  $options[:verbose] = true
  i = ARGV.index '--verbose'
  ARGV[i] = nil
end

ARGV.compact!

unless ARGV.empty?

  $options[:docx_paths] = ARGV.map {|a| Pathname.new(a)}

  $options[:docx_paths].each do | dp |
    unless dp.exist?
      errors << "File does not exist: #{dp.basename}"
    else
      unless '.docx' == dp.extname.downcase
        errors << "File is not *.docx: #{dp.basename}"
      else
        if dp.basename.to_s.downcase.start_with? 'backup of'
          errors << "File is a backup: #{basename}"
        end
      end
    end
  end

else

  errors << "No files were specified on the command line"

end # unless ARGV.empty?


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

$options[:docx_paths] = ARGV.map {|a| Pathname.new(a).realpath}

bible           = BibleGateway.new
bible.version   = :holman_christian_standard_bible

######################################################
# Local methods

class String
  def strip_html
    unless self.empty?
      s=''
      strip_it = false
      self.length.times do |x|
        c = self[x]
        case c
        when '<' then
          strip_it = true
        when '>' then
          strip_it = false
          s += ' '
        else
          s += c unless strip_it
        end
      end # self.each do |c|
      return s
    end # unless self.empty?
    self
  end # def strip_html
end # class String


######################################################
# Main

$options[:docx_paths].each do | dp |

  puts "Reviewing #{dp.basename} ..." if verbose?

  docx = Docx::Document.open(dp)

  docx.paragraphs.each do | a_paragraph |
    pc = Pericope.parse(a_paragraph.text)
    unless pc.empty?
      pc.each do |r|
        print "#{dp.basename}"
        print "\t#{get_paragraph_style_name(a_paragraph)}"
        print "\t#{r}"

        # NOTE: MS Excel can not handle modern character encodings
        verse_utf8 = bible.lookup(r.to_s)[:content].strip_html.gsub("\n",' ')
        #verse_ansi = Iconv.iconv("LATIN1", "UTF-8", verse_utf8).join
        verse_ansi = verse_utf8.
                        gsub('“','"'). # curly open double quote
                        gsub('”','"'). # curly close double quote
                        gsub("’","'"). # curly close single quote
                        encode(Encoding::ASCII_8BIT,
                                {   :invalid  => :replace,
                                    :undef    => :replace,
                                    :replace  => ' '
                                }
                              )

        puts "\t#{verse_ansi}"
      end
    end

  end

end # $options[:docx_paths].each do | dp |



__END__

body_text.each do |a_line|
  puts a_line

  pc = Pericope.parse(a_line)
  pc.each do |r|
    puts "*** Found: #{r}"
  end unless pc.empty?

end

