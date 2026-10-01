#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Moves fork working directories out of the local _forks directory to an
# offline volume, then replaces the local directory with a symlink to the
# offline copy.
#
# Usage:
#   ruby move_fork_offline.rb --list
#   ruby move_fork_offline.rb <repo_name> [<repo_name> ...]
#   ruby move_fork_offline.rb --all
#   ruby move_fork_offline.rb --all --dry-run
#
# Options:
#   --all        Process every fork directory that isn't already a symlink
#   --dry-run    Print what would happen; do not touch the filesystem
#   --force      Overwrite an existing directory/file at the target path
#   --list       List candidate fork directories and exit

require 'fileutils'

class ForkOfflineMover
  SOURCE_ROOT = '/Users/dewayne/sandbox/git_repos/madbomber/_forks'
  TARGET_ROOT = '/Volumes/projects/madbomber/_forks'

  MoveError = Class.new(StandardError)

  def initialize(source_root: SOURCE_ROOT, target_root: TARGET_ROOT)
    @source_root = source_root
    @target_root = target_root
  end

  # Names of real (non-symlink) directories under source_root, excluding
  # dotfiles. These are the candidates eligible to be moved offline.
  def fork_names
    Dir.children(@source_root)
       .reject { |name| name.start_with?('.') }
       .select { |name| candidate?(name) }
       .sort
  end

  def candidate?(name)
    path = File.join(@source_root, name)
    File.directory?(path) && !File.symlink?(path)
  end

  def source_path(name)
    File.join(@source_root, name)
  end

  def target_path(name)
    File.join(@target_root, name)
  end

  # Raises MoveError if this fork cannot be safely moved.
  def validate!(name, force:)
    src = source_path(name)
    tgt = target_path(name)

    raise MoveError, "target volume not mounted: #{@target_root}" unless Dir.exist?(@target_root)
    raise MoveError, "no such source directory: #{src}" unless Dir.exist?(src)
    raise MoveError, "source is already a symlink: #{src}" if File.symlink?(src)

    return unless File.exist?(tgt) && !force

    raise MoveError, "target already exists (use --force to overwrite): #{tgt}"
  end

  # Copies the source directory to the target path, preserving file metadata.
  def copy_fork(name)
    src = source_path(name)
    tgt = target_path(name)

    FileUtils.rm_rf(tgt) if File.exist?(tgt)
    FileUtils.mkdir_p(File.dirname(tgt))
    FileUtils.cp_r(src, tgt, preserve: true)
  end

  # Confirms the copy is byte-for-byte identical to the source using `diff`.
  def verify_copy(name)
    src = source_path(name)
    tgt = target_path(name)

    system('diff', '-rq', src, tgt, out: File::NULL, err: File::NULL)
  end

  # Deletes the source directory and replaces it with a symlink to target.
  def replace_with_symlink(name)
    src = source_path(name)
    tgt = target_path(name)

    FileUtils.rm_rf(src)
    File.symlink(tgt, src)
  end

  def symlink_valid?(name)
    src = source_path(name)
    File.symlink?(src) && File.directory?(src) && File.realpath(src) == target_path(name)
  end

  # Runs the full move for one fork. Returns true on success.
  def move_fork(name, dry_run: false, force: false)
    validate!(name, force: force)

    if dry_run
      puts "[dry-run] would move #{source_path(name)} -> #{target_path(name)}"
      return true
    end

    puts "copying #{name} to offline volume..."
    copy_fork(name)

    unless verify_copy(name)
      raise MoveError, "verification failed, offline copy does not match source: #{name}"
    end

    replace_with_symlink(name)

    unless symlink_valid?(name)
      raise MoveError, "symlink verification failed after replace: #{name}"
    end

    puts "moved #{name} offline and linked #{source_path(name)} -> #{target_path(name)}"
    true
  end
end

def parse_args(argv)
  options = { all: false, dry_run: false, force: false, list: false, names: [] }

  argv.each do |arg|
    case arg
    when '--all'      then options[:all] = true
    when '--dry-run'  then options[:dry_run] = true
    when '--force'    then options[:force] = true
    when '--list'     then options[:list] = true
    else                   options[:names] << arg
    end
  end

  options
end

def main
  options = parse_args(ARGV)
  mover = ForkOfflineMover.new

  if options[:list]
    puts mover.fork_names
    return
  end

  names = options[:all] ? mover.fork_names : options[:names]

  if names.empty?
    puts <<~USAGE
      Usage:
        ruby move_fork_offline.rb --list
        ruby move_fork_offline.rb <repo_name> [<repo_name> ...]
        ruby move_fork_offline.rb --all [--dry-run] [--force]
    USAGE
    return
  end

  results = { moved: [], failed: [] }

  names.each do |name|
    mover.move_fork(name, dry_run: options[:dry_run], force: options[:force])
    results[:moved] << name
  rescue ForkOfflineMover::MoveError => e
    warn "SKIP #{name}: #{e.message}"
    results[:failed] << name
  end

  puts <<~SUMMARY
    Done. #{results[:moved].size} moved, #{results[:failed].size} failed.
    #{"(dry run, nothing was changed)" if options[:dry_run]}
  SUMMARY
end

main if __FILE__ == $PROGRAM_NAME
