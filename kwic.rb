#!/usr/bin/env ruby
# kwic.rb

require 'optparse'
require 'csv'

# Base formatter class that defines the interface for all formatters
class BaseFormatter
  attr_reader :full_context

  def initialize(full_context: false)
    @full_context = full_context
  end

  def format(input_file, index_data)
    raise NotImplementedError, "Subclasses must implement the format method"
  end

  protected

  def highlight_keyword(text, keyword, format)
    case format
    when :markdown
      text.gsub(/\b#{Regexp.escape(keyword)}\b/, "**#{keyword}**")
    when :html
      text.gsub(/\b#{Regexp.escape(keyword)}\b/, "<strong>#{keyword}</strong>")
    else
      text
    end
  end
end

# Markdown table formatter
class MarkdownFormatter < BaseFormatter
  def format(input_file, index_data)
    output = []
    output << "KWIC for: #{input_file}\n"
    
    if full_context
      output << "| Line | Left Context | Keyword | Right Context | Original Line |"
      output << "| --- | --- | --- | --- | --- |"
      index_data.each do |line_number, left_context, word, right_context, original_line|
        highlighted_line = highlight_keyword(original_line, word, :markdown)
        output << "| #{line_number} | #{left_context} | #{word} | #{right_context} | #{highlighted_line} |"
      end
    else
      output << "| Line | Left Context | Keyword | Right Context |"
      output << "| --- | --- | --- | --- |"
      index_data.each do |line_number, left_context, word, right_context, _|
        output << "| #{line_number} | #{left_context} | #{word} | #{right_context} |"
      end
    end
    
    output.join("\n")
  end
end

# HTML table formatter
class HtmlFormatter < BaseFormatter
  def format(input_file, index_data)
    output = []
    output << "<h2>KWIC for: #{input_file}</h2>"
    output << "<table border='1'>"
    output << "  <thead>"
    output << "    <tr>"
    output << "      <th>Line</th>"
    output << "      <th style='text-align: right;'>Left Context</th>"
    output << "      <th style='text-align: center;'>Keyword</th>"
    output << "      <th style='text-align: left;'>Right Context</th>"
    output << "      <th>Original Line</th>" if full_context
    output << "    </tr>"
    output << "  </thead>"
    output << "  <tbody>"
    
    index_data.each do |line_number, left_context, word, right_context, original_line|
      output << "    <tr>"
      output << "      <td>#{line_number}</td>"
      output << "      <td style='text-align: right;'>#{left_context}</td>"
      output << "      <td style='text-align: center;'><strong>#{word}</strong></td>"
      output << "      <td style='text-align: left;'>#{right_context}</td>"
      if full_context
        highlighted_line = highlight_keyword(original_line, word, :html)
        output << "      <td>#{highlighted_line}</td>"
      end
      output << "    </tr>"
    end
    
    output << "  </tbody>"
    output << "</table>"
    output.join("\n")
  end
end

# CSV formatter
class CsvFormatter < BaseFormatter
  def format(input_file, index_data)
    output = []
    
    headers = ["Line", "Left Context", "Keyword", "Right Context"]
    headers << "Original Line" if full_context
    
    output << CSV.generate_line(headers)
    
    index_data.each do |line_number, left_context, word, right_context, original_line|
      row = [line_number, left_context, word, right_context]
      row << original_line if full_context
      output << CSV.generate_line(row)
    end
    
    output.join
  end
end

# Factory class to create the appropriate formatter
class FormatterFactory
  FORMATTERS = {
    'markdown' => MarkdownFormatter,
    'html' => HtmlFormatter,
    'csv' => CsvFormatter
  }.freeze

  def self.create(format, full_context: false)
    formatter_class = FORMATTERS[format]
    raise ArgumentError, "Unknown format: #{format}" unless formatter_class
    
    formatter_class.new(full_context: full_context)
  end

  def self.available_formats
    FORMATTERS.keys
  end
end

# KWIC Generator class
class KWICGenerator
  attr_reader :input_file, :separator, :max_words, :keywords

  def initialize(input_file, separator: ' ', max_words: nil, keywords: 1)
    @input_file = input_file
    @separator  = separator
    @max_words  = max_words
    @keywords   = keywords
    @index_data = []
  end

  def generate_kwic_index(formatter)
    process_file
    sort_index
    formatter.format(input_file, @index_data)
  end

  private

  def process_file
    line_number = 0

    File.open(input_file, 'r') do |file|
      file.each_line do |line|
        line_number += 1
        next if line.strip.empty? || line.start_with?("#")
        generate_line_context(line.chomp, line_number)
      end
    end
  rescue Errno::ENOENT
    raise "Error: File '#{input_file}' not found"
  rescue => e
    raise "Error reading file: #{e.message}"
  end

  def generate_line_context(line, line_number)
    words = line.split(separator)

    (0..words.length - keywords).each do |index|
      keyword_phrase = words[index, keywords].join(' ')
      left_context   = build_context(words[0...index], direction: :left)
      right_context  = build_context(words[(index + keywords)..-1], direction: :right)
      
      @index_data.push([line_number, left_context, keyword_phrase, right_context, line])
    end
  end

  def build_context(words, direction:)
    context_with_dots(words, max: max_words, direction: direction).join(' ')
  end

  def context_with_dots(context_words, max: nil, direction: :left)
    return context_words unless max && context_words.count > max

    if direction == :left
      # For left context, take the LAST max words (closest to keyword)
      truncated = context_words.last(max)
      ["..."] + truncated
    else
      # For right context, take the FIRST max words (closest to keyword)
      truncated = context_words.first(max)
      truncated + ["..."]
    end
  end

  def sort_index
    @index_data.sort_by! { |a| a[2].downcase }
  end
end

# CLI Options Parser
class CliOptions
  def self.parse(args)
    options = {
      separator: ' ',
      keywords: 1,
      format: 'markdown',
      full_context: false
    }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: kwic.rb [options]"

      opts.on("-i", "--input-file FILE", "Input file name (required)") do |file|
        options[:input_file] = file
      end

      opts.on("-s", "--separator SEP", "Word separator (default: space)") do |sep|
        options[:separator] = sep
      end

      opts.on("-m", "--max MAX", Integer, "Maximum number of words to use in the context") do |max|
        options[:max_words] = max
      end

      opts.on("-k", "--keywords NUM", Integer, "Number of adjacent words to use as keyword (default: 1)") do |num|
        options[:keywords] = num
      end

      opts.on("-f", "--format FORMAT", FormatterFactory.available_formats, 
              "Output format: #{FormatterFactory.available_formats.join(', ')} (default: markdown)") do |format|
        options[:format] = format
      end

      opts.on("--full-context", "Include original line with highlighted keyword (default: false)") do
        options[:full_context] = true
      end
      
      opts.on("-h", "--help", "Prints help") do
        puts opts
        exit
      end
    end

    parser.parse!(args)
    
    unless options[:input_file]
      puts "ERROR: Missing required argument: -i/--input-file"
      puts parser
      exit 1
    end

    options
  end
end

# Main execution
if __FILE__ == $0
  begin
    options = CliOptions.parse(ARGV)
    
    kwic = KWICGenerator.new(
      options[:input_file],
      separator: options[:separator],
      max_words: options[:max_words],
      keywords: options[:keywords]
    )
    
    formatter = FormatterFactory.create(
      options[:format],
      full_context: options[:full_context]
    )
    
    puts kwic.generate_kwic_index(formatter)
  rescue => e
    puts "ERROR: #{e.message}"
    exit 1
  end
end