#!/usr/bin/env ruby
# frozen_string_literal: true

# movie_card.rb
#
# Generate a pleasingly formatted Markdown information card for one or more
# movies stored as *.mp4 files (TiVo/TCM recordings carry rich metadata).
#
# Usage:
#   ruby movie_card.rb FILE_OR_DIR [FILE_OR_DIR ...]
#
#   * Each FILE must be a path to an *.mp4 file.
#   * Each DIR is searched recursively for *.mp4 files.
#   * For every movie found, a Markdown card is written next to the mp4,
#     using the same basename (e.g. "Adam's Rib.mp4" -> "Adam's Rib.md").
#
# The card is built from the metadata embedded in the container by TiVo,
# read via `ffprobe` (part of ffmpeg). Two of the tags (iTunMOVI, tiVoINFO)
# are Apple/TiVo XML property lists; they are parsed for cast and crew.

require 'open3'
require 'json'
require 'rexml/document'

# ---------------------------------------------------------------------------
# Plist: minimal Apple/TiVo XML property-list reader.
# Converts a plist <dict>/<array> tree into plain Ruby Hash/Array values.
# ---------------------------------------------------------------------------
module Plist
  module_function

  # Parse a plist XML string into Ruby objects. Returns nil for blank input.
  def parse(xml)
    return nil if xml.nil? || xml.to_s.strip.empty?

    doc  = REXML::Document.new(xml)
    root = doc.root            # <plist>
    return nil unless root

    top = first_element(root)  # the top-level <dict> or <array>
    top ? parse_node(top) : nil
  rescue REXML::ParseException
    nil
  end

  # Convert a single plist element into its Ruby value.
  def parse_node(el)
    case el.name
    when 'dict'    then parse_dict(el)
    when 'array'   then parse_array(el)
    when 'string'  then el.text.to_s
    when 'integer' then el.text.to_i
    when 'real'    then el.text.to_f
    when 'true'    then true
    when 'false'   then false
    else                el.text.to_s
    end
  end

  # A plist <dict> is a flat sequence of <key> followed by its value element.
  def parse_dict(el)
    result = {}
    key = nil
    el.elements.each do |child|
      if child.name == 'key'
        key = child.text.to_s
      elsif key
        result[key] = parse_node(child)
        key = nil
      end
    end
    result
  end

  def parse_array(el)
    el.elements.map { |child| parse_node(child) }
  end

  # First child element of a node, or nil.
  def first_element(el)
    el.elements.each { |c| return c }
    nil
  end
end

# ---------------------------------------------------------------------------
# Ffprobe: thin wrapper that returns the container metadata as a Ruby Hash.
# ---------------------------------------------------------------------------
module Ffprobe
  module_function

  # Run ffprobe and return the parsed JSON, or raise on failure.
  def run(path)
    out, err, status = Open3.capture3(
      'ffprobe', '-v', 'quiet', '-print_format', 'json',
      '-show_format', '-show_streams', path
    )
    raise "ffprobe failed for #{path}: #{err}" unless status.success?

    JSON.parse(out)
  end

  # True if an ffprobe binary is reachable on PATH.
  def available?
    _o, _e, status = Open3.capture3('ffprobe', '-version')
    status.success?
  rescue Errno::ENOENT
    false
  end
end

# ---------------------------------------------------------------------------
# Mp4Finder: turn CLI arguments into a flat, de-duplicated list of mp4 paths.
# ---------------------------------------------------------------------------
module Mp4Finder
  module_function

  # Expand a list of files/dirs into mp4 file paths.
  def collect(paths)
    paths.flat_map { |p| expand(p) }.uniq
  end

  # Expand a single argument into zero or more mp4 paths.
  def expand(path)
    if File.directory?(path)
      Dir.glob(File.join(path, '**', '*.mp4'), File::FNM_CASEFOLD).sort
    elsif File.file?(path) && mp4?(path)
      [path]
    else
      warn "Skipping (not an .mp4 file or directory): #{path}"
      []
    end
  end

  def mp4?(path)
    File.extname(path).downcase == '.mp4'
  end
end

# ---------------------------------------------------------------------------
# MovieMetadata: friendly accessors over the raw ffprobe Hash.
# ---------------------------------------------------------------------------
class MovieMetadata
  def initialize(probe, source_path: nil)
    @format = probe['format'] || {}
    @tags   = @format['tags'] || {}
    @source = source_path
    @itun   = Plist.parse(@tags['iTunMOVI'])
    @tivo   = Plist.parse(@tags['tiVoINFO'])
  end

  def title
    value(@tags['title']) || value(@tags['show']) || basename_title
  end

  def year;       value(@tags['date']);                                end
  def genre;      value(@tags['genre']);                               end
  def network;    value(@tags['network']);                             end
  def program_id; value(@tags['episode_id']) || tivo('programId');     end
  def hd?;        @tags['hd_video'].to_s == '1';                       end

  # Prefer the full text in comment/synopsis over the truncated description.
  def synopsis
    value(@tags['comment']) || value(@tags['synopsis']) || value(@tags['description'])
  end

  def directors; names_for('directors'); end
  def producers; names_for('producers'); end
  def cast;      names_for('cast');      end

  # Runtime in whole seconds, or nil.
  def duration_seconds
    d = @format['duration']
    d ? d.to_f : nil
  end

  # TiVo star rating mapped to a 0-4 scale (TiVo stores half-stars as 1..8).
  def stars
    raw = tivo('starRating')
    return nil unless raw

    raw.to_f / 2.0
  end

  # The date the recording started, as YYYY-MM-DD (or nil).
  def recorded_on
    iso = tivo('startTime') || tivo('time')
    return nil unless iso

    iso.to_s[0, 10]
  end

  private

  def basename_title
    return nil unless @source

    File.basename(@source, File.extname(@source))
  end

  # Pull a list of formatted names out of the iTunMOVI plist.
  def names_for(key)
    arr = @itun.is_a?(Hash) ? @itun[key] : nil
    return [] unless arr.is_a?(Array)

    arr.filter_map { |entry| entry.is_a?(Hash) ? format_name(entry['name']) : nil }
       .reject(&:empty?)
  end

  # "Tracy|Spencer" -> "Spencer Tracy"; "Loos|Janna Da" -> "Janna Da Loos".
  def format_name(raw)
    parts = raw.to_s.split('|').map(&:strip).reject(&:empty?)
    case parts.length
    when 0 then ''
    when 1 then parts.first
    else        parts.reverse.join(' ')
    end
  end

  def tivo(key)
    @tivo.is_a?(Hash) ? value(@tivo[key]) : nil
  end

  # Normalize blank strings to nil.
  def value(v)
    s = v.to_s.strip
    s.empty? ? nil : s
  end
end

# ---------------------------------------------------------------------------
# CardRenderer: turn a MovieMetadata into a Markdown document (pure string).
# ---------------------------------------------------------------------------
class CardRenderer
  def initialize(meta)
    @meta = meta
  end

  def render
    sections = [heading, blockquote(@meta.synopsis), facts_table, cast_list, footer]
    sections.compact.join("\n\n") + "\n"
  end

  # "%dh %02dm" for feature lengths, "%dm" for shorts; nil-safe.
  def self.format_runtime(seconds)
    return nil unless seconds

    total = seconds.to_f.round
    hours = total / 3600
    mins  = (total % 3600) / 60
    hours.positive? ? format('%dh %02dm', hours, mins) : format('%dm', mins)
  end

  # A 4-star bar: "★★★½" for 3.5, "★★★★" for 4.0; nil-safe.
  def self.star_bar(stars, max = 4)
    return nil unless stars

    full  = stars.floor
    half  = (stars - full) >= 0.5 ? 1 : 0
    empty = [max - full - half, 0].max
    ('★' * full) + ('½' * half) + ('☆' * empty)
  end

  private

  def heading
    title = @meta.title
    @meta.year ? "# #{title} (#{@meta.year})" : "# #{title}"
  end

  def blockquote(text)
    return nil unless text

    "> #{text}"
  end

  # A two-column key/value table of the scalar facts that are present.
  def facts_table
    rows = []
    rows << ['Year',     @meta.year]
    rows << ['Genre',    @meta.genre]
    rows << ['Director', join(@meta.directors)]
    rows << ['Producer', join(@meta.producers)]
    rows << ['Rating',   rating_text]
    rows << ['Runtime',  self.class.format_runtime(@meta.duration_seconds)]
    rows << ['Quality',  @meta.hd? ? 'HD' : nil]
    rows << ['Network',  @meta.network]
    rows << ['Recorded', @meta.recorded_on]
    rows = rows.reject { |(_label, val)| val.nil? || val.to_s.empty? }
    return nil if rows.empty?

    lines = ['| Field | Value |', '|---|---|']
    rows.each { |(label, val)| lines << "| **#{label}** | #{val} |" }
    lines.join("\n")
  end

  def cast_list
    names = @meta.cast
    return nil if names.empty?

    (['## Cast', ''] + names.map { |n| "- #{n}" }).join("\n")
  end

  def footer
    bits = []
    bits << 'Source: TiVo recording'
    bits << "Program #{@meta.program_id}" if @meta.program_id
    "---\n\n*#{bits.join(' · ')}*"
  end

  def rating_text
    bar = self.class.star_bar(@meta.stars)
    return nil unless bar

    format('%s (%.1f/4)', bar, @meta.stars)
  end

  def join(list)
    list.nil? || list.empty? ? nil : list.join(', ')
  end
end

# ---------------------------------------------------------------------------
# CLI: glue it together.
# ---------------------------------------------------------------------------
class CLI
  def initialize(argv)
    @argv = argv
  end

  def run
    return usage if @argv.empty?

    unless Ffprobe.available?
      warn 'Error: ffprobe not found on PATH (install ffmpeg).'
      return 1
    end

    files = Mp4Finder.collect(@argv)
    if files.empty?
      warn 'No .mp4 files found.'
      return 1
    end

    files.each { |path| process(path) }
    0
  end

  private

  def process(path)
    probe = Ffprobe.run(path)
    meta  = MovieMetadata.new(probe, source_path: path)
    card  = CardRenderer.new(meta).render
    out   = output_path_for(path)
    File.write(out, card)
    puts "Wrote #{out}"
  rescue StandardError => e
    warn "Failed: #{path} (#{e.message})"
  end

  # Same directory, same basename, .md extension.
  def output_path_for(path)
    dir  = File.dirname(path)
    base = File.basename(path, File.extname(path))
    File.join(dir, "#{base}.md")
  end

  def usage
    warn <<~USAGE
      Usage: ruby movie_card.rb FILE_OR_DIR [FILE_OR_DIR ...]

        FILE   path to an .mp4 file
        DIR    directory searched recursively for .mp4 files

      Writes a Markdown info card next to each movie (same basename, .md).
    USAGE
    1
  end
end

exit(CLI.new(ARGV).run) if __FILE__ == $PROGRAM_NAME
