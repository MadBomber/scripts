#!/usr/bin/env ruby
###########################################
###
##  File: docx_style_fixer.rb
##  Desc: Transplants the bad heart of a *.docx file into a good body
##        Given a docx file that has all the correct detail definitions
##        of styles thrown out its heart (word/document.xml) and replace
##        it with a bad heart from a different docx file.  Now with
##        the good body and bad heart recreate a docx file.  It lives!
#

require 'pathname'  # STDLIB
require 'zip'

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pp'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:      false,
  publication:  :ddg,
  bad_files:    [],
  good_file:    my_dir + 'docx_templates' + 'DDG' + 'ddg_styles.docx'
}

def verbose?
  $options[:verbose]
end

usage = <<EOS

Replace detailed style definitions in a document with the
style definitions from a different document.

Usage:  #{my_name} [options] good_file (bad_file)+

Where:

  options
    -h or --help        Display this message
    -v or --verbose     Display progress

  good_file             one file having correct styles

  bad_file              one or more files needing to have a
                        style Transplant

EOS

# Check command line for Problems with Parameters

$errors = []

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


ARGV.compact!

if ARGV.empty?
  puts
  puts "ERROR: No *.docx files were specified"
  puts usage
  exit 1
end


$options[:bad_files]   = ARGV.map {|a_file| Pathname.new(a_file)}


def check_file_type_and_exists(a_file)

  if a_file.directory?
    $errors << "Directories are not supported: #{a_file}"
  else
    unless '.docx' == a_file.extname.downcase
      $errors << "Not a *.docx file: #{a_file}"
    end
    unless a_file.exist?
      $errors << "File does not exist: #{a_file}"
    end
  end

end # end pf def check_file_type_and_exists(a_file)

$options[:bad_files].each {|a_file| check_file_type_and_exists(a_file)}

unless $options[:bad_files].size > 1
  $errors << "At least one good_file and one bad_file is required."
end

unless $errors.empty?
  puts
  $errors.each do |error|
    puts "ERROR: #{error}"
  end
  puts
  puts "Resolve the errors listed above and try again."
  puts "Use '#{my_name} --help' to see usage instructions."
  puts
  exit(1)
end

temp_dir = Pathname.new("./temp_#{rand(10000)}")
temp_dir.mkdir
temp_dir = temp_dir.realpath

$options[:good_file] = $options[:bad_files].shift



at_exit do
  system("rm -fr '#{temp_dir}'")
end

zip_log           = temp_dir + 'zip.log'

doc_xml           = "document.xml"

good_dir          = (temp_dir + 'good')
good_word_dir     = good_dir + "word"

bad_dir           = (temp_dir + 'bad')
bad_word_dir      = bad_dir + "word"

bad_word_doc_xml  = bad_word_dir + doc_xml

good_dir.mkdir
bad_dir.mkdir

system("unzip '#{$options[:good_file]}' -d '#{good_dir}' > '#{zip_log}'")

puts
puts "Processing:"

$options[:bad_files].each do |bad_file|

  print "  #{bad_file.basename} ... "
  system("rm -fr '#{bad_dir}'/* >> '#{zip_log}'")
  system("unzip '#{bad_file}' -d '#{bad_dir}' >> '#{zip_log}'")
  system("mv '#{bad_file}' '#{bad_file.dirname}/original_#{bad_file.basename}'")
  system("mv -f '#{bad_word_doc_xml}' '#{good_word_dir}'")
  system("cd '#{good_dir}'; zip -r ../#{bad_file.basename} * >> '#{zip_log}'")
  system("mv '#{temp_dir}'/*.docx '#{bad_file.dirname}'")
  puts " done."

end

puts
puts "Done."
puts
