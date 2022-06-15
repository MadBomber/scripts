#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: resize_images.rb
##  Desc: resize the images
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# 1920x1080
# 1024x1024
# 1920x692


require 'mini_magick'

require 'amazing_print'

require 'debug_me'
include DebugMe

require 'cli_helper'
include CliHelper

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

  The original image is never modified.

EOHELP

cli_helper("Show the image metadata") do |o|

  o.string  '-f', '--format', 'format conversion',  default: '.png'
  o.string        '--wxh',    'Resize WxH',         default: '1920x1080'
  o.path    '-o', '--outdir', 'Output Directory',   default: Pathname.pwd + 'resized_images'
  o.bool    '-s', '--show',   'Show some Metadata', default: false
  o.bool    '-r', '--resize', 'Resize the image',   default: false
  o.bool    '-a', '--all',    'Show all Metadata',  default: false

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

configatron.input_files = get_pathnames_from( configatron.arguments, %w[ .jpg .png .gif ])

if configatron.input_files.empty?
  error 'No text files were provided'
end

unless show? || resize?
  error "Must chose --show or --resize or both"
end

unless configatron.outdir.exist?
  configatron.outdir.mkdir
end

abort_if_errors


######################################################
# Local methods

def resize_image(
    filepath,
    new_size=configatron.wxh,
    new_format=configatron.format
  )

  old_filename  = filepath.basename.to_s
  extension     = filepath.extname
  new_filename  = old_filename.gsub(extension, "-#{new_size}#{new_format}")
  new_filepath  = configatron.outdir + new_filename

  image = MiniMagick::Image.open(old_filename)

  image.resize  new_size
  image.format  new_format
  image.write   new_filepath
end


def show(filepath)
  image = MiniMagick::Image.open(filepath)

  puts
  puts "="*65
  puts "== #{filepath.basename}"
  puts

  if all?
    ap image.data
  else
    puts "tyoe:       #{image.type      }"  #=> "JPEG"
    puts "mime_type:  #{image.mime_type }"  #=> "image/jpeg"
    puts "width:      #{image.width     }"  #=> 250
    puts "height:     #{image.height    }"  #=> 300
    puts "dimensions: #{image.dimensions}"  #=> [250, 300]
    puts "size:       #{image.size      }"  #=> 3451 (in bytes)
    puts "colorspace# #{image.colorspace}"  #=> "DirectClass sRGB"
    puts "exif:       #{image.exif      }"  #=> {"DateTimeOriginal" => "2013:09:04 08:03:39", ...}
    puts "resolution: #{image.resolution}"  #=> [75, 75]
    puts "signature:  #{image.signature }"  #=> "60a7848c4ca6e36b8e2c5dea632ecdc29e9637791d2c59ebf7a54c0c6a74ef7e"
  end
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

configatron.input_files.each do |filepath|
  puts "Processing: #{filepath.basename} ..."

  if show?
    show(filepath)
  end

  if resize?
    resize_image filepath
  end
end

__END__

This INFO FROM SOURCE:   https://blog.hootsuite.com/social-media-image-sizes-guide/



Instagram profile photo size: 320 x 320 pixels

Instagram profile photos are stored at 320 x 320 pixels, so make sure to upload an image that’s least that big.

Even though the dimensions are in a square format, Instagram profile photos are displayed as a circle. Make sure any elements you want to focus on in the photo are centered so they don’t get cropped out.
Instagram image sizes for feed photos:

    Landscape: 1080 x 566 pixels
    Portrait: 1080 x 1350 pixels
    Square: 1080 x 1080 pixels
    Supported aspect ratios: Anywhere between 1.91:1 and 4:5
    Recommended image size: Width of 1080 pixels, height between 566 and 1350 pixels (depending on whether the image is landscape or portrait)

Tips:

    If you want your images to look their best on Instagram, aim to upload an image that is 1080 pixels wide.
    When you share an Instagram image that’s sized over 1080 pixels, Instagram will size it down to 1080 pixels.
    If you share a photo that has a resolution lower than 320 pixels, Instagram will size it up to 320 pixels.
    If your image is between 320 and 1080 pixels wide, Instagram will keep that photo at its original resolution, “as long as the photo’s aspect ratio is between 1.91:1 and 4:5 (a height between 566 and 1350 pixels with a width of 1080 pixels).”
    If your uploaded Instagram image is a different ratio, the platform will automatically crop your photo to fit a supported ratio.


Instagram image sizes for thumbnails:

    Display size: 161 x 161 pixels
    Recommended upload size: 1080 pixels wide

Tips:

    Remember that Instagram stores versions of these thumbnails that are as large as 1080 x 1080.
    To future-proof your Instagram feed and avoid pixelation, upload images that are as large as possible.

Instagram Stories image size: 1080 x 1920 pixels
Tips:

    This is an aspect ratio of 9:16.
    Uploading an image with a smaller pixel size (but the same aspect ratio) means the Story will buffer quickly.
    If you don’t use this ratio, the Story might show with strange cropping, zooming, or leave large sections of the screen blank.
    Instagram Reels use this same sizing.

Instagram carousel image sizes:


    Landscape: 1080 x 566 pixels
    Portrait: 1080 x 1350 pixels
    Square: 1080 x 1080 pixels
    Aspect ratio: landscape (1.91:1), square (1:1), vertical (4:5)
    Recommended image size: Width of 1080 pixels, height between 566 and 1350 pixels (depending on whether the image is landscape or portrait)

IGTV sizes:

    1080 x 1920 pixels
    This is an aspect ratio of 9:16.
    Cover photo: 420 x 654 pixels

Instagram ads image sizes:

    Landscape: 1080 x 566 pixels
    Square: 1080 x 1080 pixels
    Minimum width: 320 pixels
    Maximum width: 1080 pixels
    Supported aspect ratios: Anywhere between 1.91:1 and 4:5

Tips:

    Remember: Instagram ads appearing in users’ feeds cannot have more than 30 hashtags.
    There are also recommendations for the number of characters included in an ad’s primary text and headline.

Image sizes for Instagram Stories ads: 1080 x 1920 pixels
Tips:

    Instagram recommends leaving roughly “14% (250 pixels) of the top and bottom of the image free from text and logos” to prevent them from being covered.
    As of September 2020, Facebook and Instagram ads are no longer penalized if more than 20% of the ad space is text.

Twitter image sizes

Twitter image sizes for profile photos: 400 x 400 (recommended)

    Minimum image size: 200 by 200 pixels
    Maximum file size: 2MB

Twitter image size for header photos: 1500 x 500 pixels (recommended)
Tips:

    To future-proof the image, it’s best to use the maximum size.
    Header images are cropped to an aspect ratio of 3:1.
    Keep in mind that the way header images display changes depending on the monitor and browser being used.

Twitter images sizes for in-stream photos: 1600 x 900 pixels (recommended)

    Minimum size: 600 by 335 pixels
    Recommended aspect ratio: any aspect between 2:1 and 1:1 on desktop; 2:1, 3:4 and 16:9 on mobile
    Supported formats: GIF, JPG and PNG
    Maximum file size: Up to 5MB for photos and GIFs on mobile. Up to 15MB on the web.

Twitter card image size:

Twitter recognizes when a Tweet includes a URL. Twitter then crawls that website, pulling in content, including a Twitter image for the summary card. (This is how it all works, by the way.)

    Minimum size: 120 x 120 pixels
    Supported formats: GIF, JPG, PNG
    Maximum file size: 1MB

Tips:

    You can test what your Twitter summary card will look like and see a preview using the card validator.
    There are a range of different Twitter cards, so also a range of sizes. As well as the regular summary cards, there are summary cards with large images, app cards and player cards.

Twitter image sizes for fleets: 1080 x 1920 pixels
Tips:

    For now, fleets are mobile-only.

Twitter image sizes for ads:

    Single and multi-image tweets: Minimum 600 x 335 pixels, but use larger images for the best results.
    Website card image: 800 x 418 pixels for 1.91:1 aspect ratio. 800 x 800 for 1:1 aspect ratio. Max file size of 20MB.
    App card image: 800 x 800 pixels for 1:1 aspect ratio. 800 x 418 pixels for 1.91:1 aspect ratio. Max file size of 3MB.
    Carousels: 800 x 800 pixels for 1:1 aspect ratio. 800 x 418 pixels for 1.91:1 aspect ratio. Max file size of 20MB for 2-6 image cards.
    Direct Message card: 800 x 418 pixels for 1.91:1 aspect ratio. Max file size of 3MB.
    Conversation card: 800 x 418 pixels for 1.91:1 aspect ratio. Max file size of 3MB.

Resource: Find more information here on how to advertise on Twitter.
Facebook image sizes

Facebook updates its design and image dimensions constantly. The best strategy to future-proof your brand’s content is to always upload the highest-quality image you can. Stick to Facebook’s recommended file formats for the best results.

Facebook image sizes for profile photos: 170 x 170 pixels (on most computers)

Your Facebook profile picture will display at 170 x 170 pixels on desktop. But it will display as 128 x 128 pixels on smartphones.
Facebook image sizes for cover photos: 851 x 315 pixels (recommended)

    Display size desktop: 820 x 312 pixels
    Display size smartphone: 640 x 360 pixels
    Minimum size: 400 x 150 pixels
    Ideal file size: Less than 100KB

Tips

    To avoid any compression or distortion, upload a JPG or PNG file.
    Use the recommended pixel sizes for the fastest load times.
    Profile pictures and cover photos with logos or text work best when uploaded as a PNG file.
    Don’t drag to reposition once you’ve uploaded your cover photo.

Resource: Get more tips on creating great Facebook cover photos.
Facebook image sizes for posts and timeline photos:

Facebook automatically resizes and formats your photos when they are uploaded for the timeline to be 500 pixels wide and to fit the 1.91:1 aspect ratio.

But avoid pixelation or slow load times by remembering these sizes:

    Recommended size: 1200 x 630 pixels
    Minimum size: 600 x 315 pixels

Tips:

    If you are sharing 2-10 images in your brand’s Facebook post using the carousel display, images should be 1200 x 1200.
    This is a 1:1 ratio.

Facebook image sizes for event cover photos: 1200 x 628 pixels (recommended)
Tips

    This is about a 2:1 ratio.
    The size of your event cover photo can’t be edited after it’s been added to an event.

Facebook image sizes for panorama or 360 photos:

    Minimum image size: Facebook says that it should be “30,000 pixels in any dimension, and less than 135,000,000 pixels in total size.”
    Aspect ratio: 2:1

Tips

    Facebook automatically recognizes and processes these images based on “camera-specific metadata found in photos taken using 360-ready devices.”
    Files for these Facebook images can be up to 45 MB for JPEGs or 60 MB for PNGs.
    Facebook recommends using JPEGs for 360 photos and ensuring files aren’t bigger than 30 MB.

Facebook image sizes for Facebook Stories: 1080 x 1920 pixels (recommended)
Tips

    Facebook Stories take up the full screen of a phone. That’s an aspect ratio of 9:16.
    Don’t choose an image with a width smaller than 500 pixels.
    For Stories with text, consider leaving 14% of the top and bottom text-free. (That’s 250 pixels.) That way any call-to-action won’t be covered by your brand’s profile photo or buttons.

Facebook image sizes for ads:

    Sizes for Facebook Feed ads: At least 1080 x 1080 pixels. Minimum size 600 x 600 pixels. Ratio 1.91:1 to 1:1. Maximum file size of 30 MB.
    Sizes for Facebook Right Column ads: At least 1080 x 1080 pixels. Minimum size 254 x 133 pixels. Ratio 1:1. (Remember: These are a desktop-only ad format.)
    Facebook image sizes for Instant Articles: At least 1080 x 1080 pixels. Ratio 1.91:1 to 1:1. Maximum file size of 30 MB.
    Image sizes for Facebook Marketplace ads: At least 1080 x 1080 pixels. Ratio 1:1. Maximum file size of 30 MB.
    Image sizes for Facebook Search: At least 1080 x 1080 pixels. Minimum size 600 x 600 pixels. Ratio 1.91:1 to 1:1. Maximum file size of 30 MB.
    Facebook image sizes for Sponsored Messages: At least 1080 x 1080 pixels. Ratio 1.91:1 to 1:1. Maximum file size of 30 MB.
    Sizes for Messenger inbox ads: At least 1080 x 1080 pixels. Ratio 1:1. Minimum size 254 x 133 pixels. Maximum file size of 30 MB.
    Sizes for Messenger Stories ads: At least 1080 x 1080 pixels. Ratio 9:16. Minimum width of 500 pixels.

Resource: Here’s more info on how to advertise on Facebook.

YouTube image sizes

YouTube profile photo size: 800 x 800 pixels (recommended)
Tips

    Make sure the focus of your photo is centered for best results.
    Files should be JPEG, GIF, BMP or PNG. Animated GIFs won’t work.
    Photos will render at 98 x 98 pixels.

YouTube banner image size: 2048 x 1152 pixels (at minimum)

    Aspect ratio: 16:9
    Minimum area for text and logos without being cut off: 1235 x 338 pixels
    Maximum file size: 6MB

Resource: How to make the best YouTube channel art (plus 5 free templates).
YouTube video size: 1280 x 720 pixels (at minimum)
Tips

    YouTube recommends that videos intended for sale or rental have a higher pixel count: 1920 x 1080 pixels.
    YouTube requires videos to be 1280 x 720 pixels in order to meet HD standards.
    This is a 16:9 aspect ratio.

YouTube thumbnail size: 1280 x 720 pixels

