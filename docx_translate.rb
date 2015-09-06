#!/usr/bin/env ruby
##########################################################
###
##  File: docx_translate.rb
##  Desc: Machine translation of *.docx files
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'debug_me'

require 'pathname'
require 'pathname_helpers'

require 'docx'
require 'docx_helpers'
include DocxHelpers


require 'google_translate'    # Screen scrapper 'google-translate'
$glate = GoogleTranslate.new


me        = Pathname.new(__FILE__).realpath
my_dir    = me.parent
my_name   = me.basename.to_s

$options = {
  verbose:        false,
  from_language:  :en,
  to_language:    :es,
  ignore_pstyle:  [],
  paths:          []
}

def verbose?
  $options[:verbose]
end

usage = <<EOS

Test out some of the common translation gems

Usage: #{my_name} options english_file

Where:

  options               Do This
    -h or --help        Display this message
    -v or --verbose     Display progress

    -f or --from        Source language
    -t pr --to          Target language

  source_file           File to translate

EOS

# Check command line for Problems with Parameters
errors = []

if  ARGV.empty?               ||
    ARGV.include?('-h')       ||
    ARGV.include?('--help')
  puts usage
  exit
end

%w[ -v --verbose ].each do |param|
  if ARGV.include? param
    $options[:verbose] = true
    ARGV[ ARGV.index(param) ] = nil
  end
end

%w[ -f --from ].each do |param|
  if ARGV.include? param
    param_index = ARGV.index(param)
    if param_index+1 >= ARGV.size
      # FIXME: errors is not global
      $errors << "#{ARGV[param_index]} specified without parameter"
    else
      $options[:from_language] = ARGV[param_index+1].to_sym
      ARGV[param_index+1] = nil
    end

    ARGV[param_index] = nil
  end
end


%w[ -t --to ].each do |param|
  if ARGV.include? param
    param_index = ARGV.index(param)
    if param_index+1 >= ARGV.size
      # FIXME: errors is not global
      $errors << "#{ARGV[param_index]} specified without parameter"
    else
      $options[:to_language] = ARGV[param_index+1].to_sym
      ARGV[param_index+1] = nil
    end

    ARGV[param_index] = nil
  end
end



ARGV.compact!

$options[:paths] = ARGV.map { |f| Pathname.new(f) } unless ARGV.empty?
$options[:paths].select! { |f| f.exist? && '.docx' == f.extname.downcase } unless ARGV.empty?

if $options[:paths].empty?
  errors << "No valid *.docx files were specified."
end

unless errors.empty?
  STDERR.puts
  STDERR.puts "Correct the following errors and try again:"
  STDERR.puts
  errors.each do |e|
    STDERR.puts "\t#{e}"
  end
  STDERR.puts
  exit(1)
end


######################################################
# Local methods

def translate_paragraph(  text,
                          from_language = $options[:from_language],
                          to_language   = $options[:to_language]
                        )

  result = $glate.translate( from_language, to_language, text )[0]
  result_str = result.map { |t| t[0] }.join(' ')

end

######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end



$options[:paths].each do | from_filepath |

  if verbose?
    print "Translating (#{$options[:from_language]}-=>#{$options[:to_language]}) #{from_filepath.basename} ... "
  else
    print '.'
  end

  docx = Docx::Document.open( from_filepath )

  there_was_a_problem = false

  docx.paragraphs.each do |para|

    next if $options[:ignore_pstyle].include?( get_paragraph_style_name(para) )

    begin
      para.text = translate_paragraph( para.text )
    rescue Exception => e
      there_was_a_problem = true
      #STDERR.puts "#{e}"
    end
  end

  new_file = from_filepath.parent + from_filepath.basename.to_s.
    gsub( "_#{$options[:from_language]}",
          "_#{$options[:to_language]}")

  docx.save(new_file)

  if verbose?
    if there_was_a_problem
      puts "** PROBLEM **"
    else
      puts 'done.'
    end
  end

end # $options[:paths].each do | en_filepath |

