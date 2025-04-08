#!/usr/bin/env ruby
# ~/SCRIPTS/prepend_relative_path_as_comment.rb

require 'fileutils'
require 'optparse'

# This program appends a relative path to specified files
# as a comment line, placing it as the first line in each file.

def append_relative_path_to_file(file_path:, relative_path:)
  # Create a temporary file to hold the new content
  tmp_file_path = "#{file_path}.tmp"

  # Prepare the comment line with the relative path
  comment_line = "# #{relative_path}\n"

  # Open the original file for reading
  # and the temporary file for writing
  File.open(tmp_file_path, 'w') do |tmp_file|
    # Write the comment line first
    tmp_file << comment_line

    # Append the existing content of the original file
    if File.exist?(file_path)
      File.foreach(file_path) do |line|
        tmp_file << line
      end
    end
  end

  # Replace the original file with the temporary file
  FileUtils.mv(tmp_file_path, file_path)
end

# Recursively find all .rb files in the given directory
def process_directory(directory:)
  Dir.glob("#{directory}/**/*.rb") do |file|
    relative_path = File.join(Dir.pwd, file).sub("#{Dir.pwd}/", '')
    append_relative_path_to_file(file_path: file, relative_path: relative_path)
  end
end

# Command line option parsing
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: prepend_relative_path_as_comment.rb [options]"

  opts.on('-d', '--dir DIRECTORY', 'Directory to process files in') do |dir|
    options[:directory] = dir
  end
end.parse!

# Process the specified directory
if options[:directory]
  process_directory(directory: options[:directory])
else
  puts "No directory specified. Use -d or --dir to provide a directory."
end
