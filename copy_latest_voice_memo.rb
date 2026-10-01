#!/usr/bin/env ruby
# frozen_string_literal: true

# Copies the most recent Voice Memos recording into notes/meetings/, plus its
# embedded transcript (.txt, and timestamped .md/.html linked to the audio)
# beside it, named after the recording's title (ZCUSTOMLABELFORSORTING in CloudRecordings.db;
# ZCUSTOMLABEL holds the creation timestamp, not the title).
#
# Usage: ruby notes/copy_latest_voice_memo.rb [destination_dir]
#
# The terminal running this needs Full Disk Access to read the Voice Memos
# group container.

require "fileutils"
require "cgi"
require "json"
require "uri"
require "open3"

RECORDINGS_DIR = File.expand_path(
  "~/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings"
)
DB_PATH = File.join(RECORDINGS_DIR, "CloudRecordings.db")
DEFAULT_DESTINATION = File.join(__dir__, "meetings")

# Returns the path of the newest .m4a in +dir+ (by modification time), or nil.
def latest_recording(dir = RECORDINGS_DIR)
  Dir.glob(File.join(dir, "*.m4a")).max_by { |path| File.mtime(path) }
end

# Returns the title (ZCUSTOMLABELFORSORTING) Voice Memos stores for +source+, or nil when
# the recording has no label or the database cannot be read.
def recording_label(source, db_path = DB_PATH)
  path = File.basename(source).gsub("'", "''")
  sql = "SELECT ZCUSTOMLABELFORSORTING FROM ZCLOUDRECORDING WHERE ZPATH = '#{path}' LIMIT 1"
  out, status = Open3.capture2("sqlite3", "-readonly", db_path, sql)
  label = out.strip
  status.success? && !label.empty? ? label : nil
end

# Builds the target file name: the label plus the source extension, falling
# back to the original file name when there is no label.
def target_name(source, label)
  return File.basename(source) unless label

  label + File.extname(source)
end

# Copies +source+ into +destination_dir+ (created if needed) under the name
# +target_name+, preserving the modification time. Returns the destination path.
def copy_recording(source, destination_dir = DEFAULT_DESTINATION, name = File.basename(source))
  FileUtils.mkdir_p(destination_dir)
  target = File.join(destination_dir, name)
  FileUtils.cp(source, target, preserve: true)
  target
end

# Returns the transcript JSON (a Hash) embedded in the m4a 'tsrp' atom, or
# nil when the recording has no transcript.
def transcript_data(m4a_path)
  data = File.binread(m4a_path)
  pos = data.index("tsrp".b)
  return unless pos

  size = data[pos - 4, 4].unpack1("N")
  JSON.parse(data.byteslice(pos + 4, size - 8).force_encoding(Encoding::UTF_8))
rescue JSON::ParserError
  nil
end

# Joins the words of a transcript Hash back into plain text.
def transcript_text(transcript)
  transcript.dig("attributedString", "runs").grep(String).join.strip
end

# Writes the transcript of +m4a_path+ to a .txt beside +target+. Returns the
# .txt path, or nil when the recording has no transcript.
def write_transcript(m4a_path, target)
  transcript = transcript_data(m4a_path)
  return unless transcript

  txt_path = "#{target.sub(/\.m4a\z/i, '')}.txt"
  File.write(txt_path, "#{transcript_text(transcript)}\n")
  txt_path
end

# Splits a transcript Hash into [{start:, text:}] segments. A new segment begins
# after a pause of +gap+ seconds or once the current one runs +max_seconds+.
def transcript_segments(transcript, gap: 1.5, max_seconds: 45)
  table = transcript.dig("attributedString", "attributeTable")
  words = transcript.dig("attributedString", "runs").each_slice(2).map do |word, index|
    { word: word, start: table[index]["timeRange"][0], finish: table[index]["timeRange"][1] }
  end

  segments = []
  previous = nil
  words.each do |w|
    new_segment = segments.empty? ||
                  w[:start] - previous[:finish] >= gap ||
                  w[:start] - segments.last[:start] >= max_seconds
    segments << { start: w[:start], text: +"" } if new_segment
    segments.last[:text] << w[:word]
    previous = w
  end
  segments.each { |s| s[:text] = s[:text].strip }
end

# Formats seconds as H:MM:SS.
def format_timestamp(seconds)
  h, rest = seconds.to_i.divmod(3600)
  m, s = rest.divmod(60)
  format("%d:%02d:%02d", h, m, s)
end

# Markdown transcript headed by an Obsidian audio embed (![[file]] renders a
# player). Timestamps link to the audio via a #t= media fragment, which
# browsers and Obsidian's Media Extended plugin honour; Finder and QuickTime
# do not.
def timestamped_markdown(segments, audio_name)
  href = URI::DEFAULT_PARSER.escape(audio_name)
  lines = segments.map do |s|
    "[#{format_timestamp(s[:start])}](#{href}#t=#{s[:start].to_i}) #{s[:text]}\n"
  end
  "![[#{audio_name}]]\n\n#{lines.join("\n")}"
end

# Self-contained HTML page with an audio player; clicking a timestamp seeks the
# player to that point and starts playback.
def timestamped_html(segments, audio_name, title)
  href = URI::DEFAULT_PARSER.escape(audio_name)
  rows = segments.map do |s|
    secs = s[:start].to_i
    %(<p><a href="#{href}#t=#{secs}" data-t="#{secs}">#{format_timestamp(s[:start])}</a> #{CGI.escapeHTML(s[:text])}</p>)
  end
  <<~HTML
    <!doctype html>
    <html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>#{CGI.escapeHTML(title)}</title>
    <style>
      :root { color-scheme: light dark; }
      body { font: 16px/1.6 system-ui, sans-serif; max-width: 60rem; margin: 0 auto; padding: 0 1rem 4rem; }
      audio { position: sticky; top: 0; width: 100%; padding: .5rem 0; background: Canvas; }
      a { font-variant-numeric: tabular-nums; font-weight: 600; text-decoration: none; margin-right: .5rem; }
      p { margin: .75rem 0; }
    </style>
    </head>
    <body>
    <h1>#{CGI.escapeHTML(title)}</h1>
    <audio id="player" controls preload="metadata" src="#{href}"></audio>
    #{rows.join("\n")}
    <script>
      const player = document.getElementById("player");
      document.querySelectorAll("a[data-t]").forEach((a) => {
        a.addEventListener("click", (e) => {
          e.preventDefault();
          player.currentTime = Number(a.dataset.t);
          player.play();
        });
      });
    </script>
    </body>
    </html>
  HTML
end

# Writes <base>.md and <base>.html (timestamped, linked to the audio) beside
# +target+. Returns their paths, or nil when the recording has no transcript.
def write_timestamped_transcripts(m4a_path, target)
  transcript = transcript_data(m4a_path)
  return unless transcript

  base = target.sub(/\.m4a\z/i, "")
  audio_name = File.basename(target)
  segments = transcript_segments(transcript)
  paths = { md: "#{base}.md", html: "#{base}.html" }
  File.write(paths[:md], timestamped_markdown(segments, audio_name))
  File.write(paths[:html], timestamped_html(segments, audio_name, File.basename(base)))
  paths
end

# Copies the newest recording and its transcripts into +destination_dir+.
# Returns { source:, audio:, txt:, md:, html: } (txt/md/html are nil when the
# recording has no transcript), or nil when there are no recordings.
def export_latest_recording(destination_dir = DEFAULT_DESTINATION, recordings_dir = RECORDINGS_DIR)
  source = latest_recording(recordings_dir)
  return unless source

  name = target_name(source, recording_label(source))
  target = copy_recording(source, destination_dir, name)
  timestamped = write_timestamped_transcripts(source, target) || {}
  { source: source, audio: target, txt: write_transcript(source, target),
    md: timestamped[:md], html: timestamped[:html] }
end

def main(argv)
  exported = export_latest_recording(argv.first || DEFAULT_DESTINATION)
  abort "No .m4a recordings found in #{RECORDINGS_DIR}" unless exported

  puts "Copied #{File.basename(exported[:source])} -> #{exported[:audio]}"
  if exported[:txt]
    puts "Transcript -> #{exported[:txt]}"
    puts "Timestamped -> #{exported[:md]}, #{exported[:html]}"
  else
    puts "No transcript embedded in #{File.basename(exported[:source])}"
  end
rescue Errno::EPERM, Errno::EACCES => e
  abort "Cannot read Voice Memos (grant Full Disk Access to your terminal): #{e.message}"
end

main(ARGV) if $PROGRAM_NAME == __FILE__
