#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: release.rb
##  Desc: Use gcli from gem github_api to create
##        an issue within a github-stored project
##        that invokes @rultor
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'  # A tool to print the labeled value of variables.
require 'pathname'  # STDLIB
require_relative 'lib/find_repo_dir'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  debug:          false,
  user_account:   'MadBomber',
  repo:           nil,
  version:        ENV['tag'],
  out_filename:   nil
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end

usage = <<EOS

Build and release a gem via @rultor in github

Usage: #{my_name} [options]

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress
    -d or --debug       Kill the bugs
    -o or --output      Specifies the path to the output
        out_filename      file.  The extname must be 'ics'
                          Defaults to STDOUT

    -r or --repo        The name of the gem's github
      repo_name         repository.  The default is
                        the repo where executed.

    -t or --tag         The 'tag' i.e. version to be
      version           built and released.

    -u or --user        The github user's name
       user_account


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
def get_out_filename(param_index)
  filename_str = get_next_parameter(param_index)
  $options[:out_filename] = Pathname.new( filename_str ) unless filename_str.nil?
end # def get_out_filename(param_index)


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
  if ARGV.include?(param)
    $options[:repo] = get_next_parameter( ARGV.index(param) )
  end
end

%w[ -t --tag --version ].each do |param|
  if ARGV.include?(param)
    $options[:version] = get_next_parameter( ARGV.index(param) )
  end
end

%w[ -u --user ].each do |param|
  if ARGV.include?(param)
    $options[:user_account] = get_next_parameter( ARGV.index(param) )
  end
end

ARGV.compact!

unless ARGV.empty?
  $errors << "Unknown parameters: #{ARGV.join(' ')}"
end

if $options[:version].nil?
  # TODO: could ask for the tag
  $errors << "No 'tag' has been specified."
end

if $options[:repo].nil?
  $warnings << "No 'repo' has been specified.  Continue to search for one in your CWD."
end


abort_if_errors


######################################################
# Local methods


######################################################
# Main

at_exit do
  if verbose?
    puts
    puts "Done."
    puts
  end
end

pp($options) if verbose? || debug?

if $options[:repo].nil?
  puts "\nLooking for current git repo name ..." if verbose?
  $options[:repo] = find_repo_dir
  $options[:repo] = $options[:repo].basename unless $options[:repo].nil?
end

if $options[:repo].nil?
  $errors << "No 'repo' has been specified."
  abort_if_errors
end

STDERR.print "\nDo you want to release #{$options[:repo]} version #{$options[:version]} (y/N) ? "
answer = (gets).chomp.strip.downcase

if answer.size>0 && 'y' == answer[0]
  command = "gcli issue create" +
      " #{$options[:user_account]} #{$options[:repo]}" +
      " --title='release #{$options[:version]}'" +
      " --body='@rultor release, tag=`#{$options[:version]}`'"
  puts command if verbose?
  system command unless debug?
end

