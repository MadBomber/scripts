#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: rultor_init_project.rb
##  Desc: Initialize a git repo on github for use with rultor
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# NOTE: this is the text in a version.rb file which
#       will be replaced by the designated ENV['tag'] value
#       when using the release.rb program ... like so:
#           tag='1.0.0' release.rb
VERSION_PLACEMENT_TAG = '__place_version_here__'

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'pathname'  # STDLIB
require_relative 'lib/find_repo_dir'


me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

dot_gem_dir = Pathname.new( ENV['HOME'] ) + '.gem' # ASSUME: ~/.gem exists
creds_file  = dot_gem_dir + 'credentials'
creds_file  = dot_gem_dir + 'rubygems.yml' unless creds_file.exist?


$options = {
  verbose:        false,
  debug:          false,
  project_type:   :gem,
  user_account:   ENV['GITHUB_ACCOUNT'],
  repo_dir:       find_repo_dir(),
  lib_dir:        nil,
  version_file:   nil,
  rultor_yml:     nil,
  out_filename:   nil
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end


usage = <<EOS

Initialize an git repo to use @rultor commands
on github

Usage: #{my_name} [options] parameters

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress
    -d or --debug       Kill the bugs

    -u or --user        Github user account.
                          Default: #{$options[:user_account]}

    -r or --repo        Github repo name.
                          Default: #{$options[:repo_dir].basename}

    -g or --gem         Setup for a rubygems project

  parameters            The parameters required by
                        the program

NOTE:

  This only works for project type of rubygems

EOS

# Check command line for Problems with Parameters
$errors   = []
$warnings = []


# Get the next ARGV parameter after param_index
def get_next_parameter(param_index)
  unless Fixnum == param_index.class
    param_index = ARGV.find_index(param_index)
  end
  next_parameter = nil
  if param_index+1 >= ARGV.size
    $errors << "#{ARGV[param_index]} specified without parameter"
  else
    next_parameter = ARGV[param_index+1]
    ARGV[param_index+1] = nil
  end
  ARGV[param_index] = nil
  return next_parameter
end # def get_next_parameter(param_index)


# Get $options[:out_filename]
def get_repo_dir(param_index)
  repo_dir = get_next_parameter(param_index)
  $options[:repo_dir] = Pathname.new( repo_dir ) unless repo_dir.nil?
end # def get_repo_dir(param_index)


# Display global warnings and errors arrays and exit if necessary
def abort_if_errors
  unless $warnings.empty?
    STDERR.puts
    STDERR.puts "The following warnings were generated:"
    STDERR.puts
    $warnings.each do |w|
      STDERR.puts "\tWarning: #{w}"
    end
    STDERR.print "\nAbort program? (y/N) "
    answer = (gets).chomp.strip.downcase
    $errors << "Aborted by user" if answer.size>0 && 'y' == answer[0]
    $warnings = []
  end
  unless $errors.empty?
    STDERR.puts
    STDERR.puts "Correct the following errors and try again:"
    STDERR.puts
    $errors.each do |e|
      STDERR.puts "\t#{e}"
    end
    STDERR.puts
    exit(-1)
  end
end # def abort_if_errors


# Display the usage info
if  ARGV.include?('-h')       ||
    ARGV.include?('--help')
  puts usage
  exit
end


%w[ -v --verbose ].each do |param|
  if ARGV.include? param
    $options[:verbose]        = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

%w[ -d --debug ].each do |param|
  if ARGV.include? param
    $options[:debug]          = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

%w[ -r --repo ].each do |param|
  get_repo_dir( ARGV.index(param) ) if ARGV.include?(param)
  unless $options[:repo_dir].nil?
    unless $options[:repo_dir].parent.exist?
      $errors << "Directory does not exist: #{$options[:repo_dir]}"
    end
  end
end

%w[ -u --user ].each do |param|
  $options[:user_account] = get_next_parameter(ARGV.index(param)) if ARGV.include?(param)
  if $options[:user_account].nil?
    $errors << "#{param} was specified without value."
  end
end


ARGV.compact!

unless ARGV.empty?
  $errors << "Invalid parameters: #{ARGV.join(' ')}"
 end


if $options[:repo_dir].exist?
  $options[:rultor_yml] = $options[:repo_dir] + '.rultor.yml'
  if $options[:rultor_yml].exist?
    $warnings << ".rultor.yml already exists."
  end

  $options[:rubygems_yml] = $options[:repo_dir] + 'rubygems.yml'
  if $options[:rubygems_yml].exist?   ||
     ($options[:repo_dir] + 'rubygems.yml.asc').exist?
    $warnings << "rubygems.yml already exists."
  end

  $options[:lib_dir] = $options[:repo_dir] + 'lib'
  unless $options[:lib_dir].exist?
    $errors << "Found no 'lib' directory under #{$options[:repo_dir].basename}"
  end
else
  $errors << "Repo directory does not exist: #{$options[:repo_dir]}"
end # if $options[:repo_dir].exist?


abort_if_errors

is_gem = false
$options[:repo_dir].children.each do |c|
  is_gem ||= '.gemspec' == c.extname.downcase
end

unless is_gem
  $errors << "#{$options[:repo_dir].basename} is not a Rubygems project."
end

abort_if_errors

$options[:lib_dir].children.each do |c|
  if c.directory?
    vf = c + 'version.rb'
    if vf.exist?
      $options[:version_file] = vf
      break
    end
  end
end

if $options[:version_file].nil?
  $errors << 'Found no version.rb file in project'
else
  if $options[:version_file].read.index(VERSION_PLACEMENT_TAG).nil?
    $warnings << "The version file does not have the tag: #{VERSION_PLACEMENT_TAG}"
  end
end

abort_if_errors

######################################################
# Local methods

relative_path_to_version_rb = $options[:version_file].to_s.gsub(
  $options[:repo_dir].to_s+'/',''
  )

dot_rultor_yml = <<EOS
decrypt:
  rubygems.yml: "repo/rubygems.yml.asc"
release:
  script: |
    rm -rf *.gem
    sed -i "s/#{VERSION_PLACEMENT_TAG}/${tag}/g" #{relative_path_to_version_rb}
    gem build #{$options[:repo_dir].basename}.gemspec
    chmod 0600 /home/r/rubygems.yml
    gem push *.gem --config-file /home/r/rubygems.yml
EOS



######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

pp $options if verbose? || debug?




puts <<EOS

TODO:

  check if the rultor gem is installed
    if not then install it

  copy rubygems creds to repo_dir
  write .rultor.yml to directory
  rultor encrypt -p #{$options[:user_account]}/#{$options[:repo_dir].basename} rubygems.yml

  git add .rultor.yml rubygems.yml.asc

  Done.

EOS

