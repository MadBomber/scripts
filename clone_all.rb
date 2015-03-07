#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: clone_all.rb
##  Desc: Clone all the repos of a github user
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'

require 'pathname'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  debug:          false,
  user:           ENV['GITHUB_ACCOUNT'],
  out_dirname:    Pathname.pwd
}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end


usage = <<EOS

Clone all the github repos for a given user account

Usage: #{my_name} [options] [user_name]

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress
    -d or --debug       Kill the bugs
    -o or --dirname     The directory into which to
        out_dirname     clone the repos.
                          Default: #{$options[:out_dirname]}

  user_name             The name of the github user
                          Default: #{$options[:user]}

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
def get_out_dirname(param_index)
  dirname_str = get_next_parameter(param_index)
  $options[:out_dirname] = Pathname.new( dirname_str ) unless dirname_str.nil?
end # def get_out_dirname(param_index)


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

%w[ -o --outdir ].each do |param|
  get_out_dirname( ARGV.index(param) ) if ARGV.include?(param)
  unless $options[:out_dirname].nil?
    unless $options[:out_dirname].exist?
      $errors << "Directory does not exist: #{$options[:out_dirname].parent}"
    end
  end
end


ARGV.compact!

if ARGV.size > 1
  $errors << "Only one user at a time."
end

abort_if_errors

$options[:user] = ARGV.first unless ARGV.empty?

require 'github_api'

######################################################
# Local methods


######################################################
# Main

if verbose?
  at_exit do
    puts
    puts "Done."
    puts
  end
end

pp $options  if verbose? || debug?

repos = Github.repos.list user: $options[:user]

repos.each do |r|
  out_path = Pathname.new "#{$options[:out_dirname]}/#{r.name}"
  if out_path.exist?
    puts "Skipping #{r.name} ..." if verbose?
    next
  end
  puts "Cloning #{r.name} ..." if verbose?
  command = "git clone #{r.clone_url} " + out_path.to_s
  puts command if verbose? || debug?
  system command unless debug?
  puts
end


