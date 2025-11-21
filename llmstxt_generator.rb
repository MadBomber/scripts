#!/usr/bin/env ruby
# frozen_string_literal: true

##########################################################
###
##  File: llmstxt_generator.rb
##  Desc: Generates llms.txt file for MkDocs documentation
##        following the llmstxt.org specification
##
##  See: https://llmstxt.org/
##
##  Usage:
##    llmstxt_generator.rb [OPTIONS]
##
##  Options:
##    -c, --config PATH      Path to mkdocs.yml (default: $PWD/mkdocs.yml)
##    -d, --docs PATH        Path to docs directory (default: $PWD/docs)
##    -o, --output PATH      Output directory for llms.txt (default: $PWD/docs)
##    -e, --extra TEXT       Additional project details (optional)
##    --optional SECTION     JSON/YAML file with optional section links
##    -v, --verbose          Verbose output
##    -h, --help            Show this help message
##

require 'yaml'
require 'pathname'
require 'optparse'
require 'json'

class LlmsTxtGenerator
  attr_reader :mkdocs_config, :site_url, :docs_dir, :output_path, :options

  def initialize(mkdocs_path: 'mkdocs.yml', docs_dir: 'docs', output_dir: 'docs', **opts)
    @mkdocs_path   = Pathname.new(mkdocs_path)
    @docs_dir      = Pathname.new(docs_dir)
    @output_path   = Pathname.new(output_dir) / 'llms.txt'
    @options       = opts
    @mkdocs_config = load_mkdocs_config
    @site_url      = @mkdocs_config['site_url'] || ''
    @verbose       = opts[:verbose] || false

    validate_configuration
  end

  def log(message)
    puts message if @verbose
  end

  def generate
    content = build_llms_txt
    File.write(output_path, content)
    puts "Generated #{output_path}"
    puts "  Size: #{content.length} bytes"
    puts "  Lines: #{content.lines.count}"
  end

  private

  def load_mkdocs_config
    unless @mkdocs_path.exist?
      raise "MkDocs config not found: #{@mkdocs_path}"
    end

    YAML.load_file(@mkdocs_path)
  end

  def validate_configuration
    unless @docs_dir.exist?
      raise "Docs directory not found: #{@docs_dir}"
    end

    if @site_url.empty?
      warn "Warning: No site_url found in mkdocs.yml. URLs will be relative."
    end

    log "Configuration validated:"
    log "  MkDocs config: #{@mkdocs_path}"
    log "  Docs directory: #{@docs_dir}"
    log "  Output path: #{@output_path}"
    log "  Site URL: #{@site_url}"
  end

  def build_llms_txt
    parts = []

    # H1 Header (required)
    parts << "# #{@mkdocs_config['site_name']}"
    parts << ""

    # Blockquote summary (optional but recommended)
    parts << "> #{@mkdocs_config['site_description']}"
    parts << ""

    # Detailed information
    parts << build_project_details
    parts << ""

    # Main navigation sections
    parts << build_navigation_sections
    parts << ""

    # Optional section (secondary resources)
    parts << build_optional_section

    parts.join("\n")
  end

  def build_project_details
    parts = []

    # Try to get details from options first
    if @options[:extra_details]
      parts << @options[:extra_details]
    else
      # Try to extract from index.md
      index_file = @docs_dir / 'index.md'
      if index_file.exist?
        details = extract_project_details_from_index(index_file)
        parts << details if details && !details.empty?
      end
    end

    # Fallback to copyright/author if nothing else found
    if parts.empty?
      author = @mkdocs_config['site_author']
      copyright = @mkdocs_config['copyright']

      desc_parts = []
      desc_parts << @mkdocs_config['site_description'] if @mkdocs_config['site_description']
      desc_parts << "By #{author}" if author
      desc_parts << copyright if copyright

      parts << desc_parts.join('. ') unless desc_parts.empty?
    end

    parts.empty? ? nil : parts.join("\n\n")
  end

  def extract_project_details_from_index(index_file)
    content = File.read(index_file)
    paragraphs = []

    lines = content.lines
    in_frontmatter = false
    in_code_block = false
    current_para = []

    lines.each_with_index do |line, idx|
      stripped = line.strip

      # Handle YAML frontmatter
      if idx == 0 && stripped == '---'
        in_frontmatter = true
        next
      end

      if in_frontmatter
        in_frontmatter = false if stripped == '---'
        next
      end

      # Handle code blocks
      if stripped.start_with?('```')
        in_code_block = !in_code_block
        next
      end

      next if in_code_block

      # Skip titles, warnings, and special blocks
      next if stripped.start_with?('# ', '## ', '###')
      next if stripped.start_with?('!!!', '---', '<')

      # Build paragraphs
      if stripped.empty?
        if !current_para.empty?
          para = current_para.join(' ').strip
          paragraphs << clean_markdown(para) if para.length > 50
          current_para = []
        end
      else
        current_para << stripped
      end

      # Stop after collecting 2-3 good paragraphs
      break if paragraphs.length >= 3
    end

    # Add last paragraph if exists
    if !current_para.empty?
      para = current_para.join(' ').strip
      paragraphs << clean_markdown(para) if para.length > 50
    end

    paragraphs.first(3).join("\n\n")
  end

  def clean_markdown(text)
    text.gsub(/\*\*(.+?)\*\*/, '\1')      # Bold
        .gsub(/\*(.+?)\*/, '\1')          # Italic
        .gsub(/\[(.+?)\]\(.+?\)/, '\1')   # Links
        .gsub(/`(.+?)`/, '\1')            # Code
        .gsub(/\{[^}]+\}/, '')            # Attributes
        .strip
  end

  def build_navigation_sections
    sections = []
    nav = @mkdocs_config['nav'] || []

    nav.each do |nav_item|
      section = process_nav_item(nav_item)
      sections << section if section && !section.empty?
    end

    sections.join("\n\n")
  end

  def process_nav_item(item, level = 0)
    return nil if item.nil?

    case item
    when String
      # Direct markdown file
      format_link(item, item)
    when Hash
      # Navigate through the hash structure
      item.flat_map do |key, value|
        process_nav_section(key, value, level)
      end.compact.join("\n")
    when Array
      # Array of items
      item.map { |sub_item| process_nav_item(sub_item, level) }.compact.join("\n")
    end
  end

  def process_nav_section(section_name, section_content, level)
    return nil if section_name == 'Home'
    return nil if section_content.is_a?(String) && external_link?(section_content)

    lines = []

    # Add section header (H2 for top-level sections)
    if level == 0
      lines << "## #{section_name}"
      lines << ""
    end

    case section_content
    when String
      # Single file in section
      lines << format_link(section_name, section_content, level)
    when Array
      # Multiple items in section
      section_content.each do |item|
        case item
        when String
          lines << format_link(item, item, level + 1)
        when Hash
          item.each do |sub_name, sub_content|
            if sub_content.is_a?(String)
              lines << format_link(sub_name, sub_content, level + 1)
            elsif sub_content.is_a?(Array)
              # Subsection with multiple items
              lines << ""
              lines << "### #{sub_name}" if level == 0
              lines << ""
              sub_content.each do |sub_item|
                if sub_item.is_a?(Hash)
                  sub_item.each do |item_name, item_path|
                    unless external_link?(item_path)
                      lines << format_link(item_name, item_path, level + 2)
                    end
                  end
                elsif sub_item.is_a?(String)
                  lines << format_link(sub_item, sub_item, level + 2)
                end
              end
            end
          end
        end
      end
    end

    lines.empty? ? nil : lines.join("\n")
  end

  def format_link(title, path, level = 0)
    return nil if external_link?(path)

    # Clean up the title
    clean_title = title.gsub(/\.md$/, '')
                      .split('/')
                      .last
                      .gsub(/[-_]/, ' ')
                      .split
                      .map(&:capitalize)
                      .join(' ')

    # Build URL
    url = build_url(path)

    # Get description from the markdown file
    description = extract_description(path)

    # Format according to llms.txt spec
    indent = "  " * [level, 0].max
    if description && !description.empty?
      "#{indent}- [#{clean_title}](#{url}): #{description}"
    else
      "#{indent}- [#{clean_title}](#{url})"
    end
  end

  def build_url(path)
    return path if external_link?(path)

    # Remove .md extension and build full URL
    clean_path = path.gsub(/\.md$/, '')
    clean_path = '' if clean_path == 'index'

    "#{@site_url}/#{clean_path}".gsub(%r{/+}, '/')
                                 .gsub(%r{/$}, '')
                                 .sub('https:/', 'https://')
  end

  def external_link?(path)
    return false if path.nil?
    path.start_with?('http://') || path.start_with?('https://')
  end

  def extract_description(path)
    return nil if external_link?(path)

    file_path = @docs_dir / path
    return nil unless file_path.exist?

    content = File.read(file_path)

    # Look for description in front matter or first paragraph
    if content =~ /\Adescription:\s*(.+?)$/
      return $1.strip
    end

    # Extract first meaningful paragraph after title
    lines = content.lines
    in_frontmatter = false
    skip_next_blank = false

    lines.each_with_index do |line, idx|
      line = line.strip

      # Skip YAML front matter
      if idx == 0 && line == '---'
        in_frontmatter = true
        next
      end

      if in_frontmatter
        in_frontmatter = false if line == '---'
        next
      end

      # Skip title (H1)
      next if line.start_with?('# ')

      # Skip warnings and special blocks
      next if line.start_with?('!!!') || line.start_with?('>')
      next if line.start_with?('<') # Skip HTML
      next if line.start_with?('```') # Skip code blocks
      next if line.empty?

      # Return first substantial paragraph
      if line.length > 20
        # Clean up markdown formatting
        clean = line.gsub(/\*\*(.+?)\*\*/, '\1')  # Remove bold
                    .gsub(/\*(.+?)\*/, '\1')      # Remove italic
                    .gsub(/\[(.+?)\]\(.+?\)/, '\1') # Remove links
                    .gsub(/`(.+?)`/, '\1')        # Remove code
                    .strip

        return truncate(clean, 150) if clean.length > 20
      end
    end

    nil
  end

  def truncate(text, max_length)
    return text if text.length <= max_length

    text[0...max_length].gsub(/\s+\S*$/, '') + '...'
  end

  def build_optional_section
    # Check if optional section is provided via config
    if @options[:optional_file]
      return build_optional_from_file(@options[:optional_file])
    end

    # Auto-detect optional/secondary resources
    optional_links = auto_detect_optional_resources

    return nil if optional_links.empty?

    lines = []
    lines << "## Optional"
    lines << ""
    lines << "These resources provide supplementary information that may be skipped for shorter context:"
    lines << ""
    optional_links.each do |link|
      lines << "- #{link}"
    end

    lines.join("\n")
  end

  def build_optional_from_file(file_path)
    file = Pathname.new(file_path)
    return nil unless file.exist?

    data = if file.extname == '.json'
      JSON.parse(File.read(file))
    else
      YAML.load_file(file)
    end

    lines = []
    lines << "## Optional"
    lines << ""
    lines << (data['description'] || "These resources provide supplementary information that may be skipped for shorter context:")
    lines << ""

    (data['links'] || []).each do |link|
      title = link['title'] || link['name']
      url = link['url']
      desc = link['description'] || link['desc']

      if desc
        lines << "- [#{title}](#{build_url(url)}): #{desc}"
      else
        lines << "- [#{title}](#{build_url(url)})"
      end
    end

    lines.join("\n")
  end

  def auto_detect_optional_resources
    optional_keywords = [
      'requirements', 'contributing', 'changelog', 'license',
      'terms', 'legal', 'privacy', 'tags', 'glossary',
      'faq', 'troubleshooting', 'resources', 'references'
    ]

    optional_links = []
    nav = @mkdocs_config['nav'] || []

    # Search through nav for optional-type pages
    nav.each do |item|
      links = find_optional_links(item, optional_keywords)
      optional_links.concat(links)
    end

    optional_links.uniq
  end

  def find_optional_links(item, keywords, collected = [])
    case item
    when String
      # Check if filename matches optional keywords
      basename = File.basename(item, '.md').downcase
      if keywords.any? { |kw| basename.include?(kw) }
        title = basename.split(/[-_]/).map(&:capitalize).join(' ')
        desc = extract_description(item)
        collected << format_optional_link(title, item, desc)
      end
    when Hash
      item.each do |key, value|
        # Check if section name matches optional keywords
        if keywords.any? { |kw| key.downcase.include?(kw) }
          if value.is_a?(String)
            desc = extract_description(value)
            collected << format_optional_link(key, value, desc)
          elsif value.is_a?(Array)
            value.each do |sub_item|
              find_optional_links(sub_item, keywords, collected)
            end
          end
        elsif value.is_a?(Array)
          # Recurse into arrays
          value.each do |sub_item|
            find_optional_links(sub_item, keywords, collected)
          end
        elsif value.is_a?(String)
          find_optional_links(value, keywords, collected)
        end
      end
    when Array
      item.each { |sub_item| find_optional_links(sub_item, keywords, collected) }
    end

    collected
  end

  def format_optional_link(title, path, description)
    url = build_url(path)
    if description && !description.empty?
      "[#{title}](#{url}): #{description}"
    else
      "[#{title}](#{url})"
    end
  end
end

# Main execution
if __FILE__ == $0
  options = {
    mkdocs_path: File.join(Dir.pwd, 'mkdocs.yml'),
    docs_dir: File.join(Dir.pwd, 'docs'),
    output_dir: File.join(Dir.pwd, 'docs'),
    verbose: false
  }

  OptionParser.new do |opts|
    opts.banner = "Usage: #{File.basename($0)} [OPTIONS]"
    opts.separator ""
    opts.separator "Generates llms.txt file for MkDocs documentation following llmstxt.org specification"
    opts.separator ""
    opts.separator "Options:"

    opts.on('-c', '--config PATH', 'Path to mkdocs.yml (default: $PWD/mkdocs.yml)') do |path|
      options[:mkdocs_path] = path
    end

    opts.on('-d', '--docs PATH', 'Path to docs directory (default: $PWD/docs)') do |path|
      options[:docs_dir] = path
    end

    opts.on('-o', '--output PATH', 'Output directory for llms.txt (default: $PWD/docs)') do |path|
      options[:output_dir] = path
    end

    opts.on('-e', '--extra TEXT', 'Additional project details text') do |text|
      options[:extra_details] = text
    end

    opts.on('--optional FILE', 'JSON/YAML file with optional section links') do |file|
      options[:optional_file] = file
    end

    opts.on('-v', '--verbose', 'Verbose output') do
      options[:verbose] = true
    end

    opts.on('-h', '--help', 'Show this help message') do
      puts opts
      exit 0
    end

    opts.separator ""
    opts.separator "Examples:"
    opts.separator "  #{File.basename($0)}                                    # Generate with defaults"
    opts.separator "  #{File.basename($0)} -v                                 # Verbose output"
    opts.separator "  #{File.basename($0)} -c path/to/mkdocs.yml              # Custom config path"
    opts.separator "  #{File.basename($0)} -e 'Custom project description'    # Add extra details"
    opts.separator "  #{File.basename($0)} --optional optional_links.yml      # Custom optional section"
    opts.separator ""
    opts.separator "Optional Section File Format (YAML):"
    opts.separator "  description: 'Custom description text'"
    opts.separator "  links:"
    opts.separator "    - title: 'Link Title'"
    opts.separator "      url: 'path/or/full-url'"
    opts.separator "      description: 'Link description'"
    opts.separator ""
    opts.separator "Optional Section File Format (JSON):"
    opts.separator '  {'
    opts.separator '    "description": "Custom description text",'
    opts.separator '    "links": ['
    opts.separator '      {'
    opts.separator '        "title": "Link Title",'
    opts.separator '        "url": "path/or/full-url",'
    opts.separator '        "description": "Link description"'
    opts.separator '      }'
    opts.separator '    ]'
    opts.separator '  }'
  end.parse!

  begin
    generator = LlmsTxtGenerator.new(
      mkdocs_path: options[:mkdocs_path],
      docs_dir: options[:docs_dir],
      output_dir: options[:output_dir],
      extra_details: options[:extra_details],
      optional_file: options[:optional_file],
      verbose: options[:verbose]
    )

    generator.generate

    puts "\n✓ Successfully generated llms.txt"
    puts "\nGenerated file: #{generator.output_path}"
    puts "Site URL: #{generator.site_url}" unless generator.site_url.empty?
    puts "\nNext steps:"
    puts "  1. Review #{generator.output_path}"
    puts "  2. Commit the file to your repository"
    puts "  3. Deploy your documentation site"
    puts "  4. The file will be available at: #{generator.site_url}/llms.txt" unless generator.site_url.empty?

  rescue => e
    puts "\n✗ Error generating llms.txt: #{e.message}"
    puts "\nStack trace:" if options[:verbose]
    puts e.backtrace.join("\n") if options[:verbose]
    puts "\nUse --help for usage information"
    exit 1
  end
end
