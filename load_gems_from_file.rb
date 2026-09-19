#!/usr/bin/env ruby
# load_gems_from_file.rb
# Support load gems from one version of Ruby to another.
# In the old version run: gem list > gems_list.txt
# Then run this script against that file in the new Ruby version.

require 'open3'
require 'pathname'
require 'set'

WORKERS = 6

if ARGV.empty?
  puts <<~ERROR

    No file was presented as a parameter.

  ERROR
  exit
end

file_path = Pathname.new ARGV.shift

if !file_path.exist? || file_path.directory?
  puts <<~ERROR

    Invalid file parameter.

  ERROR
  exit
end

installed = Set.new(Gem::Specification.all.map(&:name))
gems_list = file_path.read.split("\n").map { |g| g.split.first }.compact.reject(&:empty?)
missing   = gems_list.reject { |name| installed.include?(name) }

if missing.empty?
  puts "All gems are already installed."
  exit
end

worker_count = [missing.size, WORKERS].min
puts "Installing #{missing.size} missing gems with #{worker_count} parallel workers...\n\n"

queue = Queue.new
mutex = Mutex.new
missing.each { |g| queue << g }

workers = worker_count.times.map do
  Thread.new do
    loop do
      gem_name = begin
        queue.pop(true)
      rescue ThreadError
        break
      end

      # Skip if a concurrent worker already installed this as a transitive dep
      next if mutex.synchronize { installed.include?(gem_name) }

      mutex.synchronize { puts "gem install #{gem_name}" }
      output, status = Open3.capture2e("yes | gem install #{gem_name}")
      mutex.synchronize { print output }
      success = status.success?

      next unless success

      # Parse `gem dependency` (plain text, no YAML) to mark transitive deps as installed
      begin
        dep_names = `gem dependency #{gem_name} --local 2>/dev/null`
          .lines
          .grep(/^\s+\w/)
          .map { |line| line.strip.split.first }
        mutex.synchronize { dep_names.each { |d| installed.add(d) } }
      rescue => e
        mutex.synchronize { $stderr.puts "\nWARNING: #{gem_name} deps unreadable: #{e}" }
      end
    end
  end
end

workers.each(&:join)
puts "\nDone."
