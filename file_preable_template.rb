# lib/aia/temp.rb

require 'pathname'

require 'mods/string_mods.rb'

def prepend_relative_paths(base_dir: Pathname.new(ENV['RR']), current_dir: Pathname.pwd)
  base_path     = Pathname.new(base_dir)
  current_path  = Pathname.new(current_dir)

  # Find all Ruby files (*.rb) in the current directory
  Dir.glob("#{current_path}/*.rb").each do |file|
    relative_path = Pathname.new(file).relative_path_from(base_path)

    content = File.read(file)
    # Prepend the relative path as a comment at the top of the file
    updated_content = <<~EOS 
      # #{relative_path}

      module AIA::#{relative_path.basename.to_s.gsub('.rb','').camelize}

      end

    EOS

    updated_content += content

    # Write the updated content back to the file
    File.open(file, 'w') { |f| f.write(updated_content) }
  end
end

prepend_relative_paths


