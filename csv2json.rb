#!/usr/bin/env ruby
# encoding: utf-8

require 'csv'       # STDLIB
require 'json'
require 'pathname'  # STDLIB

$options = {
  verbose:        false,
  header:         true
}

def verbose?
  $options[:verbose]
end

def header?
  $options[:header]
end

def convert_csv_to_json(csv_path)
  # Read CSV and convert to JSON
  begin
    data = CSV.read(csv_path, headers: $options[:header], header_converters: :symbol, converters: :all)
    json_array = data.map { |row| row.to_h }
    json_path = csv_path.gsub('.csv', '.json')

    File.write(json_path, JSON.pretty_generate(json_array))

    puts "Converted #{csv_path} to #{json_path}" if verbose?
  rescue => e
    STDERR.puts "Error processing file #{csv_path}: #{e.message}"
  end
end

# Process command-line options
ARGV.each do |arg|
  case arg
  when '-h', '--help'
    puts "Usage: #{$PROGRAM_NAME} [options] filename.csv [...]"
    puts "Options:"
    puts "  -h, --help      Display this message"
    puts "  -v, --verbose   Display progress"
    puts "      --no-header Treat CSVs as having no header row"
    exit
  when '-v', '--verbose'
    $options[:verbose] = true
  when '--no-header'
    $options[:header] = false
  else
    # Treat as filename
    if File.exist?(arg) && File.extname(arg).downcase == '.csv'
      convert_csv_to_json(arg)
    else
      STDERR.puts "Invalid argument or file not found: #{arg}"
    end
  end
end

if ARGV.empty?
  puts "Usage: #{$PROGRAM_NAME} [options] filename.csv [...]"
  exit
end
