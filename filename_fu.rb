#!/usr/bin/env ruby
###########################################################
###
##  File: filename_fu.rb
##  Desc: add/remove prefix/suffix
##
#

require 'pathname'  # STDLIB
require 'optparse'  # STDLIB
require 'ostruct'   # STDLIB

require 'amazing_print'  # Pretty print Ruby objects with proper indentation and colors
require 'pp'

# Turn the command line options into a usable structure
class MyCommandLine

  # parse the ARGV array
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


  # parse an array of command line parameters
  def self.parse_these_args(args)

    options = OpenStruct.new

    options.dryrun    = false         # Don't change anything; just report what would have been done
    options.debug     = false         # Insert software defects liberally throughout the code

    # basenames kept as strings
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
    options.user_dir  = false         # Did the user explicitly give a directory?
    options.files     = []            # Can not include directories

    options.prefix    = ""
    options.suffix    = ""

    # TODO: Add replace substring with something else;
    #       Common Use Case: replace spaces with underscores
    options.substr    = ""            # sub-strings can only be deleted/removed

    options.sequence  = false         # indicates presences of '#' in either prefixx or suffix
    options.prefix_seq= ""            # Work area for inserting a sequence field
    options.suffix_seq= ""            # Work area for inserting a sequence field
    options.seq_start = 1             # start sequence number at this number
    options.seq_incr  = 1             # value to increment the sequence number for each file
    options.seq_size  = 2             # size of the zero-filled sequence number field

    # maximum number of files that can be supported with the sequence numbering specifications
    # SMELL: this formula is doplicated in the validate options methods
    options.seq_max_f = ( (10**options.seq_size - 1) / options.seq_incr ) - options.seq_start / options.seq_incr

    options.rename_file = nil         # a Proc to do the work; set after all options have been validated

    opt_parser = OptionParser.new do |o|

      o.default_argv = ['--help'] if ARGV.empty?

      o.program_name = Pathname.new(__FILE__).basename.to_s

      o.banner  =  "\nAdd/Remove a Prefix/Suffix to Filenames"
      o.banner  += "\n\nUsage: #{o.program_name} [options]"

      o.separator ""
      o.separator "Specific options available:"
      o.separator ""

      o.on("", "--dryrun", "Show what would have happened without doing it") do |v|
        options.dryrun  = v
      end

      o.on("-p", "--prefix S", String, "Prefix for filename") do |v|
        options.prefix    = v
        options.sequence  = true if v.include?('#')
      end

      o.on("-s", "--suffix S", String, "Suffix for filename") do |v|
        options.suffix    = v
        options.sequence  = true if v.include?('#')
      end

      o.on("", "--substr S", String, "Remove a sub-string from filename") do |v|
        options.substr = v
      end

      o.on("-n", "--number start,increment,field_size", Array,
          "Sequence Number start, increment and field_size (DEFAULT: #{options.seq_start},#{options.seq_incr},#{options.seq_size}") do |v|
        options.seq_start = v[0].to_i
        options.seq_incr  = v[1].to_i if v.size > 1
        options.seq_size  = v[2].to_i if v.size > 2
        options.seq_max_f = ( (10**options.seq_size - 1) / options.seq_incr ) - options.seq_start / options.seq_incr
      end

      o.on("-a", "--add", "Add to filename (DEFAULT)") do |v|
        options.add       = v
        options.user_add  = true
      end

      o.on("-r", "--remove", "Remove from filename") do |v|
        options.remove = v
      end

      o.on("-f", "--files x,y,z...", Array, "List of filenames") do |v|
        options.files = v.map {|f| Pathname.new(f)}
      end

      o.on("-d", "--directory S", String, "Directory to process (DEFAULT: #{options.directory})") do |v|
        options.directory = Pathname.new(v)
        options.user_dir  = true
      end

      o.on("-R", "--recursive", "Process all subdirectories") do |v|
        options.recursive = v
      end

      o.on("-x", "--exclude x,y,z", Array, "List of directories and filenames to exclude") do |v|
        options.exclude += v  # keep as strings
      end

      o.separator ""
      o.separator "Common options available:"
      o.separator ""

      o.on_tail("", "--debug", "Add software defects to code") do |v|
        options.debug   = v
        $DEBUG          = v
        options.dryrun  = v
      end

      o.on_tail("-v", "--verbose", "Run verbosely") do |v|
        options.verbose = v
      end

      o.on_tail("-h", "--help", "Show this message") do
        puts o
        puts <<EOS

Note:

Filename extensions are maintained.  Suffix addition and removal
are done to the filename component in front of the extension.

The following default directories and filenames are excluded:

  #{options.exclude.join(', ')}

'#' is reserved character that indicates sequence numbers within a
prefix or suffix.  Sequence number start, increment and field_size
parameters are specified with the --number option.  For example
"--number 5,5,3" means start numbering at 5 and increment the
sequence number by 5 within a field_size of 3 for each file.  This
gives a sequence field from 005 to 995 which limits on the number
of files that can be processed to approximately 194.  Any more files
and the field size will overflow.

The default is "#{options.seq_start},#{options.seq_incr},#{options.seq_size}"

--substr only removes sub-strings from the filename.  Sub-strings can
not be added/inserted.  Sequence numbers '#' are not allowed in sub-strings.

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

  end  # def self.parse_these_args(args)


  # validate the options specified and report all errors
  def self.validate(options,parse_errors=[])

    ap options.to_h if $DEBUG

    errors = parse_errors
    errors << "--add and --remove are mutually exclusive"         if options.add and options.remove
    errors << "no --prefix, --suffix, or --substr was specified"  if options.prefix.empty? and options.suffix.empty? and options.substr.empty?
    errors << "root directory operations are not allowed"         if options.directory == Pathname.new("/")
    errors << "--prefix can have one and only one '#'"            if options.prefix.count('#') > 1
    errors << "--suffix can have one and only one '#'"            if options.suffix.count('#') > 1
    errors << "--substr can not have a '#' character"             if options.substr.count('#') > 0
    errors << "--number sequence start must positive"             if options.seq_start < 0
    errors << "--number sequence increment must positive"         if options.seq_incr  < 0
    errors << "--number sequence field size must positive"        if options.seq_size  < 0

    if options.sequence
      if (options.files.size > options.seq_max_f)
        errors << "Too many files #{options.files.size}; sequence field allows for only #{options.seq_max_f}"
      end
      unless options.files.size > 0
        files_in_dir = options.directory.children.size # approximately
        if files_in_dir > options.seq_max_f
          errors << "Too many files #{files_in_dir}; sequence field allows for only #{options.seq_max_f}"
        end
      end
    end

    errors << "--recursive not allowed with sequence numbers"     if options.sequence and options.recursive
    errors << "--remove not allowed with sequence numbers"        if options.remove and options.sequence
    errors << "directory does not exist"                      unless options.directory.exist?

    if options.user_dir and options.files.length > 0
      errors << "--directory and --files are mutually exclusive"
    end

    options.files.each do |f|
      errors << "file/directory does not exist: #{f}" unless f.exist?
      errors << "#{f.basename}, a directory, is not allowed in the --files list" if f.directory?
    end

    # report all errors
    unless errors.empty?
      STDERR.puts "\nThe following errors must be corrected before execution can proceed:"
      STDERR.puts
      errors.each { |e| STDERR.puts "\tERROR: #{e}" }
      STDERR.puts "\nUse --help to see usage summary."
      STDERR.puts
      exit
    end

    options

  end # def self.validate(options,parse_errors=[])

end # class MyCommandLine


# Rename files using prefix/suffix/substr and sequence numbers
class FilenameFu

  @@sequence = -1 # MAGIC: signals uninitialized

  def self.doit(a_filename, options)

    if options.sequence
      if @@sequence < 0
        @@sequence = options.seq_start
      else
        @@sequence += options.seq_incr
      end
    end

    @options    = options
    @file_path  = a_filename.class == Pathname ? a_filename : Pathname.new(a_filename)
    @file_dir   = @file_path.dirname
    @file_ext   = @file_path.extname
    temp_str    = @file_path.basename.to_s
    temp_str_l  = temp_str.length
    @filename   = temp_str[0,temp_str_l-@file_ext.length]

    add     if options.add
    remove  if options.remove

    b_filename = @file_dir + (@filename + @file_ext)

    unless a_filename == b_filename
      if options.verbose
        puts "\nRenaming: #{a_filename}"
        puts "      To: #{b_filename}"
      end
      options.rename_file.call(a_filename, b_filename)
    end

  end # def self.doit(a_filename, options)


  # repace any '#' characters in prefix or suffix with a sequence field
  def self.create_sequence_field
    @options.prefix_seq = @options.prefix.dup
    @options.suffix_seq = @options.suffix.dup
    seq = sprintf("%0#{@options.seq_size}i", @@sequence)
    @options.prefix_seq.gsub!('#', seq)
    @options.suffix_seq.gsub!('#', seq)
  end


  # add prefix and suffix
  def self.add
    puts "...add (#{@@sequence})" if $DEBUG
    if @options.sequence
      create_sequence_field
      @filename = @options.prefix_seq + @filename + @options.suffix_seq
    else
      @filename = @options.prefix + @filename + @options.suffix
    end
  end


  # remove prefix, suffix and substr
  def self.remove
    puts "...remove" if $DEBUG
    if @filename.start_with?(@options.prefix) and !@options.prefix.empty?
      puts "...prefix #{@options.prefix}" if $DEBUG
      @filename = @filename[@options.prefix.length, 99999] # MAGIC: no filename is this large
    end
    if @filename.end_with?(@options.suffix) and !@options.suffix.empty?
      puts "...suffix #{@options.suffix} from #{@filename}" if $DEBUG
      @filename = @filename[0,@filename.length-@options.suffix.length]
      puts "......new name: #{@filename}" if $DEBUG
    end
    unless @options.substr.empty?
      puts "...substr #{@options.substr}" if $DEBUG
      @filename.gsub!(@options.substr, "")
    end
  end

end # class FilenameFu


###########################################################
## Main

# used when the --dryrun options is specified
dryrun_proc = Proc.new do |current_name, new_name|
  puts "DryRun: #{current_name.basename}"
  puts "    To: #{new_name.basename}"
  puts "  WARNING: new filename already exists" if new_name.exist?
end


# Tell the file to rename itself
livefire_proc = Proc.new do |current_name, new_name|
  current_name.rename(new_name)
end


# Recursively as needed process a batch for files
def process_files(files, options)

  files.each do |f|
    # Do not recurse into excluded directories
    if options.recursive and f.directory? and !options.exclude.include?(f.basename.to_s)
      puts "Entering Directory: #{f.basename}" if $DEBUG
      process_files(f.children, options)
    else
      FilenameFu.doit(f, options) unless f.directory? or options.exclude.include?(f.basename.to_s)
    end
  end

end # def process_files(files)

options = MyCommandLine.parse

options.rename_file = options.dryrun ? dryrun_proc : livefire_proc

if options.dryrun
  puts "\nThis is a  *** DRY RUN ***"
end

if options.verbose
  puts "\nRunning with the following options:"
  ap options.to_h
  puts
end

files = options.files.empty? ? options.directory.children : options.files

process_files(files, options)

## The End
##########

