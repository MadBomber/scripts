#!/usr/bin/env ruby
# encoding: utf-8
##########################################################
###
##  File: s3_uploader.rb
##  Desc: Upload files to an AWS/S3 bucket
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# TODO: complete this stub

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe

require 'pathname'  # STDLIB
require 'hipchat_s3'

me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  debug:          false,
  notify:         true,
  s3: {
        access_key_id:      ENV['AWS_ACCESS_KEY_ID']     || 'unknown',
        secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'] || 'unknown',
        bucket:             ENV['AWS_S3_BUCKET']         || 'unknown'
      },
  hipchat: {
        api_token:  ENV['HIPCHAT_TOKEN'] || 'unknown',
        room_name:  ENV['HIPCHAT_ROOM']  || 'unknown'
      }
}


def verbose?
  $options[:verbose]
end

def debug?
  $options[:debug]
end

def notify?
  $options[:notify]
end


usage = <<EOS

__file_description__

Usage: #{my_name} [options] parameters

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress
    -o or --output      Specifies the path to the output
        out_filename      file.  The extname must be 'ics'
                          Defaults to STDOUT

  parameters            The parameters required by
                        the program

NOTE:

  Something_imporatant

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


# only gets valid files of one type
def get_pathnames_from(an_array, extnames=['.json', '.txt', '.docx'])
  an_array = [an_array] unless an_array.is_a? Array
  extnames = [extnames] unless extnames.is_a? Array
  extnames = extnames.map{|e| e.downcase}
  file_array = []
  an_array.each do |a|
    pfn = Pathname.new(a)
    if pfn.directory?
      file_array << get_pathnames_from(pfn.children, extnames)
    else
      file_array << pfn if pfn.exist? && extnames.include?(pfn.extname.downcase)
    end
  end
  return file_array.flatten
end # def get_pathnames_from(an_array, extname='.json')


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
if  ARGV.empty?               ||
    ARGV.include?('-h')       ||
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

%w[ -o --output ].each do |param|
  get_out_filename( ARGV.index(param) ) if ARGV.include?(param)
  unless $options[:out_filename].nil?
    unless $options[:out_filename].parent.exist?
      $errors << "Directory does not exist: #{$options[:out_filename].parent}"
    end
  end
end


ARGV.compact!

# ...

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

pp $options  if verbose? || debug?

stub = <<EOS


   d888888o. 8888888 8888888888 8 8888      88 8 888888888o
 .`8888:' `88.     8 8888       8 8888      88 8 8888    `88.
 8.`8888.   Y8     8 8888       8 8888      88 8 8888     `88
 `8.`8888.         8 8888       8 8888      88 8 8888     ,88
  `8.`8888.        8 8888       8 8888      88 8 8888.   ,88'
   `8.`8888.       8 8888       8 8888      88 8 8888888888
    `8.`8888.      8 8888       8 8888      88 8 8888    `88.
8b   `8.`8888.     8 8888       ` 8888     ,8P 8 8888      88
`8b.  ;8.`8888     8 8888         8888   ,d8P  8 8888    ,88'
 `Y8888P ,88P'     8 8888          `Y88888P'   8 888888888P


EOS

puts stub


# __END__

hipchat_s3 = HipchatS3.new(
  {  :s3 => {
        :access_key_id => 'your-key',
        :secret_access_key => 'your-secret',
        :bucket => 'bucket'
      },
      :hipchat => {
        :api_token => 'your-token'
      }
  }
)

hipchat_s3.s3_bucket = "another_bucket" # you can change your bucket name whenever you need

# displays thumbnail in chat that links to full size image
hipchat_s3.create_inline_image(
      'image_path.jpg',
      hipchat_room_id,
      {   :thumbnail_path => "thumb_path.jpg",
          :username => "Magic",
          :message => "message",
          :color => "green"
      }
)

# displays full size image, no thumbnail, directly in the chat
hipchat_s3.create_inline_image('image_path.jpg', hipchat_room_id)

# compresses a directory or file and uploads a tar.gz, linked to the room
hipchat_s3.create_compressed_upload(
  path_to_compress,
  hipchat_room_id,
  {   :message => "Files Compressed",
      :color => "green"
  }
)

# uploads an uncompressed file to s3, displays link in chat
hipchat_s3.create_file_upload(
  file_path,
  hipchat_room_id,
  {   :username => "FileManager"
  }
)

# you can also access the chat object directly
hipchat_s3.hipchat_client[hipchat_room_id].send(
  "Enforcer",
  "Failure! You can't do that!!!",
  :notify => true,
  :color => "red"
)






