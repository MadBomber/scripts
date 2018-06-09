#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: s3_downloader.rb
##  Desc: Download files from an AWS/S3 bucket
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'pathname'  # STDLIB
require 'nenv'      # Convenience wrapper for Ruby's ENV
require 'slop'      # Simple Lightweight Option Parsing

module Slop
  class PathOption < Option
    def call(value)
      Pathname.new(value)
    end
  end
  class PathsOption < ArrayOption
    def finish(opts)
      self.value = value.map { |f| Pathname.new(f) }
    end
  end
end # module Slop

require 'aws-sdk'  # AWS SDK for Ruby

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  version:        '0.0.1',
  arguments:      [],     # whats left after options and parameters are extracted
  verbose:        false,
  debug:          false,
  list:           false,
  files:          [],
  download_dir:   Pathname.new(Nenv.home+'/Downloads'),
  bucket:         Nenv.aws_s3_bucket || '',
  s3: {
        access_key_id:      Nenv.aws_access_key_id     || '',
        secret_access_key:  Nenv.aws_secret_access_key || ''
      },

}

def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end

def list?
  $options[:list]
end

HELP = <<ENDHELP

Important:

  The -l, --list parameter surpresses downloads.

  To see a list of all buckets use '-l -b /'

  Wildcards '*' and '?' can be used in filenames if
  the filename is surrounded in quotes.

  Example: -b bucket_name -f '*.txt'

  Use of wildcards may result in many files being
  downloaded.

  When specifing the filenames do not forget to
  include the folder name when the file resides
  within a folder inside the bucket.

ENDHELP

opts = Slop.parse do |o|
  o.banner = "\nDownload files from an AWS/S3 bucket"
  o.separator "\nUsage: #{my_name} [options] parameters"
  o.separator "\nWhere:"
  o.separator "  options"

  o.on '-h', '--help', 'show this message' do
    puts o
    puts HELP if defined?(HELP)
    exit
  end

  o.bool '-v', '--verbose', 'enable verbose mode'
  o.bool '-d', '--debug',   'enable debug mode'

  o.separator "\n  parameters"

  o.bool   '-l', '--list',   'list contents of bucket'
  o.string '-b', '--bucket', 'an S3 bucket name', default: $options[:bucket]
  o.array  '-f', '--files',  'one or more files to download'

  o.on '--version', "print the version: #{$options[:version]}" do
    puts $options[:version]
    exit
  end

  o.separator "\n"
end


$options.merge!(opts.to_hash)
$options[:arguments] = opts.arguments

# Display the usage info
if  ARGV.empty?
  puts opts
  puts HELP if defined?(HELP)
  exit
end

# Check command line for Problems with Parameters
$errors   = []
$warnings = []

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


credentials = Aws::Credentials.new(
    $options[:s3][:access_key_id],
    $options[:s3][:secret_access_key]
)

s3 = Aws::S3::Client.new(credentials: credentials)

begin
  bucket_accessor = s3.list_objects(bucket: $options[:bucket]) unless '/'==$options[:bucket]
  buckets = s3.list_buckets()[:buckets]
rescue Aws::S3::Errors::AccessDenied
  $errors << "Access denied to bucket #{$options[:bucket]}"
rescue Aws::S3::Errors::NoSuchBucket
  $errors << "AWS Bad Bucket Name: #{$options[:bucket]}"
rescue Aws::S3::Errors::SignatureDoesNotMatch => e
  $errors << "AWS Connection Error: #{e}"
end




unless $options[:arguments].empty?
  $errors << "Unknown arguments: #{$options[:arguments]}"
end




abort_if_errors


######################################################
# Local methods

def get_filenames_in_bucket(a_bucket_accessor)
  filenames = []
  a_bucket_accessor.first[:contents].each do |rrr|
    filenames << rrr[:key]
  end
  return filenames
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

pp $options  if debug?


if $options[:bucket].nil? || '/' == $options[:bucket]
  puts
  puts '.....Creation Date.....  Bucket Name........................'
  puts
  buckets.each do |bucket|
    print bucket[:creation_date].to_s + '  '
    puts bucket[:name]
  end

  puts
  puts
  exit
end

if list?
  # response = s3.list_objects(bucket: $options[:bucket])

  puts '...Last Modification...  ..Size..  ...Name (aka :key)....
  '
  bucket_accessor.first[:contents].each do |rrr|
    print rrr[:last_modified].to_s + '  '
    printf( '% 8d  ', rrr[:size])
    puts rrr[:key]
  end
  puts
  puts
  exit
end

# response = s3.list_objects(bucket: $options[:bucket])

$options[:files].map! do |filename|
  if filename.include?('*') || filename.include?('?')
    fn_regex = filename.gsub('*','.*').gsub('?','.')
    get_filenames_in_bucket(bucket_accessor).grep(Regexp.new(fn_regex))
  else
    filename
  end
end

$options[:files].flatten!

unless $options[:files].empty?

  $options[:files].each do |filename|
    path = $options[:download_dir] + filename
    verbose? ? puts("Downloading #{$options[:bucket]}/#{filename} ...") : print('.')
    File.open(path, 'wb') do |f|
      reap = s3.get_object({
                    bucket:   $options[:bucket],
                    key:      filename },
                    target:   f)
    end
  end

else

  STDERR.puts 'ERROR: No files were selected for download.'

end # unless $options[:files].empty?










