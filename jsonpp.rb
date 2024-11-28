#!/usr/bin/env ruby
# ~/scripts/jsonpp.rb

# reformat an entire directory of JSON files
# to be pretty printed.


require 'json'
require 'ruby-progressbar'
require 'optparse'


def pretty_print_json_file(file_path)
  content = JSON.parse(File.read(file_path))
  
  File.open(file_path, 'w') do |f|
    f.write(JSON.pretty_generate(content))
  end
rescue JSON::ParserError => e
  puts "ERROR: JSON ParserError in #{file_path}: #{e}"
end


def pretty_print_json_files_in_directory(directory)
  json_files = Dir.glob(File.join(directory, '*.json'))
  
  if json_files.empty?
    puts "WARNING: No JSON files found in #{directory} to pretty print."
    return
  end
  
  progressbar = ProgressBar.create(
    title: "Processing",
    total: json_files.size,
    format: '%a %B %p%% %t'
  )

  json_files.each do |file|
    pretty_print_json_file(file)
    progressbar.increment
  end
  
  puts "All JSON files in #{directory} have been pretty printed."
end

##########################
## Main

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: jsonpp.rb [options]"
  
  opts.on("-d", "--directory DIRECTORY", "Specify the directory to scan for JSON files") do |dir|
    options[:directory] = dir
  end
  
  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!


unless options[:directory]
  puts "ERROR: No directory specified. Use -h or --help for usage."
  exit 1
end


pretty_print_json_files_in_directory(options[:directory])
