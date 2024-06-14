#!/usr/bin/env ruby
# list_top_leve_gems.rb
# 
# A Top-level gem is one which is NOT a dependency
# of another installed gem.
# 

require 'rubygems'

def find_top_level_gems
  # Fetch all installed gems
  all_gems = Gem::Specification.to_a

  # Create a hash to keep track of dependency counts
  dependency_counts = Hash.new(0)

  # Count each gem's occurrences as a dependency
  all_gems.each do |gem_spec|
    gem_spec.dependencies.each do |dep|
      dependency_gem = Gem::Specification.find_all_by_name(dep.name).first
      dependency_counts[dependency_gem.name] += 1 if dependency_gem
    end
  end

  # Filter gems that are never listed as a dependency
  top_level_gems = all_gems.select { |gem_spec| dependency_counts[gem_spec.name].zero? }

  # Print names and versions of these top-level gems
  top_level_gems.map(&:name).sort
end

# Output top-level gems
puts find_top_level_gems
