# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb', 'test/**/test_*.rb'].exclude('**/*_helper.rb')
  t.verbose = true
  t.ruby_opts << '-rtest_helper'
end

task default: :test

desc 'Run tests with verbose output'
task :test_verbose do
  ENV['TESTOPTS'] = '--verbose'
  Rake::Task[:test].invoke
end

desc 'Run a single test file'
task :test_file, [:file] do |_t, args|
  ruby "test/#{args[:file]}"
end

desc 'Check code complexity with Flog (warn >=20, fail >=50)'
task :flog_check do
  require 'flog'

  method_warn = 20.0
  method_fail = 50.0

  flogger = Flog.new(all: true)
  flogger.flog(*Dir.glob('lib/**/*.rb'))

  warnings = []
  failures = []

  flogger.each_by_score do |method, score|
    next if method.end_with?('#none')

    if score > method_fail
      failures << "#{format('%.1f', score)}: #{method}"
    elsif score > method_warn
      warnings << "#{format('%.1f', score)}: #{method}"
    end
  end

  unless warnings.empty?
    puts "\nFlog warnings (#{method_warn}–#{method_fail}) — target for future refactoring:"
    warnings.each { |v| puts "  #{v}" }
  end

  if failures.empty?
    puts "\nFlog: no methods exceed the failure threshold (>=#{method_fail})"
  else
    puts "\nFlog failures (>=#{method_fail}) — must be refactored:"
    failures.each { |v| puts "  #{v}" }
    abort "\nFlog quality gate failed: #{failures.size} method(s) exceed #{method_fail}"
  end
end

desc 'Check for structural code duplication with Flay (mass >= 50)'
task :flay_check do
  require 'flay'

  mass_threshold = 50

  flay = Flay.new({ mass: mass_threshold, diff: false, verbose: false, summary: false, timeout: 60 })
  flay.process(*Dir.glob('lib/**/*.rb'))
  flay.analyze

  if flay.hashes.empty?
    puts "\nFlay: no structural duplication detected (mass >= #{mass_threshold})"
  else
    puts "\nFlay found structural duplication (mass >= #{mass_threshold}):"
    flay.report
    abort "\nFlay quality gate failed: #{flay.hashes.length} pattern(s) detected"
  end
end

desc 'Run all quality checks: tests (with coverage), RuboCop, Flog, and Flay'
task :quality do
  gates = [
    ['Tests + Coverage', 'bundle exec rake test'],
    ['RuboCop',          'bundle exec rubocop'],
    ['Flog Complexity',  'bundle exec rake flog_check'],
    ['Flay Duplication', 'bundle exec rake flay_check']
  ]

  results = gates.map do |label, command|
    puts "\n#{'=' * 60}"
    puts "Quality Gate: #{label}"
    puts '=' * 60
    [label, system(command) ? :pass : :fail]
  end

  green = ->(s) { "\e[32m#{s}\e[0m" }
  red   = ->(s) { "\e[31m#{s}\e[0m" }
  width = results.map { |label, _| label.length }.max

  puts "\n#{'=' * 60}"
  puts 'Quality Gate Summary'
  puts '=' * 60
  results.each do |label, status|
    badge = status == :pass ? green.call('PASS') : red.call('FAIL')
    puts "  [#{badge}] #{label.ljust(width)}"
  end
  puts '-' * 60

  passed = results.count { |_, s| s == :pass }
  failed = results.count { |_, s| s == :fail }
  tally  = "#{passed} passed, #{failed} failed"
  puts "  #{failed.zero? ? green.call(tally) : red.call(tally)}"
  puts '=' * 60

  abort "\n#{red.call('Quality gate failed.')}" unless failed.zero?
  puts "\n#{green.call('All quality gates passed.')}"
end

namespace :docs do
  desc 'Build MkDocs documentation'
  task :build do
    sh 'mkdocs build'
  end

  desc 'Serve MkDocs documentation locally on http://localhost:8000'
  task :serve do
    sh 'mkdocs serve'
  end
end
