#!/usr/bin/env ruby
# SimplifiedAcronymExtractor.rb

require "set"
require "pathname"

class String
  def uppercase?
    self == self.upcase
  end
end

class SimplifiedAcronymExtractor
  
  def initialize(paths)
    @paths = paths.empty? ? [Pathname.pwd] : paths # Use current directory if ARGV is empty
    @acronyms = Hash.new { |hash, key| hash[key] = [] }
  end

  def extract_acronyms
    @paths.each do |path|
      process_path(Pathname.new(path))
    end
  end

  def print_acronyms
    puts "\nExtracted Acronyms and Possible Definitions:"
    
    # Drop acronyms without a best match and with over 3 unique definitions before printing
    # drop_unmatched_acronyms
    
    @acronyms.each do |acronym, definitions|
      puts "\n#{acronym}:"
      puts "  #{definitions.join("\n  ")}"
    end

    puts
  end

  private

  def drop_unmatched_acronyms
    @acronyms.each do |acronym, in_definitions|
      # Unique definitions and reject empty ones
      definitions = in_definitions
                      .uniq
                      .reject { |defn| defn.strip.empty? }
      
      # Sort definitions by best match criteria
      sorted_definitions = sort_definitions(acronym, definitions)
      
      # Check number of unique definitions and whether sorted_definitions.first is a best match
      # Drop the acronym if conditions are not met
      if definitions.size > 3 || sorted_definitions != definitions
        @acronyms.delete(acronym)
      else
        @acronyms[acronym] = sorted_definitions # Update with sorted and filtered definitions
      end
    end
  end
  


  def process_path(path)
    return unless path.exist?

    if path.directory?
      path.each_child { |child| process_path(child) }
    else
      process_file(path) if [".txt", ".md"].include? path.extname.downcase
    end
  end

  def process_file(path)
    content = File
      .read(path)
      .gsub(/[^A-Za-z\s]/, " ") # Replace non-alpha characters with spaces
      .squeeze(" ") # Merge multiple spaces into one
      .split(" ")

    content.prepend "xyzzy"
    content.append "xyzzy"

    possibles = []

    content.each_with_index do |word, word_inx|
      next if 1 == word.size
      next unless word.uppercase?
      next if content[word_inx - 1].uppercase? ||
              content[word_inx + 1].uppercase?

      possibles << word_inx
    end

    return if possibles.empty?
  
    # Attempt to find definitions for the possible acronyms
    possibles.each do |word_inx|
      acronym         = content[word_inx]
      left_inx        = word_inx - acronym.size
      left_inx        = 0 if left_inx.negative?
      right_inx       = word_inx + acronym.size

      definition_left  = content[left_inx..word_inx-1].join(' ')
      definition_right = content[word_inx+1..right_inx].join(' ')

      if acronym_match?(definition_left, acronym)
        @acronyms[acronym] << definition_left
      elsif acronym_match?(definition_right, acronym)
        @acronyms[acronym] << definition_right
      end
    end
  end

  def acronym_match?(definition, acronym)
    definition_upcase = definition.upcase

    return false if definition_upcase.include? acronym

    index = 0
    acronym.each_char do |char|
      index = definition_upcase.index(char, index)
      return false if index.nil?
      index += 1
    end

    true
  end

  # New method to sort definitions
  def sort_definitions(acronym, definitions)
    definitions.sort_by do |definition|
      match_quality = acronym.each_char.map.with_index do |acronym_char, index|
        definition_char = definition.split.map(&:chr)[index]&.upcase # First character of each word upcased
        if acronym_char == definition_char
          0 # Best case: Exact match including case
        elsif acronym_char.upcase == definition_char
          1 # Second case: Letter match, ignore case
        else
          2 # Fallback
        end
      end
      match_quality
    end
  end
end

if ARGV.empty?
  puts "No file paths provided, using current directory..."
end

extractor = SimplifiedAcronymExtractor.new(ARGV)
extractor.extract_acronyms
extractor.print_acronyms
