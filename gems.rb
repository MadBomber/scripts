#!/usr/bin/env ruby

$gems = Array.new

def gem(gem_name, version='')
  $gems << gem_name
end

# Using this form so that you can grab what you want for a Gemfile

gem 'address_extractor'       # Give it text.  It finds addresses in it.
gem 'awesome_print'           # Pretty print Ruby objects with proper indentation and colors
gem 'aws-sdk-s3'              # AWS SDK for Ruby - Amazon S3
#
gem 'bundler'                 # The best way to manage your application's dependencies
gem 'bunny'                   # Popular easy to use Ruby client for RabbitMQ
gem 'bible_gateway'           # An unofficial 'API' for BibleGateway.com.
#
gem 'cli_helper'              # An encapsulation of an integration of slop, nenv, inifile and configatron.
gem 'clipboard'               # Easy access to the clipboard on Linux, MacOS and Windows.
gem 'colortail'               # Tail a file and color lines based on regular expressions within that line
#
gem 'daemons'                 # A toolkit to create and control daemons in different ways
gem 'daru'                    # Data Analysis in RUby
gem 'daru-plotly'             # Draw graph with daru
gem 'debug_me'                # A tool to print the labeled value of variables.
gem 'did_you_mean'            # "Did you mean?" experience in Ruby
gem 'docopt'                  # A command line option parser, that will make you smile.
gem 'docx'                    # a ruby library/gem for interacting with .docx files
gem 'dotenv'                  # Loads environment variables from `.env`.
#
gem 'ect'                     # Methods ending in ect
gem 'email_address'           # This gem provides a ruby language library for working with and validating email addresses. By default, it validates against conventional usage, the format preferred for user email addresses. It can be configured to validate against RFC “Standard” formats, common email service provider formats, and perform DNS validation.
#
gem 'facter'                  # Facter, a system inventory tool
gem 'ffi-ncurses'             # An FFI wrapper around ncursesw 5.x for MRI Ruby 1.8.x, 1.9.x and JRuby.
#
gem 'geek_painter'            # A very simple DSL to generate a colored shell prompt string to use in *nix OS terminals
gem 'git-up'                  # git command to fetch and rebase all branches
gem 'github_api'              # Ruby client for the official GitHub API
gem 'guard'                   # Guard keeps an eye on your file modifications
gem 'guard-annotate'          # Guard gem for annotate
gem 'guard-brakeman'          # Guard gem for Brakeman
gem 'guard-bundler'           # Guard gem for Bundler
gem 'guard-bundler-audit'     # guard + bundler-audit = security
gem 'guard-chef'              # Guard gem for Chef
gem 'guard-migrate'           # Guard gem for rails migrations
gem 'guard-minitest'          # Guard plugin for the Minitest framework
gem 'guard-redis'                 # Guard gem for Redis
gem 'guard-rspec'                 # Guard gem for RSpec
gem 'guard-rubocop'               # Guard plugin for RuboCop
gem 'guard-rubybeautify'          # Clean up ruby files with ruby beautify.
gem 'guard-rubycritic'            # Listens to modifications and detects smells in Ruby files
gem 'guard-s3'                    # A simple guard library for syncing files with s3
gem 'guard-shell'                 # Guard gem for running shell commands
gem 'guard-sidekiq'               # guard gem for sidekiq
#
gem 'htmlentities'            # Encode/decode HTML entities
#
gem 'inspec'                  # Infrastructure and compliance testing.
gem 'irbtools'                # Irbtools happy IRB.
gem 'irbtools-more'           # irbtools-more adds bond and looksee to IRB.
#
gem 'jira-ruby'               # Ruby Gem for use with the Atlassian JIRA REST API
gem 'jirasync'                # jirasync synchronises jira projects to the local file system
gem 'json'                    # This json is bundled with Ruby
#
gem 'linefit'                 # LineFit is a linear regression math class.
gem 'lipsum'                  # Get placeholder text from lipsum.com
gem 'log_analyzer'            # log_analyzer gem is created to get statistics about your views rendering performance.
#
gem 'mail'                    # Mail provides a nice Ruby DSL for making, sending and reading emails.
gem 'mini_sql'                # A fast, safe, simple direct SQL executor
#
gem 'nenv'                    # Convenience wrapper for Ruby's ENV
gem 'nokogiri'                # Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser
#
gem 'ocassionally'            # Ocassionally it works; and, ocassionally it doesn't
gem 'ohai'                    # Ohai profiles your system and emits JSON
gem 'os'                      # Simple and easy way to know if you're on windows or not (reliably), as well as how many bits the OS is, etc.
#
gem 'pericope'                # Pericope is a gem for parsing Bible references.
gem 'pg'                      # Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
gem 'pgsync'                  # Sync Postgres data between databases
gem 'pragmatic_segmenter'     # A rule-based sentence boundary detection gem that works out-of-the-box across many languages
gem 'progress_bar'            # Simple Progress Bar for output to a terminal
#
gem 'rack-attack'             # Block & throttle abusive requests
gem 'rails', '~> 5.2'         # Full-stack web application framework.
gem 'rethinkdb_helper'        # A wrapper around the ruby rethinkdb gem
gem 'rssable'                 # Access the RSS channel of any webiste without worrying about the engine
gem 'ruby-progressbar'        # never leave the user guessing
#
gem 'sanitize'                # Whitelist-based HTML and CSS sanitizer.
gem 'sketches'                # Sketches allows you to create and edit Ruby code from the comfort of your editor, while having it safely reloaded in IRB whenever changes to the code are saved.
gem 'sinatra'                 # Classy web-development dressed in a DSL
gem 'slop'                    # Simple Lightweight Option Parsing
gem 'sugar_refinery'          # The Ruby Sugar Refinery is a collection of tiny refinements.
gem 'summary'                 # This is a simple gem that generates introduction text from a long text, it will always break the text at the end of the last word near to the limit you informed as argument.
gem 'svn_wc'                  # operates on a working copy (on the local filesystem) of a remote Subversion repository.
gem 'sys-proctable'           # An interface for providing process table information
gem 'systemu'                 # systemu
#
gem 'terminal-size'           # A tiny gem to accomplish a simple task: Determining the terminal size.
gem 'test-kitchen'            # Test Kitchen is an integration tool for developing and testing infrastructure code and software on isolated target platforms.
gem 'transitions'             # State machine extracted from ActiveModel
#
gem 'virtualbox'              # Support functions for VM
#
gem 'wharel'                  # Arel + Where = Wharel
gem 'word_wrap'               # Simple tool for word-wrapping text
gem 'word_wrapper'            # Pure ruby word wrapping
gem 'wordy'                   # Written to help us create sample data for our applications, Wordy speaks in lorem ipsum. You can ask Wordy for paragraphs, sentences or words.
#

gem_list = $gems.join(' ')

if ARGV.empty?
  system "gemt #{gem_list}"
else
  installed_gems = Gem::Specification.all.map { |gs| gs.name }

  if %w{ -i --install }.include?ARGV.first
    missing_gems = $gems.select{ |gem_name| !installed_gems.include?(gem_name)}.join(' ')
    if missing_gems.empty?
      puts "All gems are already installed"
    else
      command = "gem install #{missing_gems}"
      puts command
      system command
    end
  end
end

__END__
# Version Conflicts with Rails 5.2
gem 'guard-rails_best_practices'  # Guard for rails_best_practices, a code metric tool to check the quality of rails code.
gem 'terjira'                 # Terjira is interactive command line application for Jira


# Problems ...... just old stuff which needs updating
gem 'gruff'                   # Beautiful graphs for one or multiple datasets.
gem 'phashion'                # Simple wrapper around the pHash library - precepual hashing to find dup images
gem 'rmagick'                 # Ruby binding to ImageMagick
