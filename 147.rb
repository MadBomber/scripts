#!/usr/bin/env ruby
# frozen_string_literal: true

# 147.rb — toggle a per-tab color scheme on iTerm2 tabs 1, 4 and 7.
#
# First call turns the scheme on, next call turns it off. Each tab gets a
# distinct background tint, a matching sidebar tab color and a title so the
# three Claude Code instances are easy to tell apart.
#
#   147.rb          toggle
#   147.rb on       force on
#   147.rb off      force off
#   147.rb status   report on/off without changing anything
#
# Escape sequences are written straight to each tab's tty device, so the tab
# does not need to be active, and the running program (Claude, a shell, ...)
# is not disturbed.

require "open3"
require "fileutils"
require "time"

module OneFourSeven
  SCHEME = {
    1 => { title: "MAIN", bg: "0a2a12", tab: [0, 200, 0] },
    4 => { title: "TAB4", bg: "0a1430", tab: [0, 120, 255] },
    7 => { title: "TAB7", bg: "2a0a0a", tab: [255, 60, 0] }
  }.freeze

  DEFAULT_BG     = "000000"
  STATE_FILE     = File.join(Dir.home, ".cache", "147.state")
  TTY_SCRIPT     = <<~APPLESCRIPT
    tell application "iTerm2" to tell current window
      set out to ""
      repeat with i from 1 to (count of tabs)
        set out to out & i & " " & (tty of current session of tab i) & linefeed
      end repeat
      return out
    end tell
  APPLESCRIPT

  module_function

  # --- escape sequence builders (pure) -------------------------------------

  def bg_sequence(hex)
    "\e]1337;SetColors=bg=#{hex}\a"
  end

  def tab_color_sequence(red, green, blue)
    { red:, green:, blue: }.map { |name, level| "\e]6;1;bg;#{name};brightness;#{level}\a" }.join
  end

  def tab_color_reset_sequence
    "\e]6;1;bg;*;default\a"
  end

  def title_sequence(title)
    "\e]1;#{title}\a"
  end

  def on_sequence(entry)
    bg_sequence(entry[:bg]) +
      tab_color_sequence(*entry[:tab]) +
      title_sequence(entry[:title])
  end

  def off_sequence
    bg_sequence(DEFAULT_BG) + tab_color_reset_sequence
  end

  # --- iTerm2 discovery ----------------------------------------------------

  # Parses osascript output of "<index> <tty>" lines into { 1 => "/dev/ttys000", ... }
  def parse_tty_listing(text)
    text.each_line.with_object({}) do |line, map|
      index, tty = line.split
      next unless index && tty
      map[index.to_i] = tty
    end
  end

  def tab_ttys(runner: method(:run_osascript))
    parse_tty_listing(runner.call(TTY_SCRIPT))
  end

  def run_osascript(script)
    out, err, status = Open3.capture3("osascript", "-e", script)
    raise "osascript failed: #{err.strip}" unless status.success?
    out
  end

  # --- state ---------------------------------------------------------------

  def on?(state_file = STATE_FILE)
    File.exist?(state_file)
  end

  def mark_on(state_file = STATE_FILE)
    FileUtils.mkdir_p(File.dirname(state_file))
    File.write(state_file, Time.now.iso8601)
  end

  def mark_off(state_file = STATE_FILE)
    FileUtils.rm_f(state_file)
  end

  # --- actions -------------------------------------------------------------

  def write_to_tty(tty, sequence, opener: File.method(:open))
    opener.call(tty, "w") { |io| io.write(sequence) }
    true
  rescue SystemCallError => e
    warn "skip #{tty}: #{e.message}"
    false
  end

  # Returns the list of tab indexes that were actually updated.
  def apply(sequences, ttys:, writer: method(:write_to_tty))
    sequences.filter_map do |index, sequence|
      tty = ttys[index]
      if tty.nil?
        warn "skip tab #{index}: not open"
        next
      end
      index if writer.call(tty, sequence)
    end
  end

  def turn_on(ttys:, state_file: STATE_FILE)
    done = apply(SCHEME.transform_values { |entry| on_sequence(entry) }, ttys:)
    mark_on(state_file)
    done
  end

  def turn_off(ttys:, state_file: STATE_FILE)
    done = apply(SCHEME.keys.to_h { |index| [index, off_sequence] }, ttys:)
    mark_off(state_file)
    done
  end

  def status_line(state_file: STATE_FILE)
    "147 scheme is #{on?(state_file) ? 'ON' : 'OFF'}"
  end

  def run(argv, ttys: nil, state_file: STATE_FILE)
    mode = argv.first.to_s.downcase
    return status_line(state_file:) if mode == "status"

    ttys ||= tab_ttys
    turn_on_now =
      case mode
      when "on"  then true
      when "off" then false
      else            !on?(state_file)
      end

    done = turn_on_now ? turn_on(ttys:, state_file:) : turn_off(ttys:, state_file:)
    "147 scheme #{turn_on_now ? 'ON' : 'OFF'} for tabs #{done.join(', ')}"
  end
end

puts OneFourSeven.run(ARGV) if __FILE__ == $PROGRAM_NAME
