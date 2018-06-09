#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: delete_docker_junk.rb
##  Desc: Do that docker thing
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'  # Pretty print Ruby objects with proper indentation and colors

require 'debug_me'       # A tool to print the labeled value of variables.
include DebugMe

require 'cli_helper'     # An encapsulation of an integration of slop, nenv, inifile and configatron.
include CliHelper

configatron.version = '0.0.1'  # The version of this program.

require 'pathname'             # STDLIB

cli_helper("\nDelete docker images and containers") do |o|

  o.bool          '--delete-containers','Delete Docker Containers',         default: false
  o.bool          '--delete-images',    'Delete Docker Images',             default: false
  o.bool          '--all',              'Delete All Docker Stuff',          default: false

end


# Error check your stuff; use error('some message') and warning('some message')



abort_if_errors

if configatron.all
  configatron.delete_images     = true
  configatron.delete_containers = true
end


######################################################
# Local methods



# exposes the command line parameter value in an easy to read form
def delete_images?
  configatron.delete_images
end


# exposes the command line parameter value in an easy to read form
def delete_containers?
  configatron.delete_containers
end


# outputs to STDOUT a banner to head the section
def section_header(a_string)
  if verbose?  ||  debug?
    puts "\n\n" + "="*45
    puts "== #{a_string} ..."
    puts
  end
end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if debug?


##############################################################################
## Delete Docker Containers

if delete_containers?

  commands = [
    "docker stop $(docker ps -a -q)",
    "docker rm $(docker ps -a -q)"
  ]

  containers = `docker ps -a -q`.split("\n")

  unless containers.empty?

    section_header "Stopping and removing all docker containers"

    commands.each do |command|
      puts ".. Executing: #{command}" if verbose?  ||  debug?
      system command
    end

  end # unless containers.empty?

end # if delete_containers?



##############################################################################
## Delete Existing docker images

# SMELL:  This section will delete ALL docker images even those that are not
#         associated with this application

if delete_images?
  section_header "Deleting docker images"

  images = `docker images -q`.split("\n")

  unless images.empty?

    message = <<~EOS

      All docker images will be deleted.  All means ALL; not just the
      ones associated with this application but ALL that you have defined
      on your workstation.

      Here is the result of a 'docker images' command:

      #{`docker images`}

    EOS

    warning message

    abort_if_errors

    images.each do |image_id|
      command = "docker rmi #{image_id} --force"
      puts "Executing: #{command} ..." if verbose?  ||  debug?
      system command
    end
  end

end # if delete_images?


if ARGV.empty?
  puts
  command = "docker images"
  puts "Executing: #{command} ..." if verbose?  ||  debug?
  system command
end

