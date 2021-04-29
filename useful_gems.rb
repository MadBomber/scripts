#!/usr/bin/env ruby
# ~/scripts/useful_gems.rb
# A list of gems that are useful, interesting or both.
# I typically keep these gems in my global gemset.  When working
# on specific projects I use a project-specific gemset which only
# includes the gems used in that project within a classic Gemfile.
#
# This list is maintained mostly in alphabetic order; however,
# there are sometimes when grouped by some category
# makes more sense.
#
#
# Last reviewed for Ruby v3.0.1-p64
#

system "gem install os"

require 'os'
require 'yaml' # STDLIB

$gems = Array.new

def gem(gem_name, version='')
  $gems << gem_name
end

# Using this form so that you can grab what you want for a Gemfile

# my gems ...
gem 'cli_helper'              # An encapsulation of an integration of slop, nenv, inifile and configatron.
gem 'debug_me'                # A tool to print the labeled value of variables.
gem 'rethinkdb_helper'        # A wrapper around the ruby rethinkdb gem
#
# Geospatial libraries
#
# geohash divides the world up into squars
# Uber's H3 divides the world up into hexagons
#
# !3.0.0-p1 gem 'geohash36'               # Commandline interface and library to the Geohash36 Algorithm
# h3 requires the 'cmake' package; use brew, dnf, yum, apt=get etc
unless OS.linux?
  gem 'h3'                      # C Bindings for Uber's H3 library
end


#
# Profilers
#
gem 'rack-mini-profiler'  # Profiles loading speed for rack applications.
gem 'memory_profiler'     # Memory profiling routines for Ruby 2.1+
gem 'flamegraph'          # Flamegraph support for arbitrary ruby apps
gem 'stackprof'           # sampling callstack-profiler for ruby 2.1+

#####################################
# Stuff in alphabetic order
#
gem 'active_record_extended'  # Adds extended functionality to Activerecord Postgres implementation
gem 'active_record_union'     # UNIONs in ActiveRecord! Adds proper union and union_all methods to ActiveRecord::Relation.
gem 'activerecord-import'     # Bulk insert extension for ActiveRecord
gem 'address_extractor'       # Give it text.  It finds addresses in it.
gem 'ahoy_matey'              # Simple, powerful analytics for Rails
gem 'amazing_print'           # Pretty print Ruby objects with proper indentation and colors
gem 'any_login'               # AnyLogin is created to speedup development process and allow developer's quickly login as any user in DB.
gem 'anycable'                # AnyCable is a polyglot replacement for ActionCable-compatible servers
gem 'anycable-rails'          # Rails adapter for AnyCable
gem 'apexcharts'              # Awesome charts for your ruby app
gem 'aws-sdk-s3'              # AWS SDK for Ruby - Amazon S3
#
gem 'bible_gateway'           # An unofficial 'API' for BibleGateway.com.
gem 'blazer'                  # Explore your data with SQL. Easily create charts and dashboards, and share them with your team.
gem 'bond'                    # used in IRB completions
gem 'bundler'                 # The best way to manage your application's dependencies
gem 'bundler-audit'           # Patch-level verification for Bundler
gem 'bunny'                   # Popular easy to use Ruby client for RabbitMQ
#
gem 'cancancan'               # Simple authorization solution for Rails.
gem 'chartkick'               # Create beautiful JavaScript charts with one line of Ruby
gem 'clipboard'               # Easy access to the clipboard on Linux, MacOS and Windows.
gem 'colortail'               # Tail a file and color lines based on regular expressions within that line
gem 'concurrent-ruby'         # Modern concurrency tools for Ruby. Inspired by Erlang, Clojure, Scala, Haskell, F#, C#, Java, and classic concurrency patterns.
gem 'concurrent-ruby-ext'     # C extensions to optimize concurrent-ruby under MRI.
gem 'concurrent-ruby-edge'    # Edge features and additions to the concurrent-ruby gem.
#
gem 'daemons'                 # A toolkit to create and control daemons in different ways
gem 'daru'                    # Data Analysis in RUby
gem 'daru-plotly'             # Draw graph with daru
gem 'did_you_mean'            # "Did you mean?" experience in Ruby
gem 'docopt'                  # A command line option parser, that will make you smile.
gem 'docx'                    # a ruby library/gem for interacting with .docx files
gem 'dotenv'                  # Loads environment variables from `.env`.
#
gem 'dry-configurable'        # A mixin to add configuration functionality to your classes
gem 'dry-container'           # A simple container intended for use as an IoC container
gem 'dry-core'                # A toolset of small support modules used throughout the dry-rb ecosystem.
gem 'dry-equalizer'           # Module to define equality, equivalence and inspection methods
gem 'dry-graphql'             # Integrate dry-types/dry-struct with graphql-ruby
gem 'dry-inflector'           # DRY Inflector
gem 'dry-initializer'         # DSL for declaring params and options of the initializer
gem 'dry-logic'               # Predicate logic with rule composition
gem 'dry-schema'              # Coercion and validation for data structures
gem 'dry-struct'              # Typed structs and value objects.
gem 'dry-types'               # Type system for Ruby supporting coercions, constraints and complex types like structs, value objects, enums etc.
#
gem 'ect'                     # Methods ending in ect
gem 'email_address'           # This gem provides a ruby language library for working with and validating email addresses. By default, it validates against conventional usage, the format preferred for user email addresses. It can be configured to validate against RFC “Standard” formats, common email service provider formats, and perform DNS validation.
gem 'event_bus'               # A simple pubsub event bus for Ruby applications
#
#v3.0.0 gem 'facter'                  # Facter, a system inventory tool
gem 'falcon'                  # A fast, asynchronous, rack-compatible web server.
gem 'fast_jsonparser'         # Fast Json Parser
gem 'ffi-ncurses'             # An FFI wrapper around ncursesw 5.x for MRI Ruby 1.8.x, 1.9.x and JRuby.
gem 'fx'                      # Support for database functions and triggers in Rails migrations
#
gem 'geek_painter'            # A very simple DSL to generate a colored shell prompt string to use in *nix OS terminals
gem 'geospatial'              # Provides abstractions for dealing with geographical locations efficiently
gem 'git-up'                  # git command to fetch and rebase all branches
gem 'github_api'              # Ruby client for the official GitHub API
gem 'graphql'                 # A GraphQL language and runtime for Ruby
gem 'graphql_rails'           # GraphQL server and client for rails
gem 'graphiti'                # Easily build jsonapi.org-compatible APIs
gem 'guard'                   # Guard keeps an eye on your file modifications
gem 'guard-annotate'          # Guard gem for annotate
gem 'guard-brakeman'          # Guard gem for Brakeman
gem 'guard-bundler'           # Guard gem for Bundler
gem 'guard-bundler-audit'     # guard + bundler-audit = security
gem 'guard-chef'              # Guard gem for Chef
gem 'guard-migrate'           # Guard gem for rails migrations
gem 'guard-minitest'          # Guard plugin for the Minitest framework
gem 'guard-rails_best_practices'  # Guard for rails_best_practices, a code metric tool to check the quality of rails code.
gem 'guard-redis'             # Guard gem for Redis
gem 'guard-rspec'             # Guard gem for RSpec
gem 'guard-rubocop'           # Guard plugin for RuboCop
gem 'guard-rubycritic'        # Listens to modifications and detects smells in Ruby files
gem 'guard-s3'                # A simple guard library for syncing files with s3
gem 'guard-shell'             # Guard gem for running shell commands
gem 'guard-sidekiq'           # guard gem for sidekiq
#
gem 'haml-rails'              # let your Gemfile do the configuring
gem 'holidays'                # A collection of Ruby methods to deal with statutory and other holidays.
gem 'htmlentities'            # Encode/decode HTML entities
#
gem 'inspec'                  # Infrastructure and compliance testing.
gem 'iodine'                  # iodine - a fast HTTP / Websocket Server with Pub/Sub support, optimized for Ruby MRI on Linux / BSD
gem 'irbtools'                # Irbtools happy IRB.
# 270p3 gem 'irbtools-more'           # adds bond and looksee to IRB.
gem 'jira-ruby'               # Ruby Gem for use with the Atlassian JIRA REST API
gem 'jirasync'                # jirasync synchronises jira projects to the local file system
gem 'json'                    # This json is bundled with Ruby
#
gem 'linefit'                 # LineFit is a linear regression math class.
gem 'lipsum'                  # Get placeholder text from lipsum.com
gem 'log_analyzer'            # log_analyzer gem is created to get statistics about your views rendering performance.
#
gem 'mail'                    # Mail provides a nice Ruby DSL for making, sending and reading emails.
gem 'meta-tags'               # Collection of SEO helpers for Ruby on Rails.
gem 'mini_sql'                # A fast, safe, simple direct SQL executor
#
gem 'nenv'                    # Convenience wrapper for Ruby's ENV
gem 'nokogiri'                # Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser
#
gem 'object_shadow'           # Metaprogramming Level 2
gem 'ocassionally'            # Ocassionally it works; and, ocassionally it doesn't
gem 'ohai'                    # Ohai profiles your system and emits JSON
gem 'optimist'                # Optimist is a commandline option parser for Ruby that just gets out of your way.
gem 'os'                      # Simple and easy way to know if you're on windows or not (reliably), as well as how many bits the OS is, etc.
#
gem 'pagy'                    # The Ultimate Pagination Ruby Gem
gem 'pagy_cursor'             # cursor paginations for pagy
gem 'paper_trail'             # Track changes to your models.
gem 'pericope'                # Pericope is a gem for parsing Bible references.
gem 'pg'                      # Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
gem 'pg_search'               # builds Active Record named scopes that take advantage of PostgreSQL's full text search
gem 'pgsync'                  # Sync Postgres data between databases
gem 'power_assert'            # Power Assert for Ruby
gem 'pragmatic_segmenter'     # A rule-based sentence boundary detection gem that works out-of-the-box across many languages
gem 'progress_bar'            # Simple Progress Bar for output to a terminal
gem 'prosopite'               # N+1 auto-detection for Rails with zero false positives / false negatives
gem 'pundit'                  # OO authorization for Rails
gem 'puma'                    # Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications
gem 'pycall'                  # Call python functions from Ruby
#
gem 'rack-attack'             # Block & throttle abusive requests
gem 'rails', '~> 5.2'         # Full-stack web application framework.
gem 'rails-erd'               # Entity-relationship diagram for your Rails models.
gem 'reform'                  # Form object decoupled from models with validation, population and presentation.
gem 'rexe'                    # Ruby Command Line Executor
gem 'rgeo'                    # RGeo is a geospatial data library for Ruby.
gem 'rom'                     # Persistence and mapping toolkit for Ruby
gem 'rom-sql'                 # SQL databases support for ROM
gem 'rssable'                 # Access the RSS channel of any webiste without worrying about the engine
gem 'rubocop'                 # Automatic Ruby code style checking tool.
gem 'rubocop-performance'     # Automatic performance checking tool for Ruby code.
gem 'ruby_crystal_codemod'    # Ruby => Crystal codemod
gem 'ruby-progressbar'        # never leave the user guessing
gem 'rubyfmt'                 # Ruby port of gofmt
gem 'rubytoolbox-api'         # A simple, dependency-free API client for The Ruby Toolbox
gem 'rufo'                    # Ruby code formatter
#
gem 'sail'                    # Sail will help you navigate your Rails application.
gem 'sanitize'                # Whitelist-based HTML and CSS sanitizer.
gem 'scenic'                  # Support for database views in Rails migrations
gem 'searchkick'              # Intelligent search made easy with Rails and Elasticsearch
gem 'semantic_logger'         # Feature rich logging framework, and replacement for existing Ruby & Rails loggers.
gem 'sketches'                # Sketches allows you to create and edit Ruby code from the comfort of your editor, while having it safely reloaded in IRB whenever changes to the code are saved.
gem 'sidekiq'                 # Simple, efficient background processing for Ruby
gem 'sidekiq-scheduler'       # Light weight job scheduling extension for Sidekiq
gem 'sinatra'                 # Classy web-development dressed in a DSL
gem 'slop'                    # Simple Lightweight Option Parsing
gem 'smarter_csv'             # Ruby Gem for smarter importing of CSV Files (and CSV-like files), with lots of optional features, e.g. chunked processing for huge CSV files
gem 'spreadsheet_architect'   # Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets easily from ActiveRecord relations, Plain Ruby classes, or predefined data.
gem 'squasher'                # Squash your old migrations
gem 'store_model'             # Gem for working with JSON-backed attributes as ActiveRecord models
gem 'sugar_refinery'          # The Ruby Sugar Refinery is a collection of tiny refinements.
gem 'summary'                 # This is a simple gem that generates introduction text from a long text, it will always break the text at the end of the last word near to the limit you informed as argument.
gem 'svn_wc'                  # operates on a working copy (on the local filesystem) of a remote Subversion repository.
gem 'sys-proctable'           # An interface for providing process table information
gem 'systemu'                 # systemu
#
gem 'terjira'                 # Terjira is interactive command line application for Jira
gem 'terminal-size'           # A tiny gem to accomplish a simple task: Determining the terminal size.
gem 'test-kitchen'            # Test Kitchen is an integration tool for developing and testing infrastructure code and software on isolated target platforms.
gem "timecop"                 # A gem providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code.  It provides a unified method to mock Time.now, Date.today, and DateTime.now in a single call.
gem 'transitions'             # State machine extracted from ActiveModel
gem 'trick_bag'               # Miscellaneous general useful tools.
#
# 3.0.0 gem 'virtualbox'              # Support functions for VM
#
gem 'wharel'                  # Arel + Where = Wharel
gem 'word_wrap'               # Simple tool for word-wrapping text
gem 'word_wrapper'            # Pure ruby word wrapping
gem 'wordy'                   # Written to help us create sample data for our applications, Wordy speaks in lorem ipsum. You can ask Wordy for paragraphs, sentences or words.
#
gem 'yabeda'                  # Extensible framework for collecting metric for your Ruby application
gem 'yabeda-prometheus'       # Extensible Prometheus exporter for your application
gem 'yabeda-rails'            # Extensible metrics for monitoring Ruby on Rails application
gem 'yabeda-sidekiq'          # Extensible Prometheus exporter for monitoring your Sidekiq
#
# gems dealing with TTY/CLI I/O
#
gem 'tty-box'                 # Draw various frames and boxes in your terminal interface.
gem 'tty-color'               # Terminal color capabilities detection
gem 'tty-color-cli'           # CLI tool for terminal color capabilities detection
gem 'tty-command'             # Execute shell commands with pretty output logging and capture their stdout, stderr and exit status.
gem 'tty-config'              # Define, read and write any Ruby app configurations with a penchant for terminal clients.
gem 'tty-cursor'              # Terminal cursor positioning, visibility and text manipulation.
gem 'tty-editor'              # Opens a file or text in the user's preferred editor.
gem 'tty-file'                # File manipulation utility methods.
gem 'tty-fireworks'           # For those extra special commits
gem 'tty-font'                # Terminal fonts
gem 'tty-logger'              # Readable, structured and beautiful terminal logging
gem 'tty-markdown'            # Convert a markdown text or document into a terminal friendly output.
gem 'tty-pager'               # Terminal output paging in a cross-platform way supporting all major ruby interpreters.
gem 'tty-pie'                 # Draw pie charts in your terminal window.
gem 'tty-platform'            # Query methods for detecting different operating systems.
gem 'tty-process-ctl'         # Control of interactive terminal applications via simple API.
gem 'tty-progressbar'         # A flexible progress bars drawing in terminal emulators.
gem 'tty-prompt'              # A beautiful and powerful interactive command line prompt.
gem 'tty-prompt-vim'          # Dead-simple Vim-like bindings extension for tty-prompt
gem 'tty-reader'              # A set of methods for processing keyboard input in character, line and multiline modes.
gem 'tty-screen'              # Terminal screen size detection which works on Linux, OS X and Windows/Cygwin platforms and supports MRI, JRuby and Rubinius interpreters.
gem 'tty-spinner'             # A terminal spinner for tasks that have non-deterministic time frame.
gem 'tty-table'               # A flexible and intuitive table generator
gem 'tty-tree'                # Print directory or structured data in a tree like format.
gem 'tty-which'               # Platform independent implementation of Unix which command.
#
gem 'web-console'             # A debugging tool for your Ruby on Rails applications.
gem 'wicked_pdf'              # PDF generator (from HTML) gem for Ruby on Rails
gem 'wt_activerecord_index_spy' # It checks if queries use an index


# STOP_ADDING_COMMENTS -- DO NOT DELETE THIS COMMENT its used by ./comment_gemset.rb

gem_list = $gems.join(' ')

if ARGV.empty?
  system "gemt #{gem_list}"
else
  installed_gems = Gem::Specification.all.map { |gs| gs.name }

  if %w{ -i --install }.include?ARGV.first
    missing_gems = $gems.reject{ |gem_name| installed_gems.include?(gem_name)}
    if missing_gems.empty?
      puts "All gems are already installed"
    else
      # command = "gem install #{missing_gems.join(' ')}"
      # puts command
      # system command

      until missing_gems.empty?
        gem_name  = missing_gems.shift
        command   = "gem install #{gem_name}"
        puts command
        system command
        depends = YAML.load(`gem spec #{gem_name}`)
                    .dependencies.map{|d| d.name}
        unless depends.empty?
          depends.each {|d| missing_gems.delete d}
        end
      end # until missing_gems.empty?
    end # if missing_gems.empty?
  end # if %w{ -i --install }.include?ARGV.first
end

__END__
graphql                 A GraphQL language and runtime for Ruby
                        |__ https://github.com/rmosolgo/graphql-ruby
graphql-active_record   Active Record Helpers for graphql-ruby
                        |__ http://github.com/brettjurgens/graphql-active-record
graphql-batch           A query batching executor for the graphql gem
                        |__ https://github.com/Shopify/graphql-batch
graphql-client          GraphQL Client
                        |__ https://github.com/github/graphql-client
graphql-docs            Easily generate beautiful documentation from your GraphQL schema.
                        |__ https://github.com/gjtorikian/graphql-docs
graphql-errors          Simple error handler for graphql-ruby
                        |__ https://github.com/exAspArk/graphql-errors
graphql-guard           Simple authorization gem for graphql-ruby
                        |__ https://github.com/exAspArk/graphql-guard
graphql-preload         Preload ActiveRecord associations with graphql-batch
                        |__ https://github.com/ConsultingMD/graphql-preload
graphql-smart_select    Plugin for graphql-ruby gem
                        |__ https://github.com/Arkweid/graphql-smart_select
graphql_schema          Classes for convenient use of GraphQL introspection result
                        |__ https://github.com/Shopify/graphql_schema
rspec-graphql_matchers  Collection of rspec matchers to test your graphQL api schema.
                        |__ https://github.com/khamusa/rspec-graphql_matchers

