#!/usr/bin/env ruby
############################################################
###
##  File: image_resizer.rb
##  Desc: Resize an imaged to a desirable size
#

require 'rmagick'
include Magick

usage =  <<END_INFO

\An image is resized to the target size (retaining its original
aspect ratio, of course).

Usage:

    resizer.rb <filename <HxV>>
    Ex: resizer.rb ./photos/img_0010.jpg 640x480

where `filename' is the name of an image file and `HxV' is the
size of the thumbnail in pixels. The default size is 640x480 pixels.

END_INFO

DEFAULT_GEOM = '640x480'

if ARGV.empty?              ||
   ARGV.include?('-h')      ||
   ARGV.include?('--help')
  puts usage
  exit
elsif 2 == ARGV.size
  geom = ARGV[1]
else
  geom = DEFAULT_GEOM
end

image         = ARGV[0]
new_file_name = image.gsub('.', "_#{geom}.")

# Read the image and resize it. The `change_geometry' method
# computes the new image geometry and yields to a block. The
# return value of the block is the return value of the method.

img = Image.read(image)[0]
img.change_geometry!(geom) { |cols, rows| img.thumbnail! cols, rows }
img.write(new_file_name)


