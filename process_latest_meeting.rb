#!/usr/bin/env ruby
# frozen_string_literal: true

# Processes the latest Voice Memos recording end to end:
#
#   1. Copies the recording and its transcripts into the output directory
#      (see copy_latest_voice_memo.rb).
#   2. Runs `claude -p` over the timestamped markdown transcript to write
#      <name>_notes.md: speaker-assigned transcript with audio links, table of
#      contents, action items, and Jira ticket / pull request references.
#
# Usage:
#   ruby notes/process_latest_meeting.rb [-o DIR] [--speakers "A, B, C"] [--hints "text"] [--dry-run]

require "optparse"
require_relative "copy_latest_voice_memo"

PROJECT_ROOT = File.expand_path("..", __dir__)
DEFAULT_SPEAKERS = "Kyle (Director of IT), Storey, Dewayne, Chad"

# Path relative to the project root, for use inside the prompt.
def relative_path(path, root = PROJECT_ROOT)
  path.delete_prefix("#{root}/")
end

# Builds the prompt given to `claude -p`. +md_path+ is the timestamped
# transcript, +audio_path+ the copied recording.
def build_prompt(md_path, audio_path, speakers: DEFAULT_SPEAKERS, hints: nil)
  audio = File.basename(audio_path)
  notes = relative_path(md_path).sub(/\.md\z/, "_notes.md")
  <<~PROMPT
    Read #{relative_path(md_path)}, the timestamped transcript of a meeting.
    Write #{notes} containing:
    - an Obsidian audio embed ![[#{audio}]] at the top;
    - a table of contents of the topics discussed, each linking to its timestamp;
    - a cleaned-up, speaker-assigned transcript (speakers who spoke: #{speakers}).
      Correct obvious speech-to-text errors. Each speaker turn must link to the audio
      using the nearest paragraph timestamp, as [H:MM:SS](#{audio}#t=N);
    - an action-items table (owner, item, timestamp link);
    - an index of every Jira ticket (e.g. DSVBR-NN) and pull request mentioned, with
      timestamp links.
    Mark low-confidence speaker attributions with [?]. Do not modify the source file.
    #{hints}
  PROMPT
end

# The argv for a headless, pre-approved claude run limited to reading and to
# editing (which covers writing new files) inside +output_dir+.
# `Write(path)` rules are rejected by claude; only `Edit(path)` path rules work.
# A leading `//` marks an absolute path in a permission rule.
def claude_command(prompt, output_dir)
  ["claude", "-p", prompt, "--add-dir", output_dir,
   "--allowedTools", "Read", "Edit(/#{output_dir}/*)"]
end

# Environment overrides for the claude child process. An ANTHROPIC_API_KEY (or
# auth token) in the shell takes precedence over the Claude Code subscription
# login and bills the API instead, so unset them to use the subscription.
def claude_env
  { "ANTHROPIC_API_KEY" => nil, "ANTHROPIC_AUTH_TOKEN" => nil }
end

def parse_options(argv)
  options = { output: Dir.pwd, speakers: DEFAULT_SPEAKERS, hints: nil, dry_run: false }
  OptionParser.new do |o|
    o.banner = "Usage: process_latest_meeting.rb [options]"
    o.on("-o", "--output DIR", "Directory for the created files (default: current directory)") { |v| options[:output] = v }
    o.on("--speakers LIST", "Comma-separated speakers (default: #{DEFAULT_SPEAKERS})") { |v| options[:speakers] = v }
    o.on("--hints TEXT", "Extra guidance on who said what") { |v| options[:hints] = v }
    o.on("-h", "--help", "Show this help") do
      puts o
      exit
    end
    o.on("--dry-run", "Copy and extract, but print the claude command instead of running it") { options[:dry_run] = true }
  end.parse!(argv)
  options
rescue OptionParser::ParseError => e
  abort e.message
end

def main(argv)
  options = parse_options(argv)
  output_dir = File.expand_path(options[:output])
  exported = export_latest_recording(output_dir)
  abort "No .m4a recordings found in #{RECORDINGS_DIR}" unless exported
  abort "No transcript embedded in #{File.basename(exported[:source])}" unless exported[:md]

  puts "Copied #{File.basename(exported[:source])} -> #{relative_path(exported[:audio])}"
  prompt = build_prompt(exported[:md], exported[:audio], speakers: options[:speakers], hints: options[:hints])
  command = claude_command(prompt, output_dir)

  if options[:dry_run]
    puts command.inspect
  else
    puts "Running claude (no output until it finishes; this can take several minutes)..."
    system(claude_env, *command, chdir: PROJECT_ROOT) || abort("claude exited with an error")
  end
rescue Errno::EPERM, Errno::EACCES => e
  abort "Cannot read Voice Memos (grant Full Disk Access to your terminal): #{e.message}"
end

main(ARGV) if $PROGRAM_NAME == __FILE__
