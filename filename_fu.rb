#!/usr/bin/env ruby
###########################################################
###
##  File: filename_fu.rb 
##  Desc: add/remove prefix/suffix
##
##  Parameters on the Command Line
##
##    -a -r -p -s -d -f --add --remove --directory --files
#

require 'pathname'
require 'optparse'
require 'ostruct'

require 'awesome_print'
require 'pp'

dry_run_proc = Proc.new do |current_name, new_name|
  puts "DryRun: #{current_name}  becomes  #{new_name}"
  puts "  WARNING: new filename already exists" if new_name.exist?
end

rename_file_proc = Proc.new do |current_name, new_name|
  current_name.rename(new_name)
end


class MyCommandLine

  def self.parse

    # Preprocess ARGV because OptionParser cannot handle splats
    # change ['-f', 'x', 'y', 'z', '--any-switch']
    # to ['-f', 'x,y,z', '--any-switch']

    my_args = []

    my_args << ARGV.shift

    previous_arg_was_switch = '-' == my_args.first[0,1]

    until ARGV.empty? do
      arg = ARGV.shift
      if '-' == arg[0,1]
        previous_arg_was_switch = true
        my_args << arg
      else
        if previous_arg_was_switch
          my_args << arg
          previous_arg_was_switch = false
        else
          last = my_args.length - 1
          my_args[last] += ',' + arg
        end
      end
    end # until ARGV.empty? do
    parse_these_args(my_args)
  end # def self.parse

  def self.parse_these_args(args)

    options = OpenStruct.new

    options.exclude = %w{
      .svn
      .git
      .DS_Store
    }
    options.recursive = false
    options.add       = true
    options.user_add  = false         # Did the user explicitly select add?
    options.remove    = false
    options.directory = Pathname.pwd
    options.files     = []
    options.prefix    = ""
    options.suffix    = ""
    options.substr    = ""
    options.dry_run   = false

    opt_parser = OptionParser.new do |o|

      o.default_argv = ['--help'] if ARGV.empty?

      o.program_name = Pathname.new(__FILE__).basename.to_s

      o.banner  =  "\nAdd/Remove a Prefix/Suffix to Filenames\n\n"
      o.banner  += "Usage: #{o.program_name} [options]"

      o.separator ""
      o.separator "Specific options available:"

      o.on("", "--dry_run", "Show what would have happened without doing it") do |v|
        options.dry_run = v
        options.verbose = true if options.dry_run
      end

      o.on("-p", "--prefix S", String, "Prefix for filename") do |v|
        options.prefix = v
      end

      o.on("-s", "--suffix S", String, "Suffix for filename") do |v|
        options.suffix = v
      end

      o.on("", "--substr S", String, "Remove a sub-string from filename") do |v|
        options.thing = v
      end

      o.on("-a", "--add", "Add to filename (DEFAULT)") do |v|
        options.add       = v
        options.user_add  = true
      end

      o.on("-r", "--remove", "Remove from filename") do |v|
        options.remove = v
      end

      o.on("-f", "--files x,y,z", Array, "List of filenames") do |v|
        options.files = v.map {|f| Pathname.new(f)}
      end

      o.on("-d", "--directory S", String, "Directory to process (DEFAULT: current working directory)") do |v|
        options.directory = Pathname.new(v)
      end

      o.on("-R", "--recursive", "Process all subdirectories") do |v|
        options.recursive = v
      end

      o.on("-x", "--exclude x,y,z", Array, "List of directories abd filenames to exclude") do |v|
        options.exclude += v.map {|f| Pathname.new(f)}
      end


      o.separator ""
      o.separator "Common options available:"

      o.on_tail("-h", "--help", "Show this message") do
        puts o
        puts <<EOS

Note:

Filename extensions are maintained.  Suffix addition and removal
are done to the filename component in front of the extension.

The following default directories and filenames are excluded:

  #{options.exclude.join(', ')}

'#' is reserved character that indicates sequence numbers within a
prefix or suffix.  Using more that one '#' indicates a zero-filled
sequence field of the specified length.

--substr only removes sub-strings from the filename.  Sub-strings can
not be added/inserted.

Both --prefix and --suffix can be added or removed at the same time;
however, only one action at a time is allowed (i.e., you can not add
a prefix and expect to be able to remove a suffix in the same operation.)

--add and --remove are mutually exclusive.

Only one --directory can be processed at a time.  Be aware that if you specify
the "/" root directory with the --recursive option that ALL FILES on your
filesystem will be changed.

--files can only specify one or more files.  Directories are not allowed.

Examples:

  #{o.program_name} -R -s _es
    add '_es' as a suffix to all files in the current directory and
    recursively to all files in all sub-directories.

  #{o.program_name} -p print_ -d Pictures/Vacation
    add the prefix 'print_' to all files in the relative from current
    directory path './Pictures/Vacation'

  #{o.program_name} -p print_ -s _### -d Pictures/vacation
    add a fixed prefix string 'print_' and a zero-filled three number
    suffix to all files in the indicated path

  #{o.program_name} -s _dollywood -p print_ -d Pictures/vacation
    add a fixed prefix and suffix to the files in the specified
    directory

  #{o.program_name} -r -s _dollywood -p print_ -d Pictures/vacation
    remove both the fixed prefix and suffix for all files in the
    supplied directory

  #{o.program_name} -R -p hacked_ -d /
    add the prefix to every filename on the entire filesystem

EOS
        exit
      end

      o.on_tail("-v", "--[no-]verbose", "Run verbosely") do |v|
        options.verbose = v
      end

    end # end of opt_parser = OptionParser.new do |o|

    errors = []
    begin
      opt_parser.parse!(args)
    rescue OptionParser::InvalidOption => e
      errors << e
      retry
    end

    # Adjust options where defaults are not as user wants
    unless options.user_add
      if options.remove
        options.add = false
      end
    end

    validate(options, errors)
  
  end  # parse()

  def self.validate(options,parse_errors=[])
    errors = parse_errors
    errors << "--add and --remove are mutually exclusive"         if options.add and options.remove
    errors << "no --prefix, --suffix, or --substr was specified"  if options.prefix.empty? and options.suffix.empty? and options.substr.empty?
    errors << "root directory operations are not allowed"         if options.directory == Pathname.new("/")
    errors << "sequence number operations are not implemented"    if options.prefix.include?('#') or options.suffix.include?('#')
    errors << "directory does not exist"                      unless options.directory.exist?

    options.files.each do |f|
      errors << "file/directory does not exist: #{f}" unless f.exist?
    end

    unless errors.empty?
      puts "\nThe following errors must be corrected before execution can proceed:"
      puts
      errors.each { |e| puts "\tERROR: #{e}" }
      puts "\nUse --help to see usage summary."
      puts
      exit
    end

    options
  end

end # class MyCommandLine


class FilenameFu

  def init(a_filename, options)
    @options    = options
    @file_path  = a_filename.class == Pathname ? a_filename : Pathname.new(a_filename)
    @file_dir   = @file_path.directory
    @file_ext   = @file_path.extname
    temp_str    = @file_path.basename.to_s
    temp_str_l  = temp_str.length
    @filename   = temp_str[0,temp_str_l-@file_ext.length]
  end

  def add
    @filename = @options.prefix + @filename + @options.suffix
  end

  def remove
    if @filename.start_with?(@options.prefix)
      @filename = @filename[@options.prefix.length-1,99999]
    end
    if @filename.end_with?(@options.suffix)
      @filename = @filename[0,@filename.length-@@options.suffix.length]
    end
    @filename.gsub(@options.substr, "") unless @options.substr.empty?
  end

end # class FilenameFu


###########################################################
## Main

options = MyCommandLine.parse


options.dry_run = true



rename_file = options.dry_run ? dry_run_proc : rename_file_proc



