#!/usr/bin/env ruby
############################################################
###
##  File: image_metadata.rb
##  Desc: Show the metadata contained in an image file
#

require 'rmagick'

usage = <<END_INFO

Show the metadata contained in an image file

END_INFO

if ARGV.empty?
  puts usage
  puts 'ERROR: Specify one or more image filenames as arguments.'
  exit
end

ARGV.each do |file|
  puts "\n" + "="*65
  puts "== #{file}"

  error = false
  begin
    img = Magick::Image.read(file).first
  rescue => e
    STDERR.puts "\nERROR: #{e}"
    STDERR.puts "Delete File? yes|[no] "
    answer = STDIN.gets
    if answer.downcase.start_with?('yes')
      system "rm #{file}"
    end
    error = true
  end

  next if error

  puts "   Format: #{img.format}"
  puts "   Geometry: #{img.columns}x#{img.rows}"
  puts '   Class: ' + case img.class_type
                      when Magick::DirectClass
                        'DirectClass'
                      when Magick::PseudoClass
                        'PseudoClass'
                      end
  puts "   Depth: #{img.depth} bits-per-pixel"
  puts "   Colors: #{img.number_colors}"
  puts "   Filesize: #{img.filesize}"
  puts "   Resolution: #{img.x_resolution.to_i}x#{img.y_resolution.to_i} "\
       "pixels/#{img.units == Magick::PixelsPerInchResolution ?
       'inch' : 'centimeter'}"

  if img.properties.length > 0
    puts '   Properties:'
    img.properties do |name,value|
      puts %Q|      #{name} = "#{value}"|
    end
  end
end
