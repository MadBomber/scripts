#!/usr/bin/env ruby
# ~/SCRIPTS/prepend_relative_path_as_comment.rb

require 'fileutils'
require 'optparse'

# This program appends a relative path to specified files
# as a comment line, placing it after any shebang and magic comments.

# Leading lines that must stay at the top of a Ruby file:
# the shebang (line 1 only) and magic comments such as
# encoding and frozen_string_literal.
MAGIC_COMMENT = /\A#\s*(-\*-.*-\*-|(en)?coding\s*[:=]|frozen_string_literal\s*:|warn_indent\s*:|warn_past_scope\s*:|shareable_constant_value\s*:)/i

# Returns how many leading lines are shebang/magic-comment lines.
def header_line_count(lines)
  count = 0
  count += 1 if lines.first&.start_with?('#!')
  count += 1 while lines[count]&.match?(MAGIC_COMMENT)
  count
end

# Returns the new content, or nil when the comment is already
# present in the leading comment block.
def content_with_path_comment(lines:, comment_line:)
  leading_comments = lines.take_while { |line| line.start_with?('#') }
  return nil if leading_comments.any? { |line| line.chomp == comment_line.chomp }

  insert_at = header_line_count(lines)
  header    = lines[0...insert_at].map { |line| line.end_with?("\n") ? line : "#{line}\n" }
  (header + [comment_line] + lines[insert_at..]).join
end

def append_relative_path_to_file(file_path:, relative_path:)
  comment_line = "# #{relative_path}\n"
  lines        = File.exist?(file_path) ? File.readlines(file_path) : []
  new_content  = content_with_path_comment(lines: lines, comment_line: comment_line)
  return if new_content.nil?

  # Write to a temp file, give it the original's mode, then
  # move it into place so the executable bit survives.
  tmp_file_path = "#{file_path}.tmp"
  File.write(tmp_file_path, new_content)
  File.chmod(File.stat(file_path).mode, tmp_file_path) if File.exist?(file_path)
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
