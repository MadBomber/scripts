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

require 'pathname'
require 'zip'

require 'awesome_print'
require 'pp'

pgm_name  = Pathname.new(__FILE__).basename

usage =<<EOS

Replace detailed style definitions in a document with the
style definitions from a different document.

Usage:  #{pgm_name} good_file (bad_file)+

Where:

  good_file             path to the model file with the good
                        style definitions

  bad_file              one or more files needing to have a
                        style Transplant

EOS

if ARGV.empty? or ARGV.include?('--help') or ARGV.include?('-h')
  puts usage
  exit
end

if ARGV.size < 2
  puts
  puts "ERROR: expecting 2 or more parameters"
  puts usage
  exit 1
end

good_file   = Pathname.new(ARGV.shift).realpath
bad_files   = ARGV.map {|a_file| Pathname.new(a_file).realpath}

$errors = []

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

[good_file,bad_files].flatten.each {|a_file| check_file_type_and_exists(a_file)}

unless $errors.empty?
  puts
  $errors.each do |error|
    puts "ERROR: #{error}"
  end
  puts
  puts "Resolve the errors listed above and try again."
  puts "Use '#{pgm_name} --help' to see usage instructions."
  puts
  exit(1)
end

temp_dir = Pathname.new("./temp_#{rand(10000)}")
temp_dir.mkdir
temp_dir = temp_dir.realpath


at_exit do
  puts("rm -fr '#{temp_dir}'")
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

system("unzip '#{good_file}' -d '#{good_dir}' > '#{zip_log}'")

puts
puts "Processing:"

bad_files.each do |bad_file|

  if bad_file == good_file
    next
  end

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
