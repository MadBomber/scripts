#!/usr/bin/env ruby
##########################################################
###
##  File: wcml_brf.rb
##  Desc: Finds valid bible references in text
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'
require 'pp'

require 'pathname'
require 'pathname_helpers'

require 'bible_gateway'
require 'pericope'

require 'nokogiri'
require 'wcml_helpers'
include WcmlHelpers

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  wcml_paths:     []
}

def verbose?
  $options[:verbose]
end

usage = <<EOS

Finds valid bible references in Adobe InCopy *.wcml files

Usage: #{my_name} [options] wcml_files

Where:

  options               Do This
  -h or --help          Display this message
  -v or --verbose       Display progress

  wcml_files            List of *.wcml files

EOS

# Check command line for Problems with Parameters
errors = []

if  ARGV.empty?              ||
    ARGV.include?('-h')      ||
    ARGV.include?('--help')
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

  $options[:wcml_paths] = ARGV.map {|a| Pathname.new(a)}

  $options[:wcml_paths].each do | dp |
    unless dp.exist?
      errors << "File does not exist: #{dp.basename}"
    else
      unless '.wcml' == dp.extname.downcase
        errors << "File is not *.wcml: #{dp.basename}"
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

$options[:wcml_paths] = ARGV.map {|a| Pathname.new(a).realpath}

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

$options[:wcml_paths].each do | dp |

  puts "Reviewing #{dp.basename} ..." if verbose?

  wcml = open_wcml(dp)

  bible_references = []

  get_stories(wcml).each do | a_story |
    next unless [ 'IgnoreThisStoryTitle', 'ThisOneAlso'].include?(get_story_title(a_story))
    pc = Pericope.parse(get_text(a_story))
    unless pc.empty?
      pc.each do |r|
        print "#{dp.basename}"
        print "\t#{get_story_title(a_story)}"
        puts "\t#{r}"
        bible_references << r.ranges.map {|a_range| a_range.to_a}
      end # pc.each do |r|
    end # unless pc.empty?

  end # get_stories(wcml).each do | a_story |

  print "#{dp.basename} BibleReferences: "
  puts bible_references.flatten.sort.uniq.join(',')

end # $options[:docx_paths].each do | dp |



__END__

body_text.each do |a_line|
  puts a_line

  pc = Pericope.parse(a_line)
  pc.each do |r|
    puts "*** Found: #{r}"
  end unless pc.empty?

end

