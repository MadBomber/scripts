#!/usr/bin/env ruby
@data_file = "/home/#{ENV['USER']}/_notes.txt"
def ts; Time.now.to_s; end
def edit
  IO.popen "gedit #{@data_file} & "
end
def add
  msg = ARGV.join( ' ' ).to_s.strip
  File.open(@data_file, "a") do |f|
    f.print "--- #{ts}\n\t#{msg}\n\n"
  end
end
ARGV.empty? ? edit : add

