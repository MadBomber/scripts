#!/usr/bin/env ruby
############################################
###
##  File: rename_db_columns.rb
##  Desc: The python tool csvsql generates database
##        column names the same as the CSV header record.
##        This results in weird column names.  This program
##        takes those weird names and normalizes them to
##        snake_case.
##  By: Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'pathname'  # STDLIB

def replace_col_name(a_string)
  return(a_string) unless a_string.include?('"')

  my_array = a_string.split('"')

  return(a_string) unless 3 == my_array.size

	label = my_array[1]

	col_name = label.downcase.
		gsub('#','num of').
		gsub('/',' or ').
		gsub('(','').
		gsub(')','').
		gsub('.','').
		squeeze(' ').
		gsub(' ','_')

  col_name = 'last_update' if 'LastUpdate' == label
  my_array[1] = col_name
  
  return my_array.join('"')
end


if ARGV.empty?            ||
   ARGV.include?('-h')    ||
   ARGV.include?('--help')
  puts <<EOS

Normalize column names in an SQL create table command

Usage: rename_db_columns.rb [-h|--help] file_name

EOS
  exit(1)
end

in_path   = Pathname.new(ARGV.first)

in_path.each_line do |a_line|
  puts replace_col_name(a_line)
end

__END__

my_columns = []
my_columns << column_names.find_index('req_current_status_parent')
my_columns << column_names.find_index('num_of_pos_currently_remaining_open')
my_columns << column_names.find_index('req_type')
my_columns << column_names.find_index('last_update')

ap my_columns

data=csv.gets

puts "INSERT INTO resource_management (#{my_columns.map{|c|column_names[c]}.join(', ')})"

while data=csv.gets do
	puts "VALUES (#{my_columns.map{|c|data[c]}.join(', ') }),"
end


