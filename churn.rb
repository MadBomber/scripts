#!/usr/bin/env ruby
# frozen_string_literal: true

# churn.rb — a file-churn report for git repositories, rendered as Markdown.
#
# Churn measures how often a file changes. Files that change constantly are
# where bugs cluster and where refactoring pays off first.
#
# Usage:
#   churn.rb [options] [repo_dir]
#
#   churn.rb                              # entire history, top 30 files
#   churn.rb --since "6 months ago"       # recent hotspots only
#   churn.rb -l 15 -m 5 -o notes/churn.md # top 15, >= 5 commits, to a file
#
# Inspired by the `churn` gem (https://github.com/danmayer/churn) but
# reimplemented as a dependency-free single file — Ruby stdlib only.

require "date"
require "open3"
require "optparse"

module Churn
  VERSION = "1.0.0"

  DEFAULT_IGNORES = %w[vendor/ node_modules/ tmp/ log/ coverage/].freeze

  Options = Data.define(:repo, :since, :limit, :min_commits, :ignores,
                        :include_deleted, :output)

  Change = Data.define(:path, :additions, :deletions, :date, :author)

  ParseResult = Data.define(:commits, :changes)

  FileStat = Data.define(:path, :commits, :additions, :deletions, :authors,
                         :last_touched) do
    def churn_lines = additions + deletions
  end

  DirStat = Data.define(:dir, :commits, :files, :additions, :deletions)

  Meta = Data.define(:repo_name, :branch, :window, :commits, :total_files,
                     :shown, :ignores, :generated_on)

  # Thin wrapper around the git CLI. Everything else in this file is pure and
  # takes plain values, so only this class needs a real repository to test.
  class Repo
    def initialize(dir) = @dir = dir

    def root = @root ||= run("git", "rev-parse", "--show-toplevel").strip

    def branch = run("git", "rev-parse", "--abbrev-ref", "HEAD").strip

    def log(since: nil)
      args = %w[git log --numstat --format=%H%x09%as%x09%an]
      args << "--since=#{since}" if since
      run(*args)
    end

    private

    def run(*cmd)
      out, status = Open3.capture2(*cmd, chdir: @dir)
      raise "command failed (exit #{status.exitstatus}): #{cmd.join(' ')}" unless status.success?

      out
    end
  end

  # Parses `git log --numstat --format=%H%x09%as%x09%an` output.
  module LogParser
    COMMIT_LINE  = /\A(?<sha>[0-9a-f]{40})\t(?<date>\d{4}-\d{2}-\d{2})\t(?<author>.*)\z/
    NUMSTAT_LINE = /\A(?<additions>\d+|-)\t(?<deletions>\d+|-)\t(?<path>.+)\z/

    module_function

    def parse(log_text)
      commits = 0
      date = author = nil
      changes = []

      log_text.each_line(chomp: true) do |line|
        if (commit = COMMIT_LINE.match(line))
          commits += 1
          date   = commit[:date]
          author = commit[:author]
        elsif (change = NUMSTAT_LINE.match(line))
          changes << Change.new(path: normalize_rename(change[:path]),
                                additions: count(change[:additions]),
                                deletions: count(change[:deletions]),
                                date:, author:)
        end
      end

      ParseResult.new(commits:, changes:)
    end

    # Binary files report "-" for line counts; treat them as zero.
    def count(field) = field == "-" ? 0 : Integer(field)

    # git --numstat writes renames as "dir/{old => new}/file" or "old => new".
    # Attribute all history to the file's current (post-rename) path.
    def normalize_rename(path)
      return path unless path.include?(" => ")

      if path.include?("{")
        path.gsub(/\{[^{}]* => ([^{}]*)\}/) { $1 }.squeeze("/")
      else
        path.split(" => ", 2).last
      end
    end
  end

  # Rolls parsed changes up into per-file and per-directory statistics.
  module Aggregator
    module_function

    def file_stats(changes, ignores:, min_commits:, existing_only:, root:)
      changes.group_by(&:path).filter_map do |path, edits|
        next if ignored?(path, ignores)
        next if edits.size < min_commits
        next if existing_only && !File.exist?(File.join(root, path))

        FileStat.new(path:,
                     commits: edits.size,
                     additions: edits.sum(&:additions),
                     deletions: edits.sum(&:deletions),
                     authors: edits.map(&:author).uniq.size,
                     last_touched: edits.map(&:date).max)
      end.sort_by { [-it.commits, -it.churn_lines, it.path] }
    end

    def dir_stats(file_stats, depth: 2, top: 15)
      file_stats.group_by { dir_key(it.path, depth) }.map do |dir, stats|
        DirStat.new(dir:,
                    commits: stats.sum(&:commits),
                    files: stats.size,
                    additions: stats.sum(&:additions),
                    deletions: stats.sum(&:deletions))
      end.sort_by { [-it.commits, it.dir] }.first(top)
    end

    # "app/models/artifacts/kit.rb" (depth 2) => "app/models/"
    def dir_key(path, depth)
      dirs = path.split("/")[0..-2]
      dirs.empty? ? "(root)" : "#{dirs.first(depth).join('/')}/"
    end

    # Patterns ending in "/" match as path prefixes; anything else matches as
    # a glob against the full path or the basename ("*.lock" catches all).
    def ignored?(path, patterns)
      patterns.any? do
        if it.end_with?("/")
          path.start_with?(it)
        else
          File.fnmatch?(it, path) || File.fnmatch?(it, File.basename(path))
        end
      end
    end
  end

  # Renders statistics as a Markdown document with aligned, readable tables.
  module Markdown
    BAR_WIDTH = 12

    module_function

    def report(file_stats, dir_stats, meta)
      <<~MARKDOWN
        # Git Churn Report

        **Repository:** `#{meta.repo_name}` · **Branch:** `#{meta.branch}` ·
        **Window:** #{meta.window} · **Commits analyzed:** #{commafy(meta.commits)} ·
        **Generated:** #{meta.generated_on}

        ## Hotspot Files

        Top #{meta.shown} of #{commafy(meta.total_files)} qualifying files, by commit count.

        #{file_table(file_stats)}

        ## Hotspot Directories

        Aggregated from the qualifying files above (directory depth 2).

        #{dir_table(dir_stats)}

        ---

        *Churn = commits touching a file. Lines are cumulative additions/deletions.
        Ignored: #{meta.ignores.empty? ? 'nothing' : meta.ignores.map { "`#{it}`" }.join(', ')}.
        Generated by `churn.rb` v#{Churn::VERSION}.*
      MARKDOWN
    end

    def file_table(file_stats)
      max = file_stats.map(&:commits).max || 1
      rows = file_stats.each_with_index.map do |stat, index|
        [(index + 1).to_s,
         "`#{escape(stat.path)}`",
         commafy(stat.commits),
         bar(stat.commits, max),
         "+#{commafy(stat.additions)} / -#{commafy(stat.deletions)}",
         stat.authors.to_s,
         stat.last_touched]
      end
      table(%w[# File Commits Churn Lines Authors Last\ touched],
            rows,
            align: %i[right left right left right right left])
    end

    def dir_table(dir_stats)
      rows = dir_stats.map do
        ["`#{escape(it.dir)}`",
         commafy(it.commits),
         commafy(it.files),
         "+#{commafy(it.additions)} / -#{commafy(it.deletions)}"]
      end
      table(%w[Directory Commits Files Lines],
            rows,
            align: %i[left right right right])
    end

    def table(headers, rows, align:)
      widths = ([headers] + rows).transpose.map { |column| column.map(&:length).max }

      lines = [row_line(headers, widths, align), separator_line(widths, align)]
      rows.each { lines << row_line(it, widths, align) }
      lines.join("\n")
    end

    def row_line(cells, widths, align)
      padded = cells.each_with_index.map do |cell, index|
        align[index] == :right ? cell.rjust(widths[index]) : cell.ljust(widths[index])
      end
      "| #{padded.join(' | ')} |"
    end

    def separator_line(widths, align)
      cells = widths.each_with_index.map do |width, index|
        align[index] == :right ? "#{'-' * (width + 1)}:" : "-" * (width + 2)
      end
      "|#{cells.join('|')}|"
    end

    def bar(value, max) = "█" * (value.to_f / max * BAR_WIDTH).ceil.clamp(1, BAR_WIDTH)

    def commafy(number) = number.to_s.gsub(/\B(?=(\d{3})+\z)/, ",")

    def escape(text) = text.gsub("|", "\\|")
  end

  class CLI
    def self.parse(argv)
      options = { since: nil, limit: 30, min_commits: 3,
                  ignores: DEFAULT_IGNORES.dup, include_deleted: false,
                  output: nil }

      parser = OptionParser.new do |o|
        o.banner = "Usage: churn.rb [options] [repo_dir]"
        o.on("-s", "--since DATE", "Count only commits since DATE (any git date: '6 months ago', 2025-01-01)") { options[:since] = it }
        o.on("-l", "--limit N", Integer, "Show the top N files (default 30)") { options[:limit] = it }
        o.on("-m", "--min-commits N", Integer, "Ignore files changed fewer than N times (default 3)") { options[:min_commits] = it }
        o.on("-i", "--ignore PATTERN", "Add an ignore: 'dir/' prefix or glob like '*.lock' (repeatable)") { options[:ignores] << it }
        o.on("--no-default-ignores", "Drop the built-in ignores (#{DEFAULT_IGNORES.join(' ')})") { options[:ignores] -= DEFAULT_IGNORES }
        o.on("--include-deleted", "Include files no longer present in the working tree") { options[:include_deleted] = true }
        o.on("-o", "--output FILE", "Write the report to FILE instead of stdout") { options[:output] = it }
        o.on("-v", "--version", "Print version and exit") { puts VERSION; exit }
        o.on("-h", "--help", "Print this help and exit") { puts o; exit }
      end

      repo = parser.parse(argv).first || Dir.pwd
      Options.new(repo:, **options)
    end

    def self.run(argv)
      options = parse(argv)
      repo    = Repo.new(options.repo)
      root    = repo.root

      result = LogParser.parse(repo.log(since: options.since))
      files  = Aggregator.file_stats(result.changes,
                                     ignores: options.ignores,
                                     min_commits: options.min_commits,
                                     existing_only: !options.include_deleted,
                                     root:)
      shown = files.first(options.limit)
      dirs  = Aggregator.dir_stats(files)

      meta = Meta.new(repo_name: File.basename(root),
                      branch: repo.branch,
                      window: options.since ? "since #{options.since}" : "entire history",
                      commits: result.commits,
                      total_files: files.size,
                      shown: shown.size,
                      ignores: options.ignores,
                      generated_on: Date.today.iso8601)

      markdown = Markdown.report(shown, dirs, meta)
      options.output ? File.write(options.output, markdown) : puts(markdown)
    rescue RuntimeError, OptionParser::ParseError => e
      warn "churn.rb: #{e.message}"
      exit 1
    end
  end
end

Churn::CLI.run(ARGV) if __FILE__ == $PROGRAM_NAME
