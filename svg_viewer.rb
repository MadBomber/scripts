#!/usr/bin/env ruby
# scripts/svg_viewer.rb
#
# A tiny Sinatra web server that renders SVG and Markdown files
# from a directory in your browser.
#
#   /            index of viewable files in the directory
#   /svg/:file   render an SVG file wrapped in an HTML page
#   /md/:file    render a Markdown file as HTML (via kramdown)
#
# builds on md_viewer.rb

require 'optparse'
require 'kramdown'
require 'nenv'
require 'sinatra/base'

PROGRAM = File.basename(__FILE__)

DEFAULTS = {
  dir:  File.join(Nenv.home, 'Downloads'),
  port: 4567,
  bind: '127.0.0.1'
}.freeze

# Parse ARGV into an options hash. Exits on --help / --version / bad input.
def parse_options(argv, defaults = DEFAULTS)
  options = defaults.dup

  parser = OptionParser.new do |opts|
    opts.banner = <<~BANNER
      Usage: #{PROGRAM} [options] [directory]

      Serve SVG and Markdown files from a directory so they can be
      viewed in a web browser.

        http://HOST:PORT/              index of viewable files
        http://HOST:PORT/svg/FILE.svg  render an SVG file
        http://HOST:PORT/md/FILE.md    render a Markdown file as HTML

      The directory may be given as a positional argument or with --dir.
      Default directory: #{defaults[:dir]}

      Options:
    BANNER

    opts.on('-d', '--dir DIR', 'Directory containing the files to serve') do |dir|
      options[:dir] = dir
    end

    opts.on('-p', '--port PORT', Integer, "Port to listen on (default: #{defaults[:port]})") do |port|
      options[:port] = port
    end

    opts.on('-b', '--bind HOST', "Address to bind to (default: #{defaults[:bind]})") do |host|
      options[:bind] = host
    end

    opts.on('-h', '--help', 'Show this help message and exit') do
      puts opts
      exit
    end
  end

  begin
    rest = parser.parse(argv)
  rescue OptionParser::ParseError => e
    $stderr.puts "#{PROGRAM}: #{e.message}"
    $stderr.puts parser
    exit 1
  end

  if rest.size > 1
    $stderr.puts "#{PROGRAM}: too many arguments: #{rest.join(' ')}"
    $stderr.puts parser
    exit 1
  end

  options[:dir] = rest.first if rest.first
  options[:dir] = File.expand_path(options[:dir])

  unless File.directory?(options[:dir])
    $stderr.puts "#{PROGRAM}: not a directory: #{options[:dir]}"
    exit 1
  end

  options
end

class Web < Sinatra::Base
  VIEWABLE_EXTENSIONS = {
    '.svg'      => 'svg',
    '.md'       => 'md',
    '.markdown' => 'md'
  }.freeze

  set :files_directory, DEFAULTS[:dir]

  # Resolve a requested filename to a path inside the configured
  # directory. Returns nil when the file does not exist or when the
  # name tries to escape the directory.
  def self.resolve(directory, filename)
    return nil if filename.nil? || filename.empty?
    return nil if filename != File.basename(filename)

    path = File.join(directory, filename)
    File.file?(path) ? path : nil
  end

  # Wrap raw SVG markup in a minimal HTML document.
  def self.wrap_svg(title, svg_content)
    <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>#{Rack::Utils.escape_html(title)}</title>
      </head>
      <body>
        #{svg_content}
      </body>
      </html>
    HTML
  end

  # Convert Markdown text to HTML.
  def self.render_markdown(markdown_content)
    Kramdown::Document.new(markdown_content).to_html
  end

  # List the viewable files in a directory as [route, filename] pairs.
  def self.viewable_files(directory)
    Dir.children(directory).sort.filter_map do |name|
      route = VIEWABLE_EXTENSIONS[File.extname(name).downcase]
      next unless route
      next unless File.file?(File.join(directory, name))

      [route, name]
    end
  end

  # Build the HTML index page for a directory.
  def self.index_html(directory)
    items = viewable_files(directory).map do |route, name|
      href = "/#{route}/#{Rack::Utils.escape_path(name)}"
      "<li><a href=\"#{href}\">#{Rack::Utils.escape_html(name)}</a></li>"
    end

    <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>#{Rack::Utils.escape_html(directory)}</title>
      </head>
      <body>
        <h1>#{Rack::Utils.escape_html(directory)}</h1>
        <ul>
          #{items.empty? ? '<li><em>no .svg or .md files found</em></li>' : items.join("\n    ")}
        </ul>
      </body>
      </html>
    HTML
  end

  helpers do
    def not_found_message(filename)
      status 404
      content_type :text
      "File not found: #{filename} in #{settings.files_directory}"
    end
  end

  get '/' do
    content_type :html
    Web.index_html(settings.files_directory)
  end

  get '/md/:filename' do
    path = Web.resolve(settings.files_directory, params[:filename])
    return not_found_message(params[:filename]) unless path

    content_type :html
    Web.render_markdown(File.read(path))
  end

  get '/svg/:filename' do
    path = Web.resolve(settings.files_directory, params[:filename])
    return not_found_message(params[:filename]) unless path

    content_type :html
    Web.wrap_svg(params[:filename], File.read(path))
  end
end

if __FILE__ == $PROGRAM_NAME
  options = parse_options(ARGV)

  Web.set :files_directory, options[:dir]
  Web.set :bind, options[:bind]
  Web.set :port, options[:port]

  puts <<~INFO
    Serving #{options[:dir]}
    Open http://#{options[:bind]}:#{options[:port]}/ in your browser
    Press Ctrl-C to stop
  INFO

  Web.run!
end
