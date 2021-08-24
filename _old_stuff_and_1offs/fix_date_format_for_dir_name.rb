#!/usr/bin/env ruby
#
# This is basicaly a one-off because the export from iphone
# created some bullshit directory names.  This code helps
# ti interactive correct those shity directory names into
# a more sane structure like this:
#
#   YYYY/YYY_MM/YYYY_MM_DD/images.*
#

require 'pathname'

MONTHS = {
  'January'   => '01',
  'Jan'       => '01',
  'February'  => '02',
  'Feb'       => '02',
  'March'     => '03',
  'Mar'       => '03',
  'April'     => '04',
  'Apr'       => '04',
  'May'       => '05',
  'June'      => '06',
  'Jun'       => '06',
  'July'      => '07',
  'Jul'       => '07',
  'August'    => '08',
  'Aug'       => '08',
  'September' => '09',
  'Sep'       => '09',
  'October'   => '10',
  'Oct'       => '10',
  'November'  => '11',
  'Nov'       => '11',
  'December'  => '12',
  'Dec'       => '12'
}

=begin

year = Pathname.pwd
yyyy = year.basename.to_s

year.children.each do |dir|
  parts = dir.basename.to_s.split

 if parts.size > 3
  puts
  puts dir.basename.to_s
  things  = parts[-3..]

  puts things

  if MONTHS.include? things.first
    puts "YES!"
    new_dir = dir.parent + things.join(' ')
    puts new_dir.basename.to_s
    dir.rename(new_dir) unless new_dir.exist?
  end

  next
 end

  next unless parts.last == yyyy
  mm = MONTHS[parts.first]

  next if mm.nil?

  dd = sprintf('%02d', parts[1].gsub(',', '').to_i)
  month = "#{yyyy}_#{mm}"
  day   = "#{month}_#{dd}"
  fix   = month + "/" + day
  system "mkdir -p #{month}"

  target_path = dir.parent + fix

  # puts target_path

  if target_path.exist?
    system "mv '#{dir.basename}'/* #{fix}"
    system "rm -fr '#{dir.basename}'"
  else
    system "mv '#{dir.basename}' #{fix}"
  end
end

# Now lets remove the designated dup file names

def remove_dup_files(marker=' (1)', here = Pathname.pwd)
  here.children.each do |child|
    basename = child.basename.to_s
    puts child if basename.size > 17

    if child.directory?
      # puts child.basename
      remove_dup_files(marker, child)
    end

    filename = child.basename.to_s
    if filename.include? marker
      new_filename = filename.gsub(marker, '')
      new_path = child.parent + new_filename
      if new_path.exist?
        child.delete
      else
        child.rename(new_path)
      end
    end
  end
end

# remove_dup_files(' (1)')
# remove_dup_files(' (2)')
# remove_dup_files(' (3)')
# remove_dup_files(' (4)')
# remove_dup_files(' (5)')
# remove_dup_files(' (6)')
# remove_dup_files(' (7)')
# remove_dup_files(' (8)')

=end

ROOT = Pathname.new "/Volumes/photo/Photos/demo_export_from_iphoto"
ear = '2011'

def copy_up_and_rm(year=nil)
  return if year.nil?
  year_dir = ROOT + year
  level_one_dirs = year_dir.children

  level_two_dirs = []
  level_one_dirs.each do |dir|
    next unless dir.directory?
    level_two_dirs << dir.children
  end

  level_two_dirs.flatten!

  level_two_dirs.reject!{|e| !e.directory?}

  level_two_dirs.sort.each do |dir|
    puts dir.basename
    target = dir
    dir.children.each do |child|
      next unless child.directory?
      puts "  #{child.basename}"
      source = child
      system "mv  -f '#{source}'/* #{target}"
      system "rm -fr '#{source}'"
      puts
    end
  end
end

copy_up_and_rm '2012'
copy_up_and_rm '2013'
copy_up_and_rm '2014'
copy_up_and_rm '2015'
copy_up_and_rm '2016'
copy_up_and_rm '2017'
copy_up_and_rm '2018'
copy_up_and_rm '2019'
copy_up_and_rm '2020'
copy_up_and_rm '2021'

