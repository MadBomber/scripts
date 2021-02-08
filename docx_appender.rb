#!/usr/bin/env ruby
##########################################################
###
##  File: docx_appender.rb
##  Desc: Appends a list of docx files into one docx file
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pp'
require 'pathname'       # STDLIB
require 'fileutils'      # STDLIB

require 'docx'           # a ruby library/gem for interacting with .docx files
require 'docx_helpers'
include DocxHelpers

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options  = {
  verbose:      false,
  debug:        false,
  file_sep:     false,
  no_blanks:    false,
  publication:  :ddg,
  docx_files:   []
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end

def file_sep?
  $options[:file_sep]
end

def remove_blanks?
  $options[:no_blanks]
end

usage = <<EOS

Appends a list of docx files into one docx file

Usage: #{my_name} [options] docx_files|directory

Where:

  options               Do This
  -h or --help          Display this message
  -v or --verbose       Display progress
        --no-sep        Do not add the 'FileName:' seperater paragraph
        --no-blanks     Do not copy empty paragraphs

  docx_files|directory  List of *.docx files
                        or a single directory

NOTE:

  The output docx file will be automatically named for
  the parent directory of the first file in the list.

LIMITATION:

  The style definitions, bookmarks, references, etc. are not
  transfered into the new document.  If a paragraph style was
  not defined in the first document, then those paragraphs in
  subsequent documents will be treated as Normal.

EOS

errors = []

if  ARGV.empty?             or
    ARGV.include? '-h'      or
    ARGV.include?'--help'
  puts usage
  exit
end

%w[ -v --verbose ].each do |param|
  if ARGV.include?(param)
    $options[:verbose] = true
    i = ARGV.index param
    ARGV[i] = nil
  end
end

if ARGV.include?('--no-sep')
  $options[:file_sep] = false
  i = ARGV.index '--no-sep'
  ARGV[i] = nil
end

if ARGV.include?('--no-blanks')
  $options[:no_blanks] = false
  i = ARGV.index '--no-blanks'
  ARGV[i] = nil
end

ARGV.compact!

if ARGV.empty?
  puts usage
  exit
end


if 1 == ARGV.size
  source_directory = Pathname.new ARGV.first
  if source_directory.exist?
    source_directory = source_directory.realpath
    $options[:docx_files] = source_directory.children
    source_directory.children.each do |c|
      if  c.file?  and
          '.docx' == c.extname.downcase
        $options[:docx_files] << c unless c.basename.to_s.downcase.start_with?('backup')
      end
    end
    errors << "There are no *.docx files in #{source_directory.basename}" if $options[:docx_files].empty?
  else
    errors << "directory is invalid: #{source_directory}"
  end
else
  $options[:docx_files] = ARGV.map { |a| Pathname.new(a)}
end

$options[:docx_files].each do | a_path |
  unless a_path.exist?
    errors << "Does not exist: #{a_path}"
  else
    if a_path.directory?
      errors << "Not a file: #{a_path}"
    else
      unless '.docx' == a_path.extname.downcase
        errors << "Not an MS Word *.docx: #{a_path}"
      end
    end
  end
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

$options[:docx_files].map! {|a_path| a_path.realpath}

#FIXME: not using pub_styles_path
pub_styles_path   = my_dir +
                      "docx_templates" +
                      $options[:publication].to_s.upcase +
                      "#{$options[:publication]}_styles.docx"


ap pub_styles_path if debug?

######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

$options[:docx_files].sort!

ap $options if debug?

out_dir       = $options[:docx_files].first.parent
docx_out_path = out_dir + "#{out_dir.basename}.docx"

FileUtils.cp(pub_styles_path, docx_out_path)  # SMELL: don't think the styles are coming from here


sleep(5) if debug?


docx_out = Docx::Document.open($options[:docx_files].first)  # SMELL: all styles from here ??

# Do the first file to get the proper styles established

# FIXME: this doesn't work; its not using the correct starting out file
if file_sep?
  para = docx_out.paragraphs.first.copy
  para.insert_after docx_out.paragraphs.first
  set_paragraph_style_name(docx_out.paragraphs.first, 'FileName')
  docx_out.paragraphs.first.text = "FileName: #{$options[:docx_files].first.basename}"
end

$options[:docx_files].shift

# Do the rest of the files

$options[:docx_files].each do |c|

  next if c == docx_out_path

  puts "Appending #{c.basename} ..." if verbose?
  docx = Docx::Document.open(c)

  if file_sep?
    para = docx.paragraphs.first.copy
    set_paragraph_style_name(para, 'FileName')
    para.text = "FileName: #{c.basename}"
    para.insert_after docx_out.paragraphs.last
  else
    para = docx.paragraphs.first.copy
    para.text = "  "
    para.insert_after docx_out.paragraphs.last
  end

  docx.paragraphs.size.times do |x|
    para = docx.paragraphs[x].copy
    if remove_blanks?
      a_text = para.text.chomp.strip
      next if a_text.empty?
    end
    para.insert_after docx_out.paragraphs.last
  end

end

docx_out.save(docx_out_path)


