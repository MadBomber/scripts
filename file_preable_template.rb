#!/usr/bin/env ruby
# scripts/file_preable_template.rb

require 'pathname'

require 'mods/string_mods.rb'

def prepend_relative_paths(
      base_dir:     Pathname.new(ENV['RR']), 
      current_dir:  Pathname.pwd,
      ext:          '.rb'
    )
  base_path     = Pathname.new(base_dir)
  current_path  = Pathname.new(current_dir)

  # Find all files (*.ext) in the current directory
  Dir.glob("#{current_path}/**/*#{ext}").each do |file|
    relative_path = Pathname.new(file).relative_path_from(base_path)

    content = File.read(file)

    next if '#' == content[0]

    # Prepend the relative path as a comment at the top of the file
    updated_content = <<~EOS 
      # #{relative_path}
      # Desc: 

    EOS

    updated_content += content

    # Write the updated content back to the file
    File.open(file, 'w') { |f| f.write(updated_content) }
  end
end

prepend_relative_paths ext: '.txt'


