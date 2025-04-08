#!/usr/bin/env ruby
# scripts/categorize_gems.rb
#
# Enable YJIT if available (Ruby 3.4.2 should support it)
RubyVM::YJIT.enable if defined?(RubyVM::YJIT)

require 'rubygems'
require 'set'
require 'parallel'
require 'ruby-progressbar'
require 'ai_client'

require 'debug_me'
include DebugMe

CATEGORY_PROMPT = <<~PROMPT
  As a recommender system, you are tasked with categorizing Ruby gems based on their descriptions. Your goal is to provide a concise and accurate category for a gem, which will help users find gems that match their needs. Please provide a one or more categories for the following gem; however, do not acknowledge
  this task with any commentary or feedback wrappers.  Only response with the
  categories separated by commas.  Avoid using generic categories like "utility" or "toolkit".
  The more specific the better.

  Remember categories only; no notes or comments.

  The gem name, summary and its description follows:
PROMPT

vector_model = 'nomic-embed-text'
VEC = AiClient.new vector_model

chat_model = 'llama3.1'
CHAT = AiClient.new chat_model, provider: :ollama

puts "="*64
puts "Using vector model: #{vector_model}"
puts "        chat model: #{chat_model}"
puts "="*64


# Main processing
puts "Starting gem categorization..."
all_specs = Gem::Specification.all
puts "Found #{all_specs.length} gems to process."


progress = ProgressBar.create(
  title: "Categorizing w/Ollama",
  total: all_specs.length,
  format: "%t: |%B| %p%% [%c/%C] ETA: %E",
  throttle_rate: 01
)

gem_data = Array.new

counter = 5
last_gem_name = ""
all_specs.map do |spec|
  next if spec.name == last_gem_name
  last_gem_name = spec.name

  # break if (counter -= 1) < 0

  text = "#{spec.name} #{spec.summary} #{spec.description}"
  # r = VEC.embed(text)
  # embedding = r.data['data'].first['embedding']
  category = CHAT.chat(CATEGORY_PROMPT + text).gsub("\n", "").split(',').map(&:strip)
  # puts "#{spec.name}: #{category}"
  progress.increment
  gem_data << { spec: spec, category: category} # vector: embedding }
end
progress.finish


progress = ProgressBar.create(
  title: "Grouping Gems",
  total: all_specs.length,
  format: "%t: |%B| %p%% [%c/%C] ETA: %E",
  throttle_rate: 0.1
)

categorized_gems = Hash.new { |h, k| h[k] = [] }

gem_data.each do |gem|
  gem[:category].each do |category|
    categorized_gems[category] << gem[:spec]
  end
end
progress.finish



puts "Generating Markdown report..."
markdown = "# Ruby Gems Category Report\n\n"
markdown << "Generated on: #{Time.now.strftime('%Y-%m-%d')}\n\n"

progress = ProgressBar.create(
  title: "Writing report",
  total: categorized_gems.keys.length,
  format: "%t: |%B| %p%% [%c/%C] ETA: %E",
  throttle_rate: 0.1
)
categorized_gems.keys.sort.each do |category|
  markdown << "## #{category}\n\n"
  categorized_gems[category].sort_by(&:name).each do |gem|
    markdown << "- [#{gem.name}](#{gem.homepage}): "
    markdown << "#{gem.summary || 'No summary available'}\n"
    desc = gem&.description&.gsub("\n", "\n> ") || "No description available."
    markdown << "> #{desc}\n"
  end
  markdown << "\n"
  progress.increment
end
progress.finish
puts "Report generation complete!"

File.write('gem_categories.md', markdown)
puts "Report saved as 'gem_categories.md'. All done!"
