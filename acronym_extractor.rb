#!/usr/bin/env ruby
# ~/scripts/acronym_extractor.rb

require "debug_me"
include DebugMe

require "pathname"
require "optparse"
require "rwordnet" # Require the rwordnet gem
require "ffi/hunspell"

class AcronymExtractor
  TEXT_FILE_EXTENSIONS = [".txt", ".md"] # Add more extensions as needed

  ACRONYM_PATTERNS = [
    /\b((?:\w+\s)+)\(([A-Z]+)\)/i,          # Now case-insensitive, matches "full phrase (ACRONYM)"
    /(?<=\()\b([A-Z]{2,})\b(?=\))/i,        # Also case-insensitive for standalone "ACRONYM"
  ]

  def initialize(paths, verbose: false)
    @paths = paths
    @acronyms = {}
    @verbose = verbose
  end

  def extract_acronyms
    @paths.each do |path|
      begin
        process_path(Pathname.new(path))
      rescue => e
        puts "Error processing #{path}: #{e.message}"
      end
    end
  end

  def print_acronyms
    print "\n\n"

    if @acronyms.empty?
      puts "No acronyms found."
      return
    end

    @acronyms.each do |acronym, definitions|
      definitions.uniq!
      puts "Found Acronym: #{acronym} => #{definitions.join(", ")}"
    end

    print "\n\n"
  end

  private

  def text_file_extension?(extension)
    TEXT_FILE_EXTENSIONS.include?(extension)
  end

  def process_path(path, is_recursive: false)
    unless path.exist?
      puts "Error: The file or directory '#{path}' does not exist." unless is_recursive
      return
    end

    if path.directory?
      path.each_child do |child_path|
        process_path(child_path, is_recursive: true)
      end
    elsif text_file_extension?(path.extname)
      process_file(path)
    end
  end
  def process_file(file_path)
    puts "Processing file: #{file_path.basename}" if @verbose
    begin
      content = File.read(file_path)
                    .encode("UTF-8", invalid: :replace, undef: :replace)
                    .gsub("\n", " ")
    rescue => e
      puts "Error reading file #{file_path.basename}: #{e.message}" if @verbose
      return
    end

    ACRONYM_PATTERNS.each do |pattern|
      content.scan(pattern) do |match|
        if match[1] # Matching the first pattern
          words, acronym = match[0].strip, match[1]
          record_acronym(acronym, words) if valid_acronym?(acronym, words)
        else # Matching standalone acronyms
          acronym = match[0]
          unless valid_english_word?(acronym)
            definition = extract_definition_for_standalone_acronym(acronym, content)
            record_acronym(acronym, definition) if definition
          end
        end
      end
    end
  end


  def extract_definition_for_standalone_acronym(acronym, content)
    # This is a placeholder for a method that would attempt to find a definition for acronyms collected
    # from the simple pattern. This might involve searching the content before the acronym occurrence for
    # phrases that fit the acronym's letters. The implementation of this method depends on the specific
    # requirements and assumptions about the document structure.
    "Placeholder definition"  # This should be replaced with actual logic
  end

  # Check if the acronym is valid and not an all-caps English word
  def valid_acronym?(acronym, words)
    acronym_chars = acronym.upcase.split("") # Normalize to uppercase for comparison
    words_array = words.split(" ")

    # Here, we check if any of the words are acronyms we've already encountered, 
    # and replace them with their first letter if so. It handles nested acronyms.
    acronym_words = words_array.map do |word|
      if @acronyms[word.upcase]
        word[0].upcase
      else
        word[0].upcase
      end
    end

    is_acronym_chars_match = acronym_chars == acronym_words
    is_acronym_chars_match
  end
  
  # Check if a word is a valid English word using WordNet
  def valid_english_word?(word)
    wn_result = !WordNet::Lemma.find_all(word.downcase).empty?

    hs_result = false
    FFI::Hunspell.dict do |dict|
      hs_result = dict.check?(word)
    end

    debug_me {
      [
        :word,
        :wn_result,
        :hs_result,
      ]
    }

    wn_result || hs_result
  end

  def record_acronym(acronym, definition)
    @acronyms[acronym.upcase] ||= [] # Ensure acronym keys are consistently in uppercase
    @acronyms[acronym.upcase] << definition.gsub(/\s+/, " ")
  end
end

options = { help: false, verbose: false }
OptionParser.new do |parser|
  parser.banner = "Usage: acronym_extractor.rb [options] files or directories ..."
  parser.on("-h", "--help", "Prints this help") do
    options[:help] = true
  end
  parser.on("--verbose", "Prints verbose output including file names processed") do
    options[:verbose] = true
  end
end.parse!

if options[:help]
  puts "Usage: acronym_extractor.rb [-h] [--help] [--verbose] <file or directory> ..."
  puts "Example: acronym_extractor.rb --verbose ./path/to/file.txt ./path/to/directory"
  exit
end

paths = ARGV.empty? ? [Pathname.pwd.to_s] : ARGV

extractor = AcronymExtractor.new(paths, verbose: options[:verbose])
extractor.extract_acronyms
extractor.print_acronyms
