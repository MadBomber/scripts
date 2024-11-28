#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

# Method to display help information
def display_help
  puts <<~HELP
    Usage: prepend_content.rb [options] CONTENT_FILE TARGET_FILES_OR_DIRS

    Options:
      --dryrun, -d      Show what would happen without making changes
      --help, -h        Display this help message

    CONTENT_FILE:       The path to the file containing the content to prepend.
    TARGET_FILES_OR_DIRS: One or more paths to files or directories where content will be prepended.
  HELP
end

# Method to validate if the path is writable
def valid_writable_path?(path)
  File.directory?(path) ? File.writable?(path) : File.file?(path) && File.writable?(path)
end

# Method to prepend content to a file
def prepend_to_file(content:, target:, dryrun:)
  if dryrun
    puts "Would prepend content to: #{target}"
  else
    existing_content = File.read(target)
    File.write(target, "#{content}#{existing_content}")
  end
end

# Method to find files in a directory recursively
def find_files_in_directory(directory)
  Dir.glob("#{directory}/**/*").select { |f| File.file?(f) }
end

# Method to process each target
def process_targets(content:, targets:, dryrun:)
  targets.each do |target|
    if File.directory?(target)
      files = find_files_in_directory(target)
      files.each { |file| prepend_to_file(content: content, target: file, dryrun: dryrun) }
    elsif valid_writable_path?(target)
      prepend_to_file(content: content, target: target, dryrun: dryrun)
    else
      puts "Error: #{target} is not writable or does not exist."
    end
  end
end

# CLI program entry point
def main
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: prepend_content.rb [options] CONTENT_FILE TARGET_FILES_OR_DIRS"

    opts.on('--dryrun', '-d', 'Show what would happen without making changes') do
      options[:dryrun] = true
    end

    opts.on('--help', '-h', 'Display this help message') do
      options[:help] = true
    end
  end.parse!(into: options)

  if options[:help]
    display_help
    exit
  end

  content_file = ARGV.shift
  targets = ARGV

  unless content_file && !targets.empty?
    puts "Error: You must specify a content file and at least one target file or directory."
    display_help
    exit 1
  end

  unless File.exist?(content_file) && File.readable?(content_file)
    puts "Error: Content file #{content_file} does not exist or is not readable."
    exit 1
  end

  # Read content to prepend from the designated content file
  content = File.read(content_file)

  process_targets(content: content, targets: targets, dryrun: options[:dryrun] || false)
end

# Run the main function
main
