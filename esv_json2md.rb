#!/usr/bin/env ruby
# ~/scripts/esv_json2md.rb
# Used to create markdown files for use with Obsidian from the
# JSON files pulled down from https://esv.org by the MyBible plugin
#
# TODO: use api.esv.org to obtain the HTML version of the chapters directly
#       and then use html2md to do the conversion.

require 'json'
require 'nokogiri'
require 'fileutils'

class BibleJsonToMarkdown
  def initialize(json_file)
    @json_data = JSON.parse(File.read(json_file))
  end

  def convert
    markdown  = generate_header
    markdown << process_passages
    markdown << generate_footnotes
    markdown
  end

  private

  def generate_header
    query          = @json_data['query']
    book, chapter  = query.split
    prev_link      = generate_link(book, chapter.to_i - 1)
    next_link      = generate_link(book, chapter.to_i + 1)
    "#{prev_link} #{query} #{next_link}\n\n"
  end

  def generate_link(book, chapter)
    "[[bible/ESV/#{book}/#{book} #{chapter} | #{book} #{chapter}]]"
  end

  def process_passages
    html     = Nokogiri::HTML(@json_data['passages'].first)
    markdown = ""

    skip = false

    html.css('h3, p').each do |element|
      next if skip

      case element.name
      when 'h3'
        if 'footnotes' == element.text.downcase
          skip = true
        else
          markdown << "### #{element.text}\n"
        end
      when 'p'
        markdown << process_paragraph(element)
      end
    end

    markdown
  end

  def process_paragraph(paragraph)
    markdown = ""
    if paragraph['class']&.include?('block-indent')
      markdown << process_block_indent(paragraph)
    else
      paragraph.children.each do |child|
        case child.name
        when 'b'
          if child['class'] == 'chapter-num'
            markdown << "**#{child.text.strip}** "
          elsif child['class']&.include?('verse-num')
            markdown << "**#{child.text.strip}** "
          end
        when 'span'
          markdown << "#{child.text.strip} " if child['class'] == 'woc'
        when 'text'
          markdown << "#{child.text.strip} " unless child.text.strip.empty?
        end
      end
      markdown << "\n\n"
    end
    markdown
  end

  def process_block_indent(paragraph)
    markdown = ""
    paragraph.css('.line').each do |line|
      indent = line['class']&.include?('indent') ? "    " : "  "
      content = line.text.strip.gsub(/^\d+\s*/, '')
      markdown << "#{indent}#{content}\n"
    end
    markdown << "\n"
    markdown
  end

  def generate_footnotes
    html      = Nokogiri::HTML(@json_data['passages'].first)
    footnotes = html.css('.footnotes p').text
    "### Footnotes\n#{footnotes.gsub(/\[(\d+)\]/, '\1.')}\n\n"
  end
end


# Usage
def process_file(file_path)
  print "#{file_path} ... "
  converter = BibleJsonToMarkdown.new(file_path)
  markdown  = converter.convert

  output_file = File.join(File.dirname(file_path),
                          "#{File.basename(file_path, '.*')}.md")
  File.write(output_file, markdown)
  puts "done"
end

def process_directory(dir_path)
  Dir.glob(File.join(dir_path, '**', '*.json')).each do |file|
    process_file(file)
  end
end

if ARGV.empty?
  puts "Usage: #{$PROGRAM_NAME} <json_file_or_directory>"
  exit 1
end

input = ARGV.first

if File.directory?(input)
  process_directory(input)
elsif File.file?(input) && File.extname(input) == '.json'
  process_file(input)
else
  puts "Error: Invalid input. Please provide a JSON file or directory."
  exit 1
end
