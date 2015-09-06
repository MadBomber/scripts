#!/usr/bin/env ruby
##########################################################
###
##  File: docx_rm_para_with_styles.rb
##  Desc: Remove all paragraphs with the given styles from
##        all docx files in a given directory.
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'
require 'pp'
require 'pathname'

require 'docx'
require('docx_helpers')
include DocxHelpers

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  sub_dirname:  "temp_styles_removed",
  verbose:      false,
  styles:       [],
  paths:        []
}

usage = <<EOS

Remove all paragraphs havin the given styles from
all paragraphs in a given directory

Usage: #{my_name} [options] [-s StyleName]* docx_filepaths|directories

Where:

  options               Do This
  -h or --help          Display this message
  -v or --verbose       display the paragraphs being removed
  -s or --styles        specifies a comma seperated list of
                        paragraph style name

  docx_filepaths |      space seperated list of a combination
  directories           file nad directory paths.  If a directory
                        is specified, all of the docx within the
                        directory will be processed.  There is
                        no recursion into sub-directories.

NOTE:

  The original files are not modified.  The files with the
  styles removed are stored in a sub-directory within their
  parant directory named:  #{$options[:sub_dirname]}

EOS



def verbose?
  $options[:verbose]
end

def get_style_names_after_param(param)
  i = ARGV.index param
  ARGV[i] = nil
  i += 1
  unless ARGV[i].nil?
    $options[:styles] << ARGV[i].split(',')
    ARGV[i] = nil
  else
    errors << "Style names not specified after #{param}."
  end
end

errors = []

if  ARGV.empty?             or
    ARGV.include? '-h'      or
    ARGV.include?'--help'
  puts usage
  exit
end

%w[ -v --verbose ].each do |param|
  if ARGV.include? param
    $options[:verbose] = true
    ARGV[ ARGV.index(param) ] = nil
  end
end


%w[ -s --styles ].each do |param|
  if ARGV.include? param
    get_style_names_after_param param
  end
end

ARGV.compact!

if ARGV.empty?
  errors << "No files or directories were given."
else
  ARGV.each do |param|
    path = Pathname.new(param)
    if path.exist?
      $options[:paths] << path.realpath
      if path.file? and '.docx' != path.extname.downcase
        errors << "Not *.docx file: #{path.basename}"
      end
    else
      errors << "Unknown file/directory: #{param}"
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

$options[:styles].flatten!
$options[:styles].uniq!

$options[:paths].flatten!
$options[:paths].uniq!

######################################################
# Local methods

def out_filepath(in_filepath)
  temp_dir = in_filepath.parent + $options[:sub_dirname]
  temp_dir.mkdir unless temp_dir.exist?
  temp_dir + in_filepath.basename
end


def remove_paragraphs_from_docx_file (docx_filepath)
  puts "Processing #{docx_filepath.basename} ..."  if verbose?
  docx  = Docx::Document.open(docx_filepath)
  changed = false
  docx.paragraphs.each do |para|
    p_style = get_paragraph_style_name(para)
    if $options[:styles].include? p_style
      print "Delete "   if verbose?
      changed = true
      delete_paragraph(para)
    else
      print "       "   if verbose?
    end
    puts p_style        if verbose?
  end
  if changed
    docx.save(out_filepath(docx_filepath))
  end
end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

$options[:paths].each do |path|
  if path.file?   and  '.docx' == path.extname.downcase
    remove_paragraphs_from_docx_file(path)
  else
    path.children.each do |c|
      remove_paragraphs_from_docx_file(c)  if c.file?   and  '.docx' == path.extname.downcase
    end
  end
end

