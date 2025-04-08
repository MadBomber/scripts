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
# Last reviewed for Ruby v3.3.0
#

system "gem install os"

require 'os'
require 'yaml' # STDLIB

$gems = Array.new

def gem(gem_name, version='')
  $gems << gem_name
end

# Using this form so that you can grab what you want for a Gemfile
#
# my gems ...
#

gem 'agent99'                 # An intelligent agent framework for Ruby
gem 'ai_client'               # A generic AI Client for many providers
gem 'aia'                     # AI Assistant
gem 'aigcm'                   # AI-powered git commit message generator
gem 'cli_helper'              # An encapsulation of an integration of slop, nenv, inifile and configatron.
gem 'debug_me'                # A tool to print the labeled value of variables.
gem 'prompt_manager'          # Manage prompts for use with gen-AI processes
# WIP: gem 'ragdoll'                 # Ruby on Rails Engine
gem 'rethinkdb_helper'        # A wrapper around the ruby rethinkdb gem



#
# Profilers
#

gem 'flamegraph'          # Flamegraph support for arbitrary ruby apps
gem 'memory_profiler'     # Memory profiling routines for Ruby 2.1+
gem 'rack-mini-profiler'  # Profiles loading speed for rack applications.
gem 'stackprof'           # sampling callstack-profiler for ruby 2.1+
gem 'vernier'             # A next generation CRuby profiler

#
# AI-related support libraries and tools
#

gem 'action_prompt'         # ActionPrompt is a Rails plugin for managing templated LLM prompts
gem 'actionmcp'             # Provides essential tooling for building Model Context Protocol (MCP) capable servers
gem 'activeagent'           # Rails AI Agents Framework
gem 'ai-engine'             # The fastest way to get AI Assistants into your Rails app!
gem 'ai_client'             # A generic AI Client for many providers
gem 'aia'                   # AI Assistant
gem 'aicommit'              # Use your own spell against you.
gem 'aigcm'                 # AI-powered git commit message generator
gem 'anthropic'             # Anthropic API + Ruby! 🤖🌌
gem 'baran'                 # Text Splitter for Large Language Model Datasets
gem 'boxcars'               # Boxcars is a gem that enables you to create new systems with AI composability. Inspired by python langchain.
gem 'clag'                  # Generate command line commands in your terminal using an LLM
gem 'clip-rb'               # OpenAI CLIP embeddings, uses ONNX models
gem 'cohere-ai'             # Interact with Cohere AI.
gem 'faiss'                 # Efficient similarity search and clustering for Ruby
gem 'fast-mcp'              # A Ruby implementation of the Model Context Protocol.
gem 'gemini-ai'             # Interact with Google's Gemini AI.
gem 'gen-ai'                # Generative AI toolset for Ruby.
gem 'groq'                  # Client library for Groq API for fast LLM inference.
gem 'honyaku'               # Translate your Rails application using OpenAI
gem 'hugging-face'          # Ruby client for Hugging Face API
gem 'ima'                   # ima is the ai agenic framework for super monkeys
gem 'informers'             # Fast transformer inference for Ruby
gem 'instructor-rb'         # Structured extraction in Ruby, powered by llms.
gem 'intelligence'          # A Ruby gem for seamlessly and uniformly interacting with large languge and vision model (LLM) API's served by numerous services, including those of OpenAI, Anthropic, Google and others.
gem 'irb-ai'                # IRB commands powered by AI.
gem 'langchainrb'           # Build LLM-backed Ruby applications with Ruby's Langchain.rb
gem 'langchainrb_rails'     # Rails wrapper for langchainrb gem
gem 'llm_orchestrator'      # A lightweight ruby framework for orchestrating operations via LLM APIs
gem 'mcp-rb'                # A lightweight Ruby framework for implementing MCP (Model Context Protocol) servers
gem 'minds_sdk'             # Minds Ruby SDK provides an interface to interact with the Minds AI system API. It allows you to create and manage "minds" (artificial intelligences), create chat completions, and manage data sources.
gem 'mistral-ai'            # Interact with Mistral AI.
gem 'modelcontextprotocol'  # Wrap Thor command-line apps in model view context protocol
gem 'nano-bots'             # Ruby Implementation of Nano Bots: small, AI-powered bots for OpenAI ChatGPT, Ollama, Mistral AI, Anthropic Claude, Cohere Command, Maritaca AI MariTalk, and Google Gemini.
gem 'neighbor'              # Nearest neighbor search for Rails
gem 'ollama-ai'             # Interact with Ollama API to run open source AI models locally.
gem 'omniai'                # A generalized framework for interacting with many AI services
gem 'omniai-anthropic'      # A generalized framework for interacting with Anthropic
gem 'omniai-deepseek'       # A generalized framework for interacting with DeepSeek
gem 'omniai-google'         # A generalized framework for interacting with Google
gem 'omniai-mistral'        # A generalized framework for interacting with Mistral
gem 'omniai-openai'         # A generalized framework for interacting with OpenAI
gem 'open_router'           # Ruby library for OpenRouter API.
gem 'pgvector'              # pgvector support for Ruby
gem 'pinecone'              # Ruby client library for Pinecone Vector DB
gem 'pragmatic_segmenter'   # A rule-based sentence boundary detection gem that works out-of-the-box across many languages
gem 'pycall'                # Call python functions from Ruby
gem 'rails-mcp-server'      # MCP server for Rails projects
gem 'raix'                  # Ruby AI eXtensions
gem 'raix-rails'            # Ruby AI eXtensions for Rails
gem 'regent'                # Library for building AI Agents in Ruby
gem 'rspec-llama'           # A versatile testing framework for different AI model configurations.
gem 'ruby-openai'           # A Ruby gem for the OpenAI GPT-3 API
gem 'ruby-openai-swarm'     # A Ruby implementation of OpenAI function calling swarm
gem 'ruby_llm'              # Beautiful Ruby interface to modern AI
gem 'simple_rag'            # Simple Rag is a lightweight library that transforms any Ruby project into a simple RAG application.
gem 'sqlite-vec'            # A vector search SQLite extension.
gem 'sublayer'              # A model-agnostic Ruby GenerativeAI DSL and Framework
gem 'tiktoken_ruby'         # Ruby wrapper for Tiktoken
gem 'weaviate-ruby'         # Ruby wrapper for the Weaviate.io API


#########################################
## gems that require something extra

# h3 requires the 'cmake' package; use brew, dnf, yum, apt=get etc
if OS.mac?
  `brew install cmake`
  gem 'h3'                      # C Bindings for Uber's H3 library for geospatial reference
end


#####################################
## uncategorized gems in alphabetic order
#
# If a gem is commented out like this:
#
# 332/340p1 gem 'some gem name'
#
# It means that the gem failed to install on
# the 3.3.2 AND 3.4.0-preview1 versions of Ruby


gem 'action_policy'           # Authorization framework for Ruby/Rails application
gem 'active_record_extended'  # Adds extended functionality to Activerecord Postgres implementation
gem 'active_record_union'     # UNIONs in ActiveRecord! Adds proper union and union_all methods to ActiveRecord::Relation.
gem 'activerecord-import'     # Bulk insert extension for ActiveRecord
gem 'address_extractor'       # Give it text.  It finds addresses in it.
gem 'after_commit_everywhere' # Executes code after database commit wherever you want in your application
gem 'ahoy_matey'              # Simple, powerful analytics for Rails
gem 'alba'                    # Alba is the fastest JSON serializer for Ruby.
gem 'amazing_print'           # Pretty print Ruby objects with proper indentation and colors
gem 'any_login'               # AnyLogin is created to speedup development process and allow developer's quickly login as any user in DB.
gem 'anycable'                # AnyCable is a polyglot replacement for ActionCable-compatible servers
gem 'anycable-rails'          # Rails adapter for AnyCable
gem 'apexcharts'              # Awesome charts for your ruby app
gem 'ar_lazy_preload'         # lazy_preload implementation for ActiveRecord models
gem 'attractor'               # Churn vs Complexity Chart Generator
gem 'aws-sdk-s3'              # AWS SDK for Ruby - Amazon S3
#
gem 'bible_gateway'           # An unofficial 'API' for BibleGateway.com.
gem 'blazer'                  # Explore your data with SQL. Easily create charts and dashboards, and share them with your team.
gem 'bond'                    # used in IRB completions
gem 'bootsnap'                # Boot large ruby/rails apps faster
gem 'bundler'                 # The best way to manage your application's dependencies
gem 'bundler-audit'           # Patch-level verification for Bundler
gem 'bunny'                   # Popular easy to use Ruby client for RabbitMQ
gem 'business_days'           # Add method business_days as interval to active support
#
gem 'cancancan'               # Simple authorization solution for Rails.
gem 'capybara-thruster'       # Example description
gem 'chartkick'               # Create beautiful JavaScript charts with one line of Ruby
gem 'childprocess'            # A simple and reliable solution for controlling external programs running in the background on any Ruby / OS combination.
gem 'clipboard'               # Easy access to the clipboard on Linux, MacOS and Windows.
gem 'colortail'               # Tail a file and color lines based on regular expressions within that line
gem 'concurrent-ruby'         # Modern concurrency tools for Ruby. Inspired by Erlang, Clojure, Scala, Haskell, F#, C#, Java, and classic concurrency patterns.
gem 'concurrent-ruby-edge'    # Edge features and additions to the concurrent-ruby gem.
gem 'concurrent-ruby-ext'     # C extensions to optimize concurrent-ruby under MRI.
gem 'coverband'               # Rack middleware to measure production code usage (LOC runtime usage)
gem 'cuprite'                 # Headless Chrome driver for Capybara
#
gem 'daemons'                 # A toolkit to create and control daemons in different ways
gem 'danger'                  # Like Unit Tests, but for your Team Culture.
gem 'database_consistency'    # Provide an easy way to check the consistency of the database constraints with the application validations.
gem 'database_validations'    # Provide compatibility between database constraints and ActiveRecord validations with better performance and consistency.
gem 'derailed_benchmarks'     # Benchmarks designed to performance test your ENTIRE site
gem 'did_you_mean'            # "Did you mean?" experience in Ruby
gem 'discard'                 # ActiveRecord soft-deletes done right
gem 'docopt'                  # A command line option parser, that will make you smile.
gem 'docx'                    # a ruby library/gem for interacting with .docx files
gem 'dotenv'                  # Loads environment variables from `.env`.
gem 'dry-cli'                 # Common framework to build command line interfaces with Ruby
gem 'dry-configurable'        # A mixin to add configuration functionality to your classes
gem 'dry-container'           # A simple container intended for use as an IoC container
gem 'dry-core'                # A toolset of small support modules used throughout the dry-rb ecosystem.
gem 'dry-effects'             # Algebraic effects
gem 'dry-equalizer'           # Module to define equality, equivalence and inspection methods
gem 'dry-graphql'             # Integrate dry-types/dry-struct with graphql-ruby
gem 'dry-inflector'           # DRY Inflector
gem 'dry-initializer'         # DSL for declaring params and options of the initializer
gem 'dry-logic'               # Predicate logic with rule composition
gem 'dry-monads'              # Common monads for Ruby
gem 'dry-schema'              # Coercion and validation for data structures
gem 'dry-struct'              # Typed structs and value objects.
gem 'dry-types'               # Type system for Ruby supporting coercions, constraints and complex types like structs, value objects, enums etc.
#
gem 'ect'                     # Methods ending in ect
gem 'email_address'           # This gem provides a ruby language library for working with and validating email addresses. By default, it validates against conventional usage, the format preferred for user email addresses. It can be configured to validate against RFC “Standard” formats, common email service provider formats, and perform DNS validation.
gem 'event_bus'               # A simple pubsub event bus for Ruby applications
gem 'evil-seed'               # Create partial and anonymized production database dumps for use in development
#
gem 'facter'                  # Facter, a system inventory tool
gem 'factory_bot'             # factory_bot provides a framework and DSL for defining and using model instance factories.
gem 'faktory_worker_ruby'     # Ruby worker for Faktory
gem 'falcon'                  # A fast, asynchronous, rack-compatible web server.
gem 'fast_excel'              # Ultra Fast Excel Writer (XLSX)
gem 'fast_jsonparser'         # Fast Json Parser
gem 'feature_toggles'         # This gem provides a mechanism for pending features.
gem 'ffi-ncurses'             # An FFI wrapper around ncursesw 5.x for MRI Ruby 1.8.x, 1.9.x and JRuby.
gem 'fuubar'                  # the instafailing RSpec progress bar formatter
gem 'fx'                      # Support for database functions and triggers in Rails migrations
#
gem 'geek_painter'            # A very simple DSL to generate a colored shell prompt string to use in *nix OS terminals
gem 'geospatial'              # Provides abstractions for dealing with geographical locations efficiently
# 340p1 gem 'git-up'                  # git command to fetch and rebase all branches
gem 'github_api'              # Ruby client for the official GitHub API
gem 'graphiti'                # Easily build jsonapi.org-compatible APIs
gem 'groupdate'               # The simplest way to group temporal data
gem 'gruff'                   # Beautiful graphs for one or multiple datasets.
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
gem 'hashdiff'                # Hashdiff is a diff lib to compute the smallest difference between two hashes.
gem 'holidays'                # A collection of Ruby methods to deal with statutory and other holidays.
gem 'htmlentities'            # Encode/decode HTML entities
#
gem 'imgproxy-rails'          # integration of imgproxy.rb with ActiveStorage::Variant API
gem 'iodine'                  # iodine - a fast HTTP / Websocket Server with Pub/Sub support, optimized for Ruby MRI on Linux / BSD
gem 'irbtools'                # Irbtools happy IRB.
gem 'isolator'                # Detect non-atomic interactions within DB transactions
#
gem 'jira-ruby'               # Ruby Gem for use with the Atlassian JIRA REST API
gem 'jirasync'                # jirasync synchronises jira projects to the local file system
gem 'json'                    # This json is bundled with Ruby
gem 'jumon'                   # The Prompt testing library for LLM that allows comparing patterns of prompts.
gem 'jwt_sessions'            # JWT Sessions
#
# 332/340p1 gem 'langchainrb'             # Build LLM-backed Ruby applications with Ruby's LangChain
gem 'lefthook'                # A single dependency-free binary to manage all your git hooks that works with any language in any environment, and in all common team workflows.
gem 'linefit'                 # LineFit is a linear regression math class.
gem 'lipsum'                  # Get placeholder text from lipsum.com
gem 'log_analyzer'            # log_analyzer gem is created to get statistics about your views rendering performance.
gem 'lograge'                 # Tame Rails' multi-line logging into a single line per request
gem 'lookbook'                # A native development UI for ViewComponent
#
gem 'mail'                    # Mail provides a nice Ruby DSL for making, sending and reading emails.
gem 'meta-tags'               # Collection of SEO helpers for Ruby on Rails.
gem 'mini_sql'                # A fast, safe, simple direct SQL executor
gem 'monotime'                # A sensible interface to the monotonic clock
gem 'motor-admin'             # Low-code Admin panel and Business intelligence
#
gem 'n1_loader'               # Loader to solve N+1 issue for good.
gem 'n_plus_one_control'      # RSpec and Minitest matchers to prevent N+1 queries problem
gem 'nanoid'                  # Ruby implementation of Nanoid, secure URL-friendly unique ID generator
gem 'nenv'                    # Convenience wrapper for Ruby's ENV
gem 'next_rails'              # A toolkit to upgrade your next Rails application
gem 'nokogiri'                # Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser
#
gem 'object_shadow'           # Metaprogramming Level 2
gem 'ocassionally'            # occasionally it works; and, ocassionally it doesn't
gem 'ohai'                    # Ohai profiles your system and emits JSON
gem 'oj'                      # A fast JSON parser and serializer.
gem 'optimist'                # Optimist is a commandline option parser for Ruby that just gets out of your way.
gem 'os'                      # Simple and easy way to know if you're on windows or not (reliably), as well as how many bits the OS is, etc.
gem 'overcommit'              # Git hook manager See Also: lefthook
#
gem 'pagy'                    # The Ultimate Pagination Ruby Gem
gem 'pagy_cursor'             # cursor paginations for pagy
gem 'panko_serializer'        # High Performance JSON Serialization for ActiveRecord & Ruby Objects
gem 'paper_trail'             # Track changes to your models.
gem 'pericope'                # Pericope is a gem for parsing Bible references.
gem 'pessimize'               # Add the pessimistic constraint operator to all gems in your Gemfile, restricting the maximum update version.
gem 'pg'                      # Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
gem 'pg_search'               # builds Active Record named scopes that take advantage of PostgreSQL's full text search
gem 'pg_trunk'                # Empower PostgreSQL migrations in Rails app
gem 'pgsync'                  # Sync Postgres data between databases
gem 'postgresql_cursor'       # ActiveRecord PostgreSQL Adapter extension for using a cursor to return a large result set
gem 'power_assert'            # Power Assert for Ruby
gem 'premailer-rails'         # Easily create styled HTML emails in Rails.
gem 'progress_bar'            # Simple Progress Bar for output to a terminal
gem 'prosopite'               # N+1 auto-detection for Rails with zero false positives / false negatives
gem 'puma'                    # Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications
gem 'pundit'                  # OO authorization for Rails
#
gem 'rack-attack'             # Block & throttle abusive requests
gem 'rails'                   # Full-stack web application framework.
gem 'rails-erd'               # Entity-relationship diagram for your Rails models.
gem 'rails-pg-extras'         # Rails PostgreSQL performance database insights
gem 're2'                     # Ruby bindings to RE2.
gem 'redlock'                 # Distributed lock using Redis written in Ruby.
gem 'reform'                  # Form object decoupled from models with validation, population and presentation.
gem 'retriable'               # Retriable is a simple DSL to retry failed code blocks with randomized exponential backoff
gem 'rexe'                    # Ruby Command Line Executor
gem 'rgeo'                    # RGeo is a geospatial data library for Ruby.
gem 'ripper-tags'             # ctags generator for ruby code
gem 'rolify'                  # Roles library with resource scoping
gem 'rom'                     # Persistence and mapping toolkit for Ruby
gem 'rom-sql'                 # SQL databases support for ROM
gem 'rspec-instafail'         # Show failing specs instantly
gem 'rspec-rails'             # RSpec for Rails
gem 'rssable'                 # Access the RSS channel of any website without worrying about the engine
gem 'rubocop'                 # Automatic Ruby code style checking tool.
gem 'rubocop-performance'     # Automatic performance checking tool for Ruby code.
gem 'rubocop-rails'           # Automatic Rails code style checking tool.
gem 'rubocop-rspec'           # Code style checking for RSpec files
gem 'ruby-openai'             # OpenAI API + Ruby! 🤖❤️
gem 'ruby-progressbar'        # never leave the user guessing
# 332/340p1 gem 'ruby_crystal_codemod'    # Ruby => Crystal codemod
gem 'rubyfmt'                 # Ruby port of gofmt
gem 'rubytoolbox-api'         # A simple, dependency-free API client for The Ruby Toolbox
gem 'rufo'                    # Ruby code formatter
gem 'rumale'                  # RUby MAchine LEarning
#
gem 'sail'                    # Sail will help you navigate your Rails application.
gem 'sanitize'                # Whitelist-based HTML and CSS sanitizer.
gem 'scenic'                  # Support for database views in Rails migrations
gem 'searchkick'              # Intelligent search made easy with Rails and Elasticsearch
gem 'semantic_logger'         # Feature rich logging framework, and replacement for existing Ruby & Rails loggers.
gem 'sequel'                  # The Database Toolkit for Ruby
gem 'service_actor'           # Service objects for your application logic
gem 'sidekiq'                 # Simple, efficient background processing for Ruby
gem 'sidekiq-grouping'        # Allows identical sidekiq jobs to be processed with a single background call
gem 'sidekiq-limit_fetch'     # Sidekiq strategy to support queue limits
gem 'sidekiq-scheduler'       # Light weight job scheduling extension for Sidekiq
gem 'silencer'                # Selectively quiet your Rails/Rack logger on a per-route basis
gem 'sinatra'                 # Classy web-development dressed in a DSL
gem 'site_prism'              # A Page Object Model DSL for Capybara
gem 'sketches'                # Sketches allows you to create and edit Ruby code from the comfort of your editor, while having it safely reloaded in IRB whenever changes to the code are saved.
gem 'skooma'                  # Validate API implementations against OpenAPI documents.
gem 'slop'                    # Simple Lightweight Option Parsing
gem 'smarter_csv'             # Ruby Gem for smarter importing of CSV Files (and CSV-like files), with lots of optional features, e.g. chunked processing for huge CSV files
gem 'sorcery'                 # Magical authentication for Rails applications
gem 'spreadsheet_architect'   # Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets easily from ActiveRecord relations, Plain Ruby classes, or predefined data.
gem 'squasher'                # Squash your old migrations
gem 'standard'                # Ruby Style Guide, with linter & automatic code fixer
gem 'store_attribute'         # ActiveRecord extension which adds typecasting to store accessors
gem 'store_model'             # Gem for working with JSON-backed attributes as ActiveRecord models
gem 'strong_migrations'       # Catch unsafe migrations in development
gem 'sugar_refinery'          # The Ruby Sugar Refinery is a collection of tiny refinements.
gem 'summary'                 # This is a simple gem that generates introduction text from a long text, it will always break the text at the end of the last word near to the limit you informed as argument.
gem 'svn_wc'                  # operates on a working copy (on the local filesystem) of a remote Subversion repository.
gem 'sys-proctable'           # An interface for providing process table information
gem 'systemu'                 # systemu
#
gem 'terjira'                 # Terjira is interactive command line application for Jira
gem 'terminal-size'           # A tiny gem to accomplish a simple task: Determining the terminal size.
gem 'terminalwire'            # Ship a CLI for your web app. No API required.
gem 'test-kitchen'            # Test Kitchen is an integration tool for developing and testing infrastructure code and software on isolated target platforms.
gem 'test-prof'               # Ruby applications tests profiling tools
gem 'thruster'                # http/2 + ssl for puma and rails
gem 'timecop'                 # A gem providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code.  It provides a unified method to mock Time.now, Date.today, and DateTime.now in a single call.
gem 'tocer'                   # A command line interface for generating Markdown table of contents.
gem 'transitions'             # State machine extracted from ActiveModel
gem 'trick_bag'               # Miscellaneous general useful tools.
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
gem 'turbo-rails'             # The speed of a single-page web application without having to write any JavaScript.
#
gem 'view_component'          # A framework for building reusable, testable & encapsulated view components in Ruby on Rails.
gem 'view_component-contrib'  # A collection of extensions and developer tools for ViewComponent
gem 'vite_rails'              # Use Vite in Rails and bring joy to your JavaScript experience
#
gem 'web-console'             # A debugging tool for your Ruby on Rails applications.
gem 'webmock'                 # Library for stubbing HTTP requests in Ruby.
gem 'wharel'                  # Arel + Where = Wharel
gem 'wicked_pdf'              # PDF generator (from HTML) gem for Ruby on Rails
gem 'with_model'              # Dynamically build a model within an RSpec context
gem 'word_wrap'               # Simple tool for word-wrapping text
gem 'word_wrapper'            # Pure ruby word wrapping
gem 'wordy'                   # Written to help us create sample data for our applications, Wordy speaks in lorem ipsum. You can ask Wordy for paragraphs, sentences or words.
gem 'wt_activerecord_index_spy' # It checks if queries use an index
#
gem 'yabeda'                  # Extensible framework for collecting metric for your Ruby application
gem 'yabeda-prometheus'       # Extensible Prometheus exporter for your application
gem 'yabeda-puma-plugin'      # Puma web server plugin for collecting puma metrics with Yabeda framework.
gem 'yabeda-rails'            # Extensible metrics for monitoring Ruby on Rails application
gem 'yabeda-sidekiq'          # Extensible Prometheus exporter for monitoring your Sidekiq
gem 'yake'                    # Rake-like DSL for declaring AWS Lambda function handlers
#
gem 'zonebie'  # Zonebie prevents bugs in code that deals with timezones by randomly assigning a zone on every run


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
        begin
          system command
          begin
            depends = YAML.load(`gem spec #{gem_name}`)
                        .dependencies.map{|d| d.name}
            unless depends.empty?
              depends.each {|d| missing_gems.delete d}
            end
          rescue => e
            # Don't care
          end
        rescue => e
          puts "#{gem_name} has ERROR: #{e}"
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
