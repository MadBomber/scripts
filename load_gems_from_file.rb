#!/usr/bin/env ruby
# load_gems_from_file.rb
# Support load gems from one version of Ruby to another
# in the old version do 'gem list > gems_list.txt'
# then run this program against that text file to load thos
# gems from the old ruby version into the new ruby version

require 'yaml'
require 'pathname'


if ARGV.empty?
  puts <<~ERROR

    No file was presented as a parameter.

  ERROR
  exit
end


installed_gems = Gem::Specification.all.map { |gs| gs.name }

file_path = Pathname.new ARGV.shift

if !file_path.exist? or file_path.directory?
  puts <<~ERROR

    Invalid file parameter.

  ERROR
  exit
end

$gems = file_path.read.split("\n").map{|g| g.split(' ').first}

missing_gems = $gems.reject{ |gem_name| installed_gems.include?(gem_name)}
if missing_gems.empty?
  puts "All gems are already installed"
else
  # command = "gem install #{missing_gems.join(' ')}"
  # puts command
  # system command

  until missing_gems.empty?
    gem_name  = missing_gems.shift
    command   = "gem install #{gem_name}"
    puts command
    system command
    depends = YAML.load(`gem spec #{gem_name}`)
                .dependencies.map{|d| d.name}
    unless depends.empty?
      depends.each {|d| missing_gems.delete d}
    end
  end # until missing_gems.empty?
end # if missing_gems.empty?


