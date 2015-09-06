#!/usr/bin/env ruby
##########################################################
###
##  File: docx_breakup.rb
##  Desc: Breaks up a single docx file into a directory of
##        smaller docx files based upon paragraphs that
##        start with 'FileName:'
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'
require 'pp'
require 'pathname'
require 'fileutils'

require 'docx'

require 'docx_helpers'
include DocxHelpers

$options  = {
  verbose:        false,
  out_directory:  nil
}

def verbose?
  $options[:verbose]
end

pgm_name = Pathname.new(__FILE__).basename

usage = <<EOS

Breaks up a single docx file into a directory of
smaller docx files based upon paragraphs that
start with 'FileName:'

Usage: #{pgm_name} [options] docx_file

Where:

  options               Do This
  -h or --help          Display this message
  -v or --verbose       Display progress

  -o out_directory      The directory into which the docx
                        files are to be placed.
                        Default: same directory as docx_file

  docx_file             Path to the large docx file that
                        is to be broken apart into smaller
                        files.

EOS

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

if ARGV.include?('-o')
  inx = ARGV.index '-o'
  if (inx+1) >= ARGV.size
    errors << "No output directory was specified"
  else
    $options[:out_directory] = Pathname.new(ARGV[inx+1])
    ARGV[inx+1] = nil
    unless $options[:out_directory].exist?
      errors << "Output directory does not exist: #{$options[:out_directory]}"
    else
      unless $options[:out_directory].directory?
        errors << "Output directory is not a directory: #{$options[:out_directory]}"
      end
    end
  end
  ARGV[inx] = nil
end

ARGV.compact!

unless 1 == ARGV.length
  puts usage
  exit
end

docx_in_path = Pathname.new(ARGV.first)

# Check command line for Problems with required Parameters

if docx_in_path.exist?
  docx_in_path = docx_in_path.realpath
else
  errors << "docx_file does not exist: #{docx_in_path}"
end

if docx_in_path.file?
  unless '.docx' == docx_in_path.extname.downcase
    errors << "docx_file is not a *.docx file: #{docx_in_path}"
  end
else
  errors << "docx_file is not a file: #{docx_in_path}"
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


if $options[:out_directory].nil?
  $options[:out_directory] = docx_in_path.parent
end

ddg_templates = Pathname.new(__FILE__).parent + "docx_templates" + "DDG"

ddg_styles_path = ddg_templates + "ddg_styles.docx"


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end


in_docx = Docx::Document.open(docx_in_path)

# 2 dimensional
out_paths = Array.new  # [path, (start..stop)] where start,stop and paragraph numbers in in_docx

building_filename = ""
para_index        = 0
start_index       = 0   # paragraph with 'FileName:'
stop_index        = 0   # paragraph before the one with 'FileName:'

# Locate all of the start and stop paragraphs indexes for each file

print "Finding file markers "  if verbose?

in_docx.paragraphs.each do |para|

  in_text = para.text

  if in_text.start_with?('FileName:')

    unless building_filename.empty?
      print "."  if verbose?
      out_paths << [
        $options[:out_directory] + building_filename,
        (start_index..para_index - 1)  # NOTE: stop before the FileName: paragraph
      ]
    end

    # Start New out file
    building_filename = in_text.split(':')[1].strip
    start_index       = para_index + 1  # NOTE: Do not extract the FileName: paragraph

    # TODO: ensure extname == '.docx'

  end # if in_text.start_with?('FileName:')

  para_index += 1

end # in_docx.paragraphs.each do |para|

out_paths << [
  $options[:out_directory] + building_filename,
  (start_index..para_index-1)
]

puts " done." if verbose?


out_paths.each do | file_entry |

  out_path    = file_entry[0]
  para_range  = file_entry[1]

  print "Writing #{out_path.basename} #{para_range} "  if verbose?


  # FIXME: out_docx_path references an existing document that
  #        has all the styles needed.  Need to take those stiles
  #        from the big document.
  out_docx = Docx::Document.open(out_docx_path)

  para_range.each do |x|
    para = in_docx.paragraphs[x].copy
    para.insert_after(out_docx.paragraphs.last)
    print '.' if verbose?
  end

  if out_path.exist?
    print " DUPLICATE " if verbose?
    while out_path.exist? do
      opp   = out_path.parent
      ope   = out_path.extname
      opbt  = out_path.basename.to_s[0..-ope.length-1] # get stuff in from of extname
      unless "0123456789".include?(opbt[opbt.length-1])
        opbt += '2'
      else
        opbt = opbt[0..-2] + sprintf("%d",opbt[opbt.length-1].to_i + 1)
      end
      out_path = opp + (opbt + ope)
    end
  end

  out_docx.save(out_path)

  puts " done." if verbose?

end

