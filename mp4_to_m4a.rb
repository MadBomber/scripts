#!/usr/bin/env ruby
# frozen_string_literal: true

# Extract the audio track of an MP4 into an M4A file (requires ffmpeg/ffprobe).
#
#   ruby mp4_to_m4a.rb recording.mp4            # => recording.m4a
#   ruby mp4_to_m4a.rb recording.mp4 out.m4a
#   ruby mp4_to_m4a.rb --force recording.mp4    # overwrite an existing output
#
# AAC audio is copied as-is (fast, lossless); anything else is re-encoded to AAC.

require "open3"

module Mp4ToM4a
  class Error < StandardError; end

  REENCODE_BITRATE = "128k"

  module_function

  def output_path(input)
    input.sub(/\.[^.\/]+\z/, "") + ".m4a"
  end

  def audio_codec(input)
    out, err, status = Open3.capture3(
      "ffprobe", "-v", "error", "-select_streams", "a:0",
      "-show_entries", "stream=codec_name", "-of", "csv=p=0", input
    )
    raise Error, "ffprobe failed: #{err.strip}" unless status.success?

    codec = out.strip
    raise Error, "no audio stream in #{input}" if codec.empty?

    codec
  end

  def audio_args(codec)
    codec == "aac" ? %w[-c:a copy] : ["-c:a", "aac", "-b:a", REENCODE_BITRATE]
  end

  def build_command(input, output, codec, force: false)
    ["ffmpeg", force ? "-y" : "-n", "-v", "error", "-i", input, "-vn", *audio_args(codec), output]
  end

  def extract(input, output = nil, force: false)
    raise Error, "input not found: #{input}" unless File.file?(input)

    output ||= output_path(input)
    raise Error, "#{output} exists (use --force to overwrite)" if File.exist?(output) && !force

    _out, err, status = Open3.capture3(*build_command(input, output, audio_codec(input), force: force))
    raise Error, "ffmpeg failed: #{err.strip}" unless status.success?

    output
  end

  def run(argv)
    force = argv.delete("--force")
    input, output = argv
    abort "usage: #{File.basename($PROGRAM_NAME)} [--force] input.mp4 [output.m4a]" unless input

    puts "wrote #{extract(input, output, force: !force.nil?)}"
  rescue Error => e
    abort "error: #{e.message}"
  end
end

Mp4ToM4a.run(ARGV) if $PROGRAM_NAME == __FILE__
