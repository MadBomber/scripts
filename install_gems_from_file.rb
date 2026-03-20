#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: install_gems_from_file.rb
##  Desc: Take a list of gem names from a file and installs them
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)

# Ensure that required gems are installed
`gem install amazing_print debug_me cli_helper ruby-progressbar`

require 'amazing_print'         # Pretty print Ruby objects with proper indentation and colors
require 'debug_me'              # A tool to print the labeled value of variables.
require 'cli_helper'            # An encapsulation of an integration of slop, nenv, inifile and configatron.
require 'ruby-progressbar'      # Terminal progress bar
require 'set'                   # For storing installed gems
require 'etc'                   # For Etc.nprocessors
include DebugMe
include CliHelper

configatron.version = '0.0.2'

cli_helper("Return minimum set of gems to install") do |o|
  o.path    '-f', '--file',        'File containing gem names'
  o.path    '-l', '--log',         'Log file path', default: Pathname('gem_install.log')
  o.integer '-c', '--concurrency', 'Parallel install threads', default: [Etc.nprocessors, 8].min
end

# Display the usage info
if ARGV.empty?
  show_usage
  exit
end

# Error check parameters
if configatron.file.nil?
  error("Argument is missing: -f/--file")
end

unless configatron.arguments.empty?
  warning("Unknown arguments ignored: #{configatron.arguments.join(' ')}")
end

abort_if_errors

$log_file = configatron.log

$log_file.open('w') do |f|
  f.puts "Gem Installation Log"
  f.puts "Started:   #{Time.now}"
  f.puts "Gems file: #{configatron.file}"
  f.puts "=" * 60
end

# Memoized — reset after each install batch so newly installed gems are visible
def installed_gems
  @installed_gems ||= Set.new(Gem::Specification.map(&:name))
end
######################################################
# Main

at_exit do
  if $log_file
    $log_file.open('a') do |f|
      f.puts "=" * 60
      if $problem_gems.nil? || $problem_gems.empty?
        f.puts "All gems installed successfully."
      else
        f.puts "Problem gems:"
        $problem_gems.each { |g| f.puts "  - #{g}" }
      end
      f.puts "Completed: #{Time.now}"
    end
  end

  unless $problem_gems.nil? || $problem_gems.empty?
    STDERR.puts
    STDERR.puts "The following gems had problems during installation:"
    STDERR.puts $problem_gems.join('  ')
  end
  STDERR.puts
  STDERR.puts "Done.  Log: #{$log_file}"
  STDERR.puts
end

ap configatron.to_h if verbose? || debug?

missing_gems = Set.new(configatron.file.read.split("\n").map(&:strip).reject(&:empty?)) - installed_gems

$problem_gems = []

if missing_gems.empty?
  puts "All gems are already installed"
else
  mutex     = Mutex.new
  in_flight = Set.new  # gems currently being installed by some thread

  TITLE_WIDTH = 25

  bar = ProgressBar.create(
    title:  'Installing'.ljust(TITLE_WIDTH),
    total:  missing_gems.size,
    format: '%t |%B| %c/%C  %e'
  )
  bar.log "Concurrency: #{configatron.concurrency} threads"
  bar.log "Logging to:  #{$log_file}"

  ts = -> { Time.now.strftime('%H:%M:%S') }
  log = ->(msg) { $log_file.open('a') { |f| f.puts "[#{ts.call}] #{msg}" } }

  spinner_chars = %w[| / - \\]
  ticker = Thread.new do
    i = 0
    loop do
      sleep 0.12
      frame = spinner_chars[i % 4]
      i    += 1
      title = mutex.synchronize do
        if in_flight.size == 1
          "#{frame} #{in_flight.first}"
        elsif in_flight.size > 1
          "#{frame} #{in_flight.size} installing"
        else
          'Installing'
        end
      end
      bar.title = title.ljust(TITLE_WIDTH)
      break if mutex.synchronize { missing_gems.empty? && in_flight.empty? }
    end
    bar.title = 'Done'.ljust(TITLE_WIDTH)
  end

  workers = configatron.concurrency.times.map do
    Thread.new do
      loop do
        # Atomically pop the next gem, skipping anything already handled
        gem_name = mutex.synchronize do
          g       = nil
          skipped = 0
          until missing_gems.empty?
            candidate = missing_gems.first
            missing_gems.delete(candidate)
            if installed_gems.include?(candidate) || in_flight.include?(candidate)
              skipped += 1
              log.call("SKIPPED  #{candidate} (covered by concurrent install)")
              next
            end
            g = candidate
            in_flight.add(g)
            break
          end
          bar.total -= skipped if skipped > 0
          g
        end
        break if gem_name.nil?

        bar.log "[#{ts.call}] Installing #{gem_name}"
        mutex.synchronize { log.call("INSTALLING #{gem_name}") }

        # Run the install outside the mutex so threads work in parallel.
        # stdin is redirected from /dev/null so any interactive prompt (e.g.
        # "Overwrite executable? [yN]") receives EOF and falls back to the
        # default answer (no) rather than hanging indefinitely.
        install_start = Time.now
        system "gem install #{gem_name} < /dev/null >> \"#{$log_file}\" 2>&1"
        elapsed = (Time.now - install_start).round(1)

        # Post-install bookkeeping back under the mutex
        mutex.synchronize do
          in_flight.delete(gem_name)
          Gem.refresh
          @installed_gems = nil

          begin
            spec = Gem::Specification.find_by_name(gem_name)
            pruned_before = missing_gems.size
            missing_gems.subtract(spec.runtime_dependencies.map(&:name))
            pruned = pruned_before - missing_gems.size
            bar.total -= pruned if pruned > 0
            log.call("OK (#{elapsed}s)  #{gem_name}")
          rescue Gem::MissingSpecError
            $problem_gems << gem_name
            log.call("ERROR    #{gem_name}: not found after install")
          rescue => e
            $problem_gems << gem_name
            log.call("ERROR    #{gem_name}: #{e}")
          end

          bar.increment
        end
      end
    end
  end

  workers.each(&:join)
  ticker.join
end # if missing_gems.empty?
