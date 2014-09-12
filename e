#!/usr/bin/env ruby

command = ['subl']

if ARGV.first
  file, line_and_column = ARGV.first.split(':', 2)

  command << file
  command += ['-l', line_and_column] if line_and_column
end
command << '.' if command.size == 1
exec *command
