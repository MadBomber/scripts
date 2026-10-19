#!/usr/bin/env ruby
# note.rb
#
#   The system environment variable $EDITOR must be set to a text editor
#
# typical usage is to alias this program to a single character...
#   alias _='~/scripts/note.rb'
#
# External System Commands Used:
#   pbpaste - clipboard (Mac-exclusive)
#   mdfind  - Spotlight search (Mac-exclusive)
#   xargs
#   agrep   - TRE agrep (brew install tre); not the amatch gem's agrep
#   pr
#
# TODO: add a second sink to write_entry so every note is also inserted
#       into an sqlite3 database in $HOME.
# TODO: refactor this utility to use the power of obsidian and
#       its daily notes system to become a more powerful PKM.

require 'pathname'   # STDLIB
require 'shellwords' # STDLIB

class NoteManager
  NOTES_FILENAME   = "_notes.md"

  # The amatch gem installs an incompatible agrep that can shadow TRE's on PATH
  TRE_AGREP = "/opt/homebrew/bin/agrep"
  AGREP     = File.executable?(TRE_AGREP) ? TRE_AGREP : "agrep"

  # An exact-name query keeps backups such as _notes.md.bak out of the results
  SPOTLIGHT_QUERY = "kMDItemFSName == '#{NOTES_FILENAME}'"

  SEARCH_MODES = { '-p' => :paragraph, '--paragraph' => :paragraph,
                   '-e' => :entry,     '--entry'     => :entry }.freeze

  Entry  = Data.define(:time, :text, :stdin, :clipboard)
  Record = Data.define(:line, :text)

  # home:      Pathname of the directory where the search up the tree stops
  # cwd:       Pathname where the search for a notes file starts
  # editor:    String from $EDITOR; may contain arguments ("code -w")
  # clipboard: callable returning the clipboard contents as a String
  # stdin:     IO that is read when it is not a terminal
  # runner:    callable that executes a command array (system by default)
  # clock:     callable returning the current time
  # finder:    callable returning the paths of every notes file
  def initialize(home: Pathname.new(ENV['HOME']),
                 cwd: Pathname.pwd,
                 editor: ENV['EDITOR'],
                 clipboard: -> { `pbpaste` },
                 stdin: $stdin,
                 out: $stdout,
                 err: $stderr,
                 runner: ->(*cmd) { system(*cmd) },
                 clock: -> { Time.now },
                 finder: -> { `mdfind -0 #{Shellwords.escape(SPOTLIGHT_QUERY)} 2>/dev/null`.split("\0") })
    @home      = home
    @cwd       = cwd
    @editor    = editor
    @clipboard = clipboard
    @stdin     = stdin
    @out       = out
    @err       = err
    @runner    = runner
    @clock     = clock
    @finder    = finder
  end

  # Returns the process exit status.
  def run(args)
    command, arg, mode = parse(args)

    case command
    when :help   then @out.puts usage; 0
    when :error  then @err.puts "ERROR: #{arg}"; 1
    when :init   then init_notes_file(@cwd)
    when :search  then search_notes(arg, mode)
    when :compose then compose_note
    else               add_note(arg)
    end
  end

  # Returns [command, argument]
  def parse(args)
    return [:note, []] if args.empty?

    case args.first.downcase
    when '-h', '--help'
      [:help]
    when '-'
      args.size == 1 ? [:compose] : [:note, args]
    when '--init'
      args.size == 1 ? [:init] : [:error, "--init does not take any other arguments."]
    when '-s', '--search'
      terms = args.drop(1)
      mode  = SEARCH_MODES.fetch(terms.first&.downcase, :line)
      terms = terms.drop(1) unless mode == :line
      terms.empty? ? [:error, "no search terms were entered."] : [:search, terms.join(' '), mode]
    else
      [:note, args]
    end
  end

  def usage
    <<~EOS

      Keep and search engineering notes.  Notes are stored in markdown files
      named "#{NOTES_FILENAME}".  A note goes into the closest #{NOTES_FILENAME}
      found by searching up the directory tree from the current directory,
      stopping at $HOME where one is created if necessary.

      Usage:

      alias _=#{$0}

      _ [-h|--help]   Prints this usage text

      _ --init        Creates #{NOTES_FILENAME} in the current directory.  The first
                      line of the file is "# <path-to-file>"

      _               Adds a timestamp (and the clipboard) to the closest
                      #{NOTES_FILENAME} and opens it in $EDITOR

      _ <any text>    Adds <any text> and the clipboard to the closest file

      cmd | _         Adds the output of cmd and the clipboard to the closest file

      _ -             Reads a multi-paragraph note from stdin until Ctrl-D and
                      adds it (and the clipboard) as markdown, not as a fence.
                      Ctrl-C cancels without adding anything.

      _ [-s|--search] <terms>
                      Searches all '#{NOTES_FILENAME}' files using the 'agrep' command
                      and shows each matching line

      _ [-s|--search] [-p|--paragraph] <terms>
                      Shows each matching paragraph (lines between blank lines)

      _ [-s|--search] [-e|--entry] <terms>
                      Shows each matching entry, from its "## <time>" heading
                      to the next one

                      <terms> is a regular expression, matched case-sensitively

    EOS
  end

  # Creates a notes file in dir whose first line is "# <path-to-file>".
  # An existing file is never modified.
  def init_notes_file(dir)
    notes_file = dir.join(NOTES_FILENAME)

    File.open(notes_file, File::WRONLY | File::CREAT | File::EXCL) do |f|
      f.print "# #{notes_file}\n\n"
    end
    @out.puts "Created #{notes_file}"
    0
  rescue Errno::EEXIST
    @out.puts "#{notes_file} already exists."
    0
  rescue SystemCallError => e
    @err.puts "ERROR: could not create #{notes_file}: #{e.message}"
    1
  end

  # Walks up from start looking for a notes file; stops at home.
  def find_notes_file(start)
    start.ascend do |dir|
      candidate = dir.join(NOTES_FILENAME)
      return candidate if candidate.exist?
      break if dir == @home
    end

    @home.join(NOTES_FILENAME)
  end

  # mdfind's stderr is locale-loading noise.
  def search_command(search_terms, agrep: AGREP)
    query = Shellwords.escape(SPOTLIGHT_QUERY)
    "mdfind -0 #{query} 2>/dev/null | xargs -0 #{agrep} -n #{Shellwords.escape(search_terms)} | pr -td"
  end

  def search_notes(search_terms, mode = :line)
    @out.puts "\nSearching for #{search_terms} ..."
    if mode == :line
      @runner.call(search_command(search_terms))
      return 0
    end

    pattern = search_pattern(search_terms)
    @finder.call.each do |path|
      text = File.read(path).scrub
      matching_records(text, mode, pattern).each { |record| @out.print format_hit(path, record) }
    rescue SystemCallError => e
      @err.puts "Warning: could not read #{path}: #{e.message}"
    end
    0
  end

  # agrep treats terms as a regular expression; an invalid one is taken literally.
  def search_pattern(search_terms)
    Regexp.new(search_terms)
  rescue RegexpError
    Regexp.new(Regexp.escape(search_terms))
  end

  def matching_records(text, mode, pattern)
    records = mode == :entry ? entry_records(text) : paragraph_records(text)
    records.select { |record| pattern.match?(record.text) }
  end

  # Runs of non-blank lines; line is where the paragraph starts.
  def paragraph_records(text)
    text.each_line.with_index(1)
        .slice_when { |(a, _), (b, _)| a.strip.empty? != b.strip.empty? }
        .reject     { |chunk| chunk.first.first.strip.empty? }
        .map        { |chunk| to_record(chunk) }
  end

  # Each "## <time>" heading through the line before the next one.  Text
  # before the first heading (the "# <path>" header) is its own record.
  def entry_records(text)
    text.each_line.with_index(1)
        .slice_before { |line, _| line.start_with?('## ') }
        .map          { |chunk| to_record(chunk) }
  end

  def to_record(numbered_lines)
    Record.new(line: numbered_lines.first.last, text: numbered_lines.map(&:first).join)
  end

  # Mirrors agrep -n's "path:line:" prefix, with the record on its own lines.
  def format_hit(path, record)
    "#{path}:#{record.line}:\n#{record.text.strip}\n\n"
  end

  def add_note(words)
    notes_file = find_notes_file(@cwd)
    piped      = read_stdin
    entry      = build_entry(words, piped)

    write_entry(notes_file, entry)
    open_in_editor(notes_file) if words.empty? && piped.empty?
    0
  end

  # Typed (or piped) prose becomes the entry's text, so its paragraphs
  # stay markdown instead of being fenced like command output.
  def compose_note
    @err.puts "Enter your note.  Press Ctrl-D on an empty line to save, Ctrl-C to cancel." if @stdin.tty?
    text = @stdin.read.to_s.scrub

    if text.strip.empty?
      @err.puts "Nothing entered; no note added."
    else
      write_entry(find_notes_file(@cwd), build_entry([text]))
    end
    0
  rescue Interrupt
    @err.puts "\nCancelled; no note added."
    130
  end

  def build_entry(words, piped = "")
    Entry.new(time:      @clock.call,
              text:      words.join(' '),
              stdin:     piped,
              clipboard: read_clipboard)
  end

  # The single place where a note is persisted.
  def write_entry(notes_file, entry)
    File.open(notes_file, "a") { |f| f.print format_entry(entry) }
  end

  # Markdown: an H2 per entry, typed text as a paragraph, and pasted
  # content (stdin, clipboard) each in a plain fence.
  def format_entry(entry)
    parts = [entry.text.strip, fence(entry.stdin), fence(entry.clipboard)]
    body  = parts.reject(&:empty?).join("\n\n")

    "\n## #{entry.time}\n\n#{body}\n\n"
  end

  # Wraps text in a plain fence that is longer than any backtick run
  # inside the text.  Blank text yields an empty string.
  def fence(text)
    return "" if text.strip.empty?

    longest = text.scan(/`+/).map(&:size).max || 0
    marker  = "`" * [3, longest + 1].max

    "#{marker}\n#{text.chomp}\n#{marker}"
  end

  def read_stdin
    return "" if @stdin.nil? || @stdin.tty?

    @stdin.read.to_s.scrub
  end

  def read_clipboard
    @clipboard.call.to_s.scrub
  rescue => e
    @err.puts "Warning: Could not paste clipboard: #{e.message}"
    ""
  end

  def editor_command(notes_file)
    return nil if @editor.nil? || @editor.strip.empty?

    Shellwords.split(@editor) + [notes_file.to_s]
  end

  def open_in_editor(notes_file)
    command = editor_command(notes_file)

    if command.nil?
      @err.puts "Warning: $EDITOR environment variable not set"
    elsif @runner.call(*command).nil?
      @err.puts "Error launching editor: #{command.first}"
      @err.puts "Please check your $EDITOR environment variable"
    end
  end
end

# Main execution
if __FILE__ == $0
  exit NoteManager.new.run(ARGV)
end
