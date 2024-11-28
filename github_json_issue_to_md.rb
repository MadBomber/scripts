#!/usr/bin/env ruby
# ~/scripts/github_json_issue_to_md.rb
#
# Takes a json file created wth the "gh issue view xxx --json"
# and created a markdown file.
require 'json'
require 'date'
require 'yaml'


def json_to_markdown(json_path)
  begin
    data              = JSON.parse(File.read(json_path))
    
    issue_number      = data["number"]
    output_filename   = "Issue#{issue_number}.md"
    output_directory  = File.dirname(json_path)
    output_path       = File.join(output_directory, output_filename)

    File.open(output_path, "w") do |file|
      write_yaml_header(data, file)
      write_markdown(data, file)
    end

    puts "Markdown file created successfully: #{output_path}"
  rescue StandardError => e
    puts "Error processing file #{json_path}: #{e.message}"
  end
end


def write_yaml_header(data, file)
  issue_number  = data["number"]
  issue_title   = data["title"]
  issue_state   = data["state"]
  issue_url     = data["url"]
  
  aliases = [
    issue_number.to_s,
    "issue#{issue_number}",
    "issue #{issue_number}"
  ]

  header = {
    "aliases" => aliases,
    "number"  => issue_number,
    "title"   => issue_title,
    "state"   => issue_state,
    "url"     => issue_url,
  }

  file.puts header.to_yaml
  file.puts "---\n\n"
end


def write_markdown(data, file)
  issue_number= data["number"]
  issue_title = data["title"]
  issue_body  = data["body"].gsub("\n", "\n\n")
  author_name = data["author"]["name"]
  created_at  = DateTime.parse(data["createdAt"]).strftime("%Y-%m-%d %H:%M")
  
  file.puts "Tags: #issue\n\n"
  file.puts "See Also: [[Issue#{issue_number}Research]] and [[Issue#{issue_number}Conclusion]]\n\n"
  file.puts "# #{issue_number}"
  file.puts "**#{issue_title}**\n\n"

  file.puts "> _**Created by:** #{author_name} on #{created_at}_\n\n"

  unless data["assignees"].empty?
    assignees_names = data["assignees"].map { |assignee| assignee["name"] }.join(', ')
    file.puts "**Assignees:** "
    file.puts "#{assignees_names}\n\n"
  end

  file.puts "## Description\n\n"
  file.puts "#{issue_body}\n\n"
  
  if data["comments"].any?
    file.puts "## Comments\n\n"
    data["comments"].each_with_index do |comment, index|
      comment_author      = comment["author"]["login"]
      comment_body        = comment["body"].gsub("\n", "\n\n")
      comment_created_at  = DateTime.parse(comment["createdAt"]).strftime("%Y-%m-%d %H:%M")
      file.puts "### Comment #{index + 1} by #{comment_author} on #{comment_created_at}\n\n"
      file.puts "#{comment_body}\n\n"
    end
  end
end

###################################################
## Main

if ARGV.empty?
  puts "Usage: #{$0} file1.json [file2.json ...]"
else
  ARGV.each do |json_file|
    unless File.readable?(json_file)
      puts "Error: File '#{json_file}' does not exist or is not readable"
      next
    end
    json_to_markdown(json_file)
  end
end
