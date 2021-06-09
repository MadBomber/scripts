#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: gc.rb
##  Desc: add the basename of $RR to the git commit template
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#   Add a file to the HOME directory called .gitmessage.template
#   This file will be processed into the standard .gitmessage.txt file
#   by making replacements in the content as directed by the
#   Hash object replacements.
#
#   You can
#     alias gc='gc.rb && git commit'
#   to take advantage of the new template capability.
#

require 'pathname'

# $RR is the Rails.root (or repo root for non-rails projects)
# its generall set by a .envrc file (brew install direnv)

if ENV['RR'].nil?
  rr          = Pathname.pwd
else
  rr          = Pathname.new(ENV['RR'])
end

home          = Pathname.new(ENV['HOME'])
template_path = home + '.gitmessage.template'
message_path  = home + '.gitmessage.txt'

unless template_path.exist?
  exit(0)
end

replacements = {
  # New branches for a ticket are created in a working directory with the ticket name
  '[ticket]' => -> {rr.basename.to_s}
}

template = template_path.read

replacements.each_pair do |key, value|
  template.gsub!(key, value.call)
end

message_path.write template
