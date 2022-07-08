#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: rename_monkimage_files.rb
##  Desc: change the filename to something meaningful
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

MONKIMAGE     = 'monkimage'
FILENAME_TAG  = 'fileName='

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  Put important stuff here.

EOHELP

cli_helper("change the filename to something meaningful") do |o|

  o.path    '-o', '--outdir',   'Output Directory',  default: Pathname.pwd

end


# Error check your stuff; use error('some message') and warning('some message')


abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

here = Pathname.pwd

here.children.each do |child|
  next if child.directory?

  old_filename = child.basename.to_s

  next unless old_filename.start_with? MONKIMAGE
  next unless old_filename.include? FILENAME_TAG

  tag_start     = old_filename.index FILENAME_TAG
  tag_end       = tag_start + FILENAME_TAG.size
  new_filename  = old_filename[tag_end..]
  new_filepath  = configatron.outdir + new_filename

  child.rename new_filepath

end
