source 'https://rubygems.org'

gem 'address_extractor'       # Give it text.  It finds addresses in it.
gem 'awesome_print'           # Pretty print Ruby objects with proper indentation and colors
gem 'bundler'                 # The best way to manage your application's dependencies
gem 'cli_helper'              # An encapsulation of an integration of slop, nenv, inifile and configatron.
gem 'clipboard'               # Easy access to the clipboard on Linux, MacOS and Windows.
gem 'colortail'               # Tail a file and color lines based on regular expressions within that line
gem 'daemons'                 # A toolkit to create and control daemons in different ways
gem 'daru'                    # Data Analysis in RUby
gem 'daru-plotly'             # Draw graph with daru
gem 'debug_me'                # A tool to print the labeled value of variables.

if 'ruby-2.3.3' == ENV['RUBY_VERSION']
  gem 'did_you_mean', '~>1.0.2'  # Newer versions require Ruby v2.4
elsif  'ruby-2.4.2' == ENV['RUBY_VERSION']
  gem 'did_you_mean', '~>1.1.2'  # Newer versions require Ruby v2.5
else
  gem 'did_you_mean'             # "Did you mean?" experience in Ruby
end

gem 'docopt'                  # A command line option parser, that will make you smile.
gem 'docx'                    # a ruby library/gem for interacting with .docx files
gem 'email_address'           # This gem provides a ruby language library for working with and validating email addresses. By default, it validates against conventional usage, the format preferred for user email addresses. It can be configured to validate against RFC “Standard” formats, common email service provider formats, and perform DNS validation.
gem 'facter'                  # Facter, a system inventory tool
gem 'ffi-ncurses'             # An FFI wrapper around ncursesw 5.x for MRI Ruby 1.8.x, 1.9.x and JRuby.
gem 'geek_painter'            # A very simple DSL to generate a colored shell prompt string to use in *nix OS terminals
gem 'github_api'              # Ruby client for the official GitHub API
gem 'irbtools'                # Irbtools happy IRB.
# gem 'irbtools-more'           # irbtools-more adds bond and looksee to IRB.
gem 'jira-ruby'               # Ruby Gem for use with the Atlassian JIRA REST API
gem 'jirasync'                # jirasync synchronises jira projects to the local file system
gem 'json'                    # This json is bundled with Ruby
gem 'linefit'                 # LineFit is a linear regression math class.
gem 'lipsum'                  # Get placeholder text from lipsum.com
gem 'log_analyzer'            # log_analyzer gem is created to get statistics about your views rendering performance.
gem 'mail'                    # Mail provides a nice Ruby DSL for making, sending and reading emails.
gem 'nenv'                    # Convenience wrapper for Ruby's ENV
gem 'nokogiri'                # Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser
gem 'ohai'                    # Ohai profiles your system and emits JSON
# gem 'phashion'              # Simple wrapper around the pHash library - precepual hashing to find dup images
gem 'pgsync'                  # Sync Postgres data between databases
gem 'progress_bar'            # Simple Progress Bar for output to a terminal
gem 'rethinkdb_helper'        # A wrapper around the ruby rethinkdb gem
gem 'ruby-progressbar'        # never leave the user guessing
gem 'sanitize'                # Whitelist-based HTML and CSS sanitizer.
gem 'sketches'                # Sketches allows you to create and edit Ruby code from the comfort of your editor, while having it safely reloaded in IRB whenever changes to the code are saved.
gem 'sinatra'                 # Classy web-development dressed in a DSL
gem 'slop'                    # Simple Lightweight Option Parsing
gem 'sugar_refinery'          # The Ruby Sugar Refinery is a collection of tiny refinements.
gem 'summary'                 # This is a simple gem that generates introduction text from a long text, it will always break the text at the end of the last word near to the limit you informed as argument.
gem 'svn_wc'                  # operates on a working copy (on the local filesystem) of a remote Subversion repository.
gem 'systemu'                 # systemu
gem 'terjira'                 # Terjira is interactive command line application for Jira
gem 'terminal-size'           # A tiny gem to accomplish a simple task: Determining the terminal size.
gem 'transitions'             # State machine extracted from ActiveModel
gem 'virtualbox'              # Support functions for VM
gem 'word_wrap'               # Simple tool for word-wrapping text
gem 'word_wrapper'            # Pure ruby word wrapping
gem 'wordy'                   # Written to help us create sample data for our applications, Wordy speaks in lorem ipsum. You can ask Wordy for paragraphs, sentences or words.
#
gem 'guard'                   # Guard keeps an eye on your file modifications
gem 'guard-rubocop'           # Guard plugin for RuboCop
gem 'guard-rubycritic'        # Listens to modifications and detects smells in Ruby files
gem 'rubocop'                 # Automatic Ruby code style checking tool.
gem 'rubycritic'              # RubyCritic is a Ruby code quality reporter
#
#
# Problems ......
# gem 'gruff'                   # Beautiful graphs for one or multiple datasets.
# gem 'rmagick'                 # Ruby binding to ImageMagick
