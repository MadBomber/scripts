#!/usr/bin/env ruby
# ~/scripts/acronym_finder.rb

require 'pathname'

require 'debug_me'
include DebugMe

# This class identifies and extracts acronyms and their definitions in text content.
class AcronymFinder
  ACRONYM_PATTERN = /(?<=\()([A-Z]+)(?=\))/.freeze

  def initialize(paths)
    @paths    = paths
    @acronyms = {}
  end

  def scan
    @paths.each do |path_string|
      path = Pathname.new(path_string)

      unless path.exist?
        puts "Error: The file or directory '#{path_string}' does not exist."
        exit(1)
      end

      if path.directory?
        path.find do |file|
          process_file(file) if ['.txt', '.md'].include?(file.extname)
        end
      else
        process_file(path)
      end
    end

    print_acronyms
  end

  private


  def process_file(file)
    print "processing: #{file} ... "
    file_content = File.read(file).gsub("\n", " ")  # Treat the file content as a single line
    matches = file_content.scan(ACRONYM_PATTERN)
    matches.flatten.each do |acronym|
      definition = extract_definition(acronym, file_content)
      record_acronym(acronym, definition)
    end
    puts " #{@acronyms.length} acronyms found."
  end


  # def process_file(file)
  #   print "processing: #{file} ... "
  #   File.foreach(file) do |line|
  #     matches = line.scan(ACRONYM_PATTERN)
  #     next if matches.empty?

  #     matches.flatten.each do |acronym|
  #       definition = extract_definition(acronym, line)
  #       record_acronym(acronym, definition)
  #     end
  #   end
  #   puts " #{@acronyms.length} acronyms found."
  # end

  def extract_definition(acronym, line)
    words = line.gsub(/[^0-9a-zA-Z ]/, '').split
    idx   = words.index(acronym)
    
    unless idx.nil?

      words[
        (
          [idx - acronym.length, 0]
          .max
        )...idx
      ].select { |word| acronym.include?(word[0].upcase) }
      .join(' ')
    end
  end

  def record_acronym(acronym, definition)
    return if definition.nil? || definition.strip.empty?

    @acronyms[acronym] ||= []
    @acronyms[acronym] << definition
  end

  def print_acronyms
    @acronyms.each do |acronym, definitions|
      print "| #{acronym} | "
      definitions.uniq.each do |definition|
        print " #{definition} "
      end
      puts "|"
    end
  end
end

# Main execution starts here
if ARGV.empty?
  puts "Usage: #{$0} <file or directory paths...>"
  exit(1)
end

acronym_finder = AcronymFinder.new(ARGV)
acronym_finder.scan


__END__


def find_acronym_words(acronym:, content:)
  formatted_acronym = acronym.downcase.gsub(/[^a-z]/, '')
  formatted_content = content.downcase.gsub(/[^a-z\s]/, '').squeeze(' ')

  words = formatted_content.split - %w[to a and the]

  matching_sequences = []

  # Iterate through the array of words
  words.each_cons(formatted_acronym.length).with_index do |sequence, index|
    thing = sequence.map{|w| w[0]}.join('')
    matching_sequences << sequence.join(' ') if formatted_acronym == thing
  end

  formatted_output = matching_sequences.map { |sequence| "* #{sequence}\n" }.join
  formatted_output.strip!
end

# Example usage:
acronym = 'tdv'
content = 'This is a Test of the Declarative Validator sequence. Try to detect valid!'
find_acronym_words(acronym: acronym, content: content)

# Sample Output:
# * test declarative validator
