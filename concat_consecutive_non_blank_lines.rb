#!/usr/bin/env ruby
# File: concat_consecutive_non_blank_lines
#
# TODO: turn this file into a CLI program that takes
#       the filename from ARGV

def join_consecutive_lines(file_path)
  # Read the content of the given file
  content = File.read(file_path)

  # Split the content into an array of lines
  lines = content.split("\n")

  # Initialize an empty array to store the joined lines
  result = []

  # Iterate over each line
  lines.each do |line|
    line = line.strip

    # Skip the line if it's blank or a comment
    if line.empty? || line.start_with?('#')
      result << "\n"
      next
    end

    # Join the line to the previous line if there is one
    if result[-1] && !result[-1].empty?
      result[-1] << " #{line}"
    else
      result << line
    end
  end

  # Convert the array of joined lines back to a single string
  joined_lines = result.join("\n")

  return joined_lines
end

# Specify the path of the text file to be processed
file_path = "./temp.txt"

# Call the method and print the result
buffer = join_consecutive_lines(file_path)

f = File.open('temp.out', 'wb')
f.write buffer

__END__

filename = ARGV[0]
join_consecutive_lines(filename)

