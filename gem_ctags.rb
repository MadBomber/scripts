#!/usr/bin/env ruby
#######################################################
###
## File: gem_ctags.rb
## Desc: build a .tags file for all ruby gems in the Gemfile
#
require 'bundler'
paths = Bundler.load.specs.map(&:full_gem_path)
system("ctags -R -f .gemtags #{paths.join(' ')}")
