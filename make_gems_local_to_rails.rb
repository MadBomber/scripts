# lib/ruby/make_gems_local_to_rails.rb
# A robot wrote this.
# config/boot.rb (or a file included early in boot.rb)

require 'bundler'
require 'fileutils'

def setup_local_gems(gemfile_path, local_gems_path)
  # 1. Symlink dependencies
  Bundler.definition.specs.each do |spec|
    source_path = spec.full_gem_path
    target_path = File.join(local_gems_path, spec.name)

    FileUtils.mkdir_p(local_gems_path)

    unless File.exist?(target_path)
      begin
        FileUtils.ln_s(source_path, target_path)
        puts "Symlinked #{spec.name} from #{source_path} to #{target_path}"
      rescue Errno::EEXIST
        # Handle the case where a file with the same name already exists
        puts "Warning: #{target_path} already exists. Skipping symlink."
      rescue Errno::ENOENT => e
        puts "Error: Source path #{source_path} not found for gem #{spec.name}. Skipping. #{e}"
      rescue => e
        puts "Error: Failed to symlink #{spec.name}: #{e}"
      end
    end
  end

  # 2. Modify Bundler config
  ENV['BUNDLE_PATH'] = local_gems_path
  ENV['BUNDLE_WITHOUT'] = ENV['BUNDLE_WITHOUT'] || "development:test" # Set default without groups
  Bundler.settings.set_local('path', local_gems_path)

  # 3. Load from local gems
  $LOAD_PATH.unshift(local_gems_path)

  Bundler.require(:default)
rescue Bundler::GemfileNotFound => e
  puts "Error: Gemfile not found: #{e}"
rescue => e
  puts "Error during local gem setup: #{e}"
end

# Define paths
gemfile_path = File.expand_path('../Gemfile', __dir__)
local_gems_path = File.expand_path('../gems', __dir__)

# Call the setup function
setup_local_gems(gemfile_path, local_gems_path)
