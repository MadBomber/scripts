#!/usr/bin/env ruby
# scripts/doc_viewer.rb
#
# TDV - Terrific Doc Viewer
#
# A small Sinatra web server that renders the SVG and Markdown files in a
# documentation directory -- and its sub-directories -- in your browser.
#
#   /                 index of the root directory
#   /dir/PATH/        index of a sub-directory
#   /md/PATH.md       render a Markdown file as HTML (kramdown GFM + rouge)
#   /svg/PATH.svg     render an SVG file wrapped in an HTML page
#   /raw/PATH         serve any file as-is (images, etc.); ?plain shows source
#   /search?q=TEXT    full-text search of the Markdown files
#
# Every page carries a header with a Home link, breadcrumbs, up / previous /
# next navigation and a search box, plus a sidebar listing the current
# folder and an "on this page" outline for Markdown documents.
#
# builds on md_viewer.rb / svg_viewer.rb

require 'optparse'
require 'kramdown'
require 'kramdown-parser-gfm'
require 'rouge'
require 'nenv'
require 'sinatra/base'

PROGRAM  = File.basename(__FILE__)
APP_NAME = 'TDV'
APP_FULL = 'Terrific Doc Viewer'

DEFAULTS = {
  dir:  File.join(Nenv.home, 'Downloads'),
  port: 4567,
  bind: '127.0.0.1'
}.freeze

# Parse ARGV into an options hash. Exits on --help / bad input.
def parse_options(argv, defaults = DEFAULTS)
  options = defaults.dup

  parser = OptionParser.new do |opts|
    opts.banner = <<~BANNER
      #{APP_NAME} - #{APP_FULL}

      Usage: #{PROGRAM} [options] [directory]

      Serve the SVG and Markdown files in a documentation directory (and its
      sub-directories) so they can be browsed in a web browser.

        http://HOST:PORT/                index of the root directory
        http://HOST:PORT/dir/PATH/       index of a sub-directory
        http://HOST:PORT/md/PATH.md      render a Markdown file as HTML
        http://HOST:PORT/svg/PATH.svg    render an SVG file
        http://HOST:PORT/raw/PATH        serve a file as-is (?plain for source)
        http://HOST:PORT/search?q=TEXT   search the Markdown files

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

  ROUGE_THEME = 'base16.monokai.dark'

  set :files_directory, DEFAULTS[:dir]

  # ------------------------------------------------------------------
  # Path helpers
  # ------------------------------------------------------------------

  # HTML-escape any value.
  def self.h(value)
    Rack::Utils.escape_html(value.to_s)
  end

  # Split a relative path into its components, dropping empty and '.' parts.
  def self.segments(relpath)
    relpath.to_s.split('/').reject { it.empty? || it == '.' }
  end

  # True when any component is hidden (starts with '.'), which also
  # covers '..' parent references.
  def self.hidden?(relpath)
    segments(relpath).any? { it.start_with?('.') }
  end

  # Resolve a relative path to an absolute path inside root. Returns nil
  # when the path escapes root, names a hidden entry, or does not exist.
  def self.resolve(root, relpath)
    return nil if hidden?(relpath)

    root = File.expand_path(root)
    path = File.expand_path(segments(relpath).join('/'), root)
    return nil unless path == root || path.start_with?("#{root}/")

    File.exist?(path) ? path : nil
  end

  # Join a relative href onto a base directory, resolving '.' and '..'.
  # Returns nil if the href climbs above the root.
  def self.join_relative(base_dir, href)
    parts = segments(base_dir)
    href.to_s.split('/').each do |part|
      case part
      when '', '.' then next
      when '..'    then parts.pop.nil? and return nil
      else parts << part
      end
    end
    parts.join('/')
  end

  # The route ('md' or 'svg') that renders a file name, or nil.
  def self.route_for(name)
    VIEWABLE_EXTENSIONS[File.extname(name.to_s).downcase]
  end

  # URL for a route and relative path. Directory URLs end in '/'.
  def self.href_for(route, relpath)
    path = segments(relpath).map { Rack::Utils.escape_path(it) }.join('/')
    if route == 'dir'
      path.empty? ? '/' : "/dir/#{path}/"
    else
      "/#{route}/#{path}"
    end
  end

  # Relative path of the folder that contains relpath ('' for the root).
  def self.parent_of(relpath)
    segments(relpath)[0...-1].join('/')
  end

  # ------------------------------------------------------------------
  # Directory inspection
  # ------------------------------------------------------------------

  # Entries of a directory as [dirs, files]: dirs is a list of names and
  # files a list of [route, name] pairs. Hidden entries are skipped.
  def self.list_directory(directory)
    dirs  = []
    files = []

    Dir.children(directory).sort_by(&:downcase).each do |name|
      next if name.start_with?('.')

      full = File.join(directory, name)
      if File.directory?(full)
        dirs << name
      elsif (route = route_for(name)) && File.file?(full)
        files << [route, name]
      end
    end

    [dirs, files]
  end

  # Number of viewable documents at or below a directory.
  def self.doc_count(directory)
    Dir.glob('**/*', base: directory).count do |rel|
      route_for(rel) && File.file?(File.join(directory, rel))
    end
  end

  # Breadcrumb trail for a relative path as [[label, href], ...]. The
  # first crumb is Home; the last crumb is the current page (href nil).
  def self.breadcrumbs(relpath)
    parts  = segments(relpath)
    crumbs = [['Home', parts.empty? ? nil : '/']]

    parts.each_with_index do |part, i|
      last = i == parts.size - 1
      crumbs << [part, last ? nil : href_for('dir', parts[0..i].join('/'))]
    end

    crumbs
  end

  # Previous and next viewable files in the same folder as relpath, as
  # [route, relpath] pairs (nil at either end or when relpath is unknown).
  def self.neighbors(root, relpath)
    parts  = segments(relpath)
    name   = parts.pop
    parent = resolve(root, parts.join('/'))
    return [nil, nil] unless parent && File.directory?(parent)

    _, files = list_directory(parent)
    index = files.index { |_, n| n == name }
    return [nil, nil] unless index

    pair = ->(entry) { entry && [entry[0], [*parts, entry[1]].join('/')] }
    [pair.(index.positive? ? files[index - 1] : nil), pair.(files[index + 1])]
  end

  # Search the Markdown files under root for a case-insensitive query.
  # Returns [[relpath, line_number, line], ...] capped at limit matches.
  def self.search(root, query, limit: 200)
    needle = query.to_s.strip.downcase
    return [] if needle.empty?

    results = []
    Dir.glob('**/*.{md,markdown}', base: root).sort.each do |rel|
      File.foreach(File.join(root, rel), chomp: true).with_index(1) do |line, number|
        line = line.scrub
        next unless line.downcase.include?(needle)

        results << [rel, number, line]
        return results if results.size >= limit
      end
    end
    results
  end

  # ------------------------------------------------------------------
  # Rendering primitives
  # ------------------------------------------------------------------

  # Convert Markdown text to HTML (GitHub-flavoured, rouge highlighting).
  def self.render_markdown(markdown_content)
    Kramdown::Document.new(
      markdown_content,
      input:                   'GFM',
      hard_wrap:               false,
      syntax_highlighter:      'rouge',
      syntax_highlighter_opts: { css_class: 'highlight' }
    ).to_html
  end

  # The first level-one heading of a Markdown document, or nil.
  def self.doc_title(markdown_content)
    markdown_content[/^\#[ \t]+(.+?)[ \t#]*$/, 1]
  end

  # Point relative <img src> values at the /raw/ route so images that sit
  # next to a Markdown file display correctly.
  def self.rewrite_relative_images(html, base_dir)
    html.gsub(/(<img\b[^>]*\bsrc=")([^"]*)(")/) do
      prefix, src, suffix = Regexp.last_match.captures
      if src.match?(%r{\A([a-z][a-z0-9+.-]*:|/|#)}i)
        "#{prefix}#{src}#{suffix}"
      else
        joined = join_relative(base_dir, src)
        "#{prefix}#{joined ? href_for('raw', joined) : src}#{suffix}"
      end
    end
  end

  # Highlight occurrences of needle inside an escaped line of text.
  def self.highlight_match(line, needle)
    return h(line) if needle.empty?

    line.split(/(#{Regexp.escape(needle)})/i).map.with_index do |chunk, i|
      i.odd? ? "<mark>#{h(chunk)}</mark>" : h(chunk)
    end.join
  end

  # ------------------------------------------------------------------
  # Page chrome: header, sidebar, layout
  # ------------------------------------------------------------------

  ICONS = {
    home:   '<svg viewBox="0 0 24 24"><path d="M3 11.5 12 4l9 7.5"/><path d="M5.5 10v9.5h4.5V14h4v5.5h4.5V10"/></svg>',
    up:     '<svg viewBox="0 0 24 24"><path d="M12 19V5"/><path d="m6 11 6-6 6 6"/></svg>',
    prev:   '<svg viewBox="0 0 24 24"><path d="M19 12H5"/><path d="m11 18-6-6 6-6"/></svg>',
    next:   '<svg viewBox="0 0 24 24"><path d="M5 12h14"/><path d="m13 6 6 6-6 6"/></svg>',
    source: '<svg viewBox="0 0 24 24"><path d="m8 8-4 4 4 4"/><path d="m16 8 4 4-4 4"/><path d="m14 4-4 16"/></svg>',
    folder: '<svg viewBox="0 0 24 24"><path d="M3 7a2 2 0 0 1 2-2h4l2 2h8a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>',
    md:     '<svg viewBox="0 0 24 24"><path d="M4 6h16v12H4z"/><path d="m7 15 0-6 2.5 3L12 9v6"/><path d="m15.5 9v6m-2-2 2 2 2-2"/></svg>',
    svg:    '<svg viewBox="0 0 24 24"><circle cx="8" cy="8" r="3"/><path d="M3 20 11 11l4 4 2-2 4 7z"/></svg>',
    search: '<svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="6"/><path d="m20 20-4.5-4.5"/></svg>',
    menu:   '<svg viewBox="0 0 24 24"><path d="M4 7h16M4 12h16M4 17h16"/></svg>'
  }.freeze

  # One header button. Renders a disabled placeholder when href is nil so
  # the toolbar keeps its shape from page to page.
  def self.nav_button(label, href, icon, key: nil, title: nil)
    tip   = h([title || label, key && "[#{key}]"].compact.join(' '))
    inner = "#{ICONS[icon]}<span>#{h(label)}</span>"
    if href
      "<a class=\"nav-btn\" href=\"#{h(href)}\" title=\"#{tip}\" data-key=\"#{h(key)}\">#{inner}</a>"
    else
      "<span class=\"nav-btn disabled\" title=\"#{tip}\">#{inner}</span>"
    end
  end

  # The breadcrumb strip.
  def self.breadcrumbs_html(relpath)
    breadcrumbs(relpath).map do |label, href|
      if href
        "<a href=\"#{h(href)}\">#{h(label)}</a>"
      else
        "<span class=\"current\">#{h(label)}</span>"
      end
    end.join('<span class="sep">/</span>')
  end

  # The sticky page header: brand / Home, breadcrumbs, navigation, search.
  def self.header_html(root, relpath, kind:, query: '')
    is_file   = %i[md svg].include?(kind)
    up_href   = relpath.empty? && kind == :index ? nil : href_for('dir', parent_of(relpath))
    prev, nxt = is_file ? neighbors(root, relpath) : [nil, nil]
    source    = is_file ? "#{href_for('raw', relpath)}?plain" : nil

    <<~HTML
      <header class="tdv-header">
        <div class="brand">
          <button class="icon-btn sidebar-toggle" type="button" title="Toggle sidebar [s]" aria-label="Toggle sidebar">#{ICONS[:menu]}</button>
          <a class="home" href="/" title="#{h(APP_FULL)} - #{h(root)} [h]" data-key="h">
            #{ICONS[:home]}
            <span class="brand-name">#{h(APP_NAME)}</span>
            <span class="brand-tag">#{h(APP_FULL)}</span>
          </a>
        </div>
        <nav class="crumbs" aria-label="Breadcrumb">#{breadcrumbs_html(relpath)}</nav>
        <nav class="actions" aria-label="Page navigation">
          #{nav_button('Up', up_href, :up, key: 'u', title: 'Parent folder')}
          #{nav_button('Prev', prev && href_for(*prev), :prev, key: '←', title: prev && prev[1])}
          #{nav_button('Next', nxt && href_for(*nxt), :next, key: '→', title: nxt && nxt[1])}
          #{nav_button('Source', source, :source, key: 'v', title: 'View source')}
          <form class="search" action="/search" method="get" role="search">
            #{ICONS[:search]}
            <input type="search" name="q" value="#{h(query)}" placeholder="Search docs… [/]" aria-label="Search documentation">
          </form>
        </nav>
      </header>
    HTML
  end

  # The sidebar: contents of the folder that holds the current page and,
  # for Markdown pages, an outline filled in by JavaScript.
  def self.sidebar_html(root, relpath, kind:)
    folder_rel = kind == :index ? segments(relpath).join('/') : parent_of(relpath)
    folder_abs = resolve(root, folder_rel)
    return '' unless folder_abs && File.directory?(folder_abs)

    dirs, files = list_directory(folder_abs)
    current     = segments(relpath).join('/')
    items       = []

    unless folder_rel.empty?
      items << "<li><a class=\"dir\" href=\"#{h(href_for('dir', parent_of(folder_rel)))}\">#{ICONS[:folder]}<span>..</span></a></li>"
    end

    dirs.each do |name|
      rel = [folder_rel, name].reject(&:empty?).join('/')
      items << "<li><a class=\"dir\" href=\"#{h(href_for('dir', rel))}\">#{ICONS[:folder]}<span>#{h(name)}/</span></a></li>"
    end

    files.each do |route, name|
      rel = [folder_rel, name].reject(&:empty?).join('/')
      cls = rel == current ? ' class="active"' : ''
      items << "<li#{cls}><a class=\"file #{route}\" href=\"#{h(href_for(route, rel))}\">#{ICONS[route.to_sym]}<span>#{h(name)}</span></a></li>"
    end

    outline = kind == :md ? '<section class="outline"><h2>On this page</h2><ol id="outline"></ol></section>' : ''

    <<~HTML
      <aside class="tdv-sidebar">
        <section>
          <h2 title="#{h(folder_rel.empty? ? root : folder_rel)}">#{ICONS[:folder]} #{h(folder_rel.empty? ? File.basename(root) : File.basename(folder_rel))}/</h2>
          <ul class="tree">#{items.join}</ul>
        </section>
        #{outline}
      </aside>
    HTML
  end

  # Wrap page content in the full TDV document.
  def self.layout(root, relpath, kind:, title:, body:, query: '')
    <<~HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>#{h(title)} · #{h(APP_NAME)}</title>
        <style>#{stylesheet}</style>
      </head>
      <body class="kind-#{kind}">
        #{header_html(root, relpath, kind:, query:)}
        <div class="tdv-shell">
          #{sidebar_html(root, relpath, kind:)}
          <main class="tdv-main">
            #{body}
          </main>
        </div>
        <footer class="tdv-footer">
          <span>#{h(APP_NAME)} · #{h(APP_FULL)}</span>
          <span class="keys"><kbd>h</kbd> home <kbd>u</kbd> up <kbd>←</kbd><kbd>→</kbd> prev/next <kbd>v</kbd> source <kbd>s</kbd> sidebar <kbd>/</kbd> search</span>
        </footer>
        <script>#{javascript}</script>
      </body>
      </html>
    HTML
  end

  # ------------------------------------------------------------------
  # Pages
  # ------------------------------------------------------------------

  # Directory index page.
  def self.index_page(root, relpath)
    rel      = segments(relpath).join('/')
    abs      = resolve(root, rel)
    dirs, files = list_directory(abs)

    dir_cards = dirs.map do |name|
      sub   = [rel, name].reject(&:empty?).join('/')
      count = doc_count(File.join(abs, name))
      <<~CARD
        <a class="card dir" href="#{h(href_for('dir', sub))}" data-name="#{h(name.downcase)}">
          #{ICONS[:folder]}
          <span class="name">#{h(name)}/</span>
          <span class="meta">#{count} doc#{count == 1 ? '' : 's'}</span>
        </a>
      CARD
    end

    file_rows = files.map do |route, name|
      sub  = [rel, name].reject(&:empty?).join('/')
      size = File.size(File.join(abs, name))
      <<~ROW
        <li data-name="#{h(name.downcase)}">
          <a class="file #{route}" href="#{h(href_for(route, sub))}">#{ICONS[route.to_sym]}<span class="name">#{h(name)}</span></a>
          <span class="badge #{route}">#{route}</span>
          <span class="meta">#{human_size(size)}</span>
          <a class="meta raw" href="#{h(href_for('raw', sub))}?plain" title="View source">source</a>
        </li>
      ROW
    end

    empty = dirs.empty? && files.empty?
    body = <<~HTML
      <div class="index-head">
        <h1>#{ICONS[:folder]} #{h(rel.empty? ? File.basename(root) : rel)}</h1>
        <p class="path">#{h(abs)}</p>
        <input id="filter" type="search" placeholder="Filter this folder… (type to narrow)" aria-label="Filter entries" autocomplete="off">
      </div>
      #{empty ? '<p class="empty">No sub-directories, .svg or .md files here.</p>' : ''}
      #{dir_cards.empty? ? '' : "<section><h2>Folders</h2><div class=\"cards\">#{dir_cards.join}</div></section>"}
      #{file_rows.empty? ? '' : "<section><h2>Documents</h2><ul class=\"files\">#{file_rows.join}</ul></section>"}
    HTML

    layout(root, rel, kind: :index, title: rel.empty? ? File.basename(root) : rel, body:)
  end

  # Rendered Markdown page.
  def self.markdown_page(root, relpath, markdown_content)
    rel   = segments(relpath).join('/')
    html  = rewrite_relative_images(render_markdown(markdown_content), parent_of(rel))
    title = doc_title(markdown_content) || File.basename(rel)
    body  = "<article class=\"markdown-body\">#{html}</article>"
    layout(root, rel, kind: :md, title:, body:)
  end

  # Rendered SVG page with view controls.
  def self.svg_page(root, relpath, svg_content)
    rel  = segments(relpath).join('/')
    body = <<~HTML
      <div class="svg-toolbar">
        <span class="title">#{h(File.basename(rel))}</span>
        <span class="group" role="group" aria-label="Size">
          <button type="button" data-fit="fit" class="on">Fit</button>
          <button type="button" data-fit="natural">100%</button>
        </span>
        <span class="group" role="group" aria-label="Background">
          <button type="button" data-bg="dark" class="on">Dark</button>
          <button type="button" data-bg="light">Light</button>
          <button type="button" data-bg="checker">Checker</button>
        </span>
      </div>
      <figure class="svg-stage bg-dark fit">#{svg_content}</figure>
    HTML
    layout(root, rel, kind: :svg, title: File.basename(rel), body:)
  end

  # Search results page.
  def self.search_page(root, query)
    hits   = search(root, query)
    needle = query.to_s.strip
    rows   = hits.map do |rel, number, line|
      <<~ROW
        <li>
          <a class="hit" href="#{h(href_for('md', rel))}">#{ICONS[:md]}<span class="name">#{h(rel)}</span><span class="meta">:#{number}</span></a>
          <code class="line">#{highlight_match(line.strip, needle)}</code>
        </li>
      ROW
    end

    body = <<~HTML
      <div class="index-head">
        <h1>#{ICONS[:search]} Search</h1>
        <p class="path">#{needle.empty? ? 'Type a query in the header search box.' : "#{hits.size} match#{hits.size == 1 ? '' : 'es'} for “#{h(needle)}”#{hits.size >= 200 ? ' (showing the first 200)' : ''}"}</p>
      </div>
      #{rows.empty? ? '' : "<ul class=\"files hits\">#{rows.join}</ul>"}
    HTML

    layout(root, '', kind: :search, title: needle.empty? ? 'Search' : "Search: #{needle}", body:, query: needle)
  end

  # Not-found page.
  def self.not_found_page(root, relpath)
    body = <<~HTML
      <div class="index-head">
        <h1>Not found</h1>
        <p class="path">#{h(relpath)} is not inside #{h(root)}</p>
        <p><a class="nav-btn" href="/">#{ICONS[:home]}<span>Back to Home</span></a></p>
      </div>
    HTML
    layout(root, '', kind: :error, title: 'Not found', body:)
  end

  # Human-readable file size.
  def self.human_size(bytes)
    return "#{bytes} B" if bytes < 1024
    return format('%.1f KB', bytes / 1024.0) if bytes < 1024 * 1024

    format('%.1f MB', bytes / (1024.0 * 1024))
  end

  # ------------------------------------------------------------------
  # Assets
  # ------------------------------------------------------------------

  def self.stylesheet
    @stylesheet ||= <<~CSS + Rouge::Theme.find(ROUGE_THEME).render(scope: '.highlight')
      :root {
        --bg: #0e1117; --panel: #151a23; --panel-2: #1b2130; --border: #273040;
        --text: #d9dee8; --muted: #8b95a8; --accent: #5ab0ff; --accent-2: #a78bfa;
        --ok: #3ddc97; --warn: #ffb454; --mark: #3b3200;
        --header-h: 56px; --sidebar-w: 280px; --radius: 10px;
        --font: -apple-system, BlinkMacSystemFont, "Segoe UI", Inter, Roboto, Helvetica, Arial, sans-serif;
        --mono: ui-monospace, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace;
      }
      * { box-sizing: border-box; }
      html, body { margin: 0; background: var(--bg); color: var(--text); font: 15px/1.6 var(--font); }
      a { color: var(--accent); text-decoration: none; }
      a:hover { text-decoration: underline; }
      svg { width: 1.1em; height: 1.1em; fill: none; stroke: currentColor; stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round; flex: none; vertical-align: -0.2em; }

      /* ---------- header ---------- */
      .tdv-header {
        position: sticky; top: 0; z-index: 20; height: var(--header-h);
        display: grid; grid-template-columns: auto 1fr auto; align-items: center; gap: 18px;
        padding: 0 16px; background: linear-gradient(180deg, #1a2130 0%, #121722 100%);
        border-bottom: 1px solid var(--border); box-shadow: 0 1px 0 rgba(255,255,255,.03), 0 6px 20px rgba(0,0,0,.35);
      }
      .tdv-header::before {
        content: ""; position: absolute; left: 0; right: 0; top: 0; height: 3px;
        background: linear-gradient(90deg, var(--accent), var(--accent-2), var(--ok));
      }
      .brand { display: flex; align-items: center; gap: 6px; }
      .brand .home { display: flex; align-items: center; gap: 9px; padding: 6px 12px 6px 8px; border-radius: 999px; color: var(--text); font-weight: 600; letter-spacing: .3px; background: rgba(90,176,255,.10); border: 1px solid rgba(90,176,255,.25); transition: background .15s, border-color .15s; }
      .brand .home:hover { text-decoration: none; background: rgba(90,176,255,.22); border-color: var(--accent); }
      .brand .home svg { width: 1.3em; height: 1.3em; color: var(--accent); }
      .brand-name { font-weight: 800; background: linear-gradient(90deg, var(--accent), var(--accent-2)); -webkit-background-clip: text; background-clip: text; color: transparent; }
      .brand-tag { color: var(--muted); font-weight: 500; font-size: 12px; }
      .icon-btn { display: inline-flex; align-items: center; justify-content: center; width: 34px; height: 34px; border-radius: 8px; border: 1px solid transparent; background: transparent; color: var(--muted); cursor: pointer; }
      .icon-btn:hover { color: var(--text); background: var(--panel-2); border-color: var(--border); }

      .crumbs { display: flex; align-items: center; gap: 6px; min-width: 0; overflow: hidden; white-space: nowrap; font-size: 14px; }
      .crumbs a, .crumbs .current { padding: 3px 8px; border-radius: 6px; }
      .crumbs a { color: var(--muted); }
      .crumbs a:hover { color: var(--text); background: var(--panel-2); text-decoration: none; }
      .crumbs .current { color: var(--text); font-weight: 600; background: var(--panel-2); overflow: hidden; text-overflow: ellipsis; }
      .crumbs .sep { color: #3d4759; }

      .actions { display: flex; align-items: center; gap: 6px; }
      .nav-btn { display: inline-flex; align-items: center; gap: 6px; padding: 6px 10px; border-radius: 8px; font-size: 13px; color: var(--text); border: 1px solid var(--border); background: var(--panel); transition: background .15s, border-color .15s; }
      .nav-btn:hover { text-decoration: none; background: var(--panel-2); border-color: var(--accent); }
      .nav-btn.disabled { opacity: .35; cursor: default; }
      .search { display: flex; align-items: center; gap: 6px; margin-left: 8px; padding: 0 10px; height: 34px; border-radius: 8px; border: 1px solid var(--border); background: var(--panel); color: var(--muted); }
      .search:focus-within { border-color: var(--accent); color: var(--text); }
      .search input { width: 180px; border: 0; outline: 0; background: transparent; color: var(--text); font: inherit; font-size: 13px; }

      /* ---------- shell ---------- */
      .tdv-shell { display: grid; grid-template-columns: var(--sidebar-w) 1fr; min-height: calc(100vh - var(--header-h) - 40px); }
      body.no-sidebar .tdv-shell { grid-template-columns: 1fr; }
      body.no-sidebar .tdv-sidebar { display: none; }
      .tdv-sidebar { position: sticky; top: var(--header-h); align-self: start; height: calc(100vh - var(--header-h)); overflow: auto; padding: 18px 12px 24px; border-right: 1px solid var(--border); background: var(--panel); font-size: 13.5px; }
      .tdv-sidebar h2 { display: flex; align-items: center; gap: 6px; margin: 0 8px 8px; font-size: 11px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: var(--muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
      .tdv-sidebar section + section { margin-top: 22px; padding-top: 18px; border-top: 1px solid var(--border); }
      .tree, .tdv-sidebar ol { list-style: none; margin: 0; padding: 0; }
      .tree a, #outline a { display: flex; align-items: center; gap: 8px; padding: 5px 8px; border-radius: 6px; color: var(--text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
      .tree a span, #outline a span { overflow: hidden; text-overflow: ellipsis; }
      .tree a:hover, #outline a:hover { background: var(--panel-2); text-decoration: none; }
      .tree a.dir { color: var(--warn); }
      .tree a.md svg { color: var(--accent); }
      .tree a.svg svg { color: var(--accent-2); }
      .tree li.active > a { background: rgba(90,176,255,.14); color: #fff; box-shadow: inset 3px 0 0 var(--accent); }
      #outline a { color: var(--muted); }
      #outline a.h3 { padding-left: 24px; font-size: 12.5px; }
      #outline a.h4 { padding-left: 40px; font-size: 12px; }
      #outline li.active a { color: var(--text); background: var(--panel-2); }

      .tdv-main { min-width: 0; padding: 32px 40px 64px; }
      .tdv-footer { display: flex; justify-content: space-between; align-items: center; gap: 12px; padding: 10px 16px; border-top: 1px solid var(--border); color: var(--muted); font-size: 12px; background: var(--panel); }
      kbd { display: inline-block; min-width: 1.4em; margin: 0 2px; padding: 0 5px; border-radius: 4px; border: 1px solid var(--border); background: var(--panel-2); font: 11px var(--mono); text-align: center; color: var(--text); }

      /* ---------- index ---------- */
      .index-head h1 { display: flex; align-items: center; gap: 10px; margin: 0 0 4px; font-size: 26px; }
      .index-head h1 svg { color: var(--warn); }
      .index-head .path { margin: 0 0 18px; color: var(--muted); font: 13px var(--mono); word-break: break-all; }
      #filter { width: min(100%, 520px); padding: 9px 12px; border-radius: 8px; border: 1px solid var(--border); background: var(--panel); color: var(--text); font: inherit; outline: 0; }
      #filter:focus { border-color: var(--accent); }
      .tdv-main section { margin-top: 28px; }
      .tdv-main section > h2 { margin: 0 0 12px; font-size: 12px; letter-spacing: .12em; text-transform: uppercase; color: var(--muted); }
      .cards { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 12px; }
      .card { display: grid; grid-template-columns: auto 1fr; grid-template-rows: auto auto; column-gap: 12px; align-items: center; padding: 14px 16px; border-radius: var(--radius); border: 1px solid var(--border); background: var(--panel); color: var(--text); transition: transform .12s, border-color .12s, background .12s; }
      .card:hover { text-decoration: none; transform: translateY(-2px); border-color: var(--warn); background: var(--panel-2); }
      .card svg { grid-row: 1 / 3; width: 1.8em; height: 1.8em; color: var(--warn); }
      .card .name { font-weight: 600; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
      .meta { color: var(--muted); font-size: 12px; }
      .files { list-style: none; margin: 0; padding: 0; border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; background: var(--panel); }
      .files li { display: flex; align-items: center; gap: 14px; padding: 10px 16px; border-top: 1px solid var(--border); }
      .files li:first-child { border-top: 0; }
      .files li:hover { background: var(--panel-2); }
      .files .file, .files .hit { display: flex; align-items: center; gap: 10px; flex: 1; min-width: 0; color: var(--text); }
      .files .file.md svg, .files .hit svg { color: var(--accent); }
      .files .file.svg svg { color: var(--accent-2); }
      .files .name { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
      .badge { padding: 1px 8px; border-radius: 999px; font: 600 11px var(--mono); text-transform: uppercase; letter-spacing: .05em; }
      .badge.md { color: var(--accent); background: rgba(90,176,255,.12); }
      .badge.svg { color: var(--accent-2); background: rgba(167,139,250,.14); }
      .files .raw:hover { color: var(--text); }
      .files li[hidden], .card[hidden] { display: none; }
      .empty { color: var(--muted); font-style: italic; }
      .hits li { flex-wrap: wrap; }
      .hits .line { flex-basis: 100%; margin-left: 2em; color: var(--muted); font: 12.5px var(--mono); white-space: pre-wrap; word-break: break-word; }
      mark { background: var(--warn); color: #000; border-radius: 3px; padding: 0 2px; }

      /* ---------- markdown ---------- */
      .markdown-body { max-width: 860px; font-size: 16px; }
      .markdown-body h1, .markdown-body h2, .markdown-body h3, .markdown-body h4 { scroll-margin-top: calc(var(--header-h) + 16px); line-height: 1.25; margin: 1.6em 0 .6em; }
      .markdown-body h1 { margin-top: 0; font-size: 2em; padding-bottom: .3em; border-bottom: 1px solid var(--border); }
      .markdown-body h2 { font-size: 1.5em; padding-bottom: .25em; border-bottom: 1px solid var(--border); }
      .markdown-body h3 { font-size: 1.2em; }
      .markdown-body :is(h1,h2,h3,h4):hover::after { content: " #"; color: var(--border); }
      .markdown-body p, .markdown-body ul, .markdown-body ol { margin: 0 0 1em; }
      .markdown-body li + li { margin-top: .25em; }
      .markdown-body code { font: 85% var(--mono); background: var(--panel-2); padding: .15em .4em; border-radius: 5px; }
      .markdown-body pre { padding: 14px 16px; border-radius: var(--radius); border: 1px solid var(--border); overflow: auto; line-height: 1.5; }
      .markdown-body pre code { background: none; padding: 0; font-size: 13.5px; }
      .markdown-body .highlight { background: #0b0e14 !important; }
      .markdown-body blockquote { margin: 0 0 1em; padding: .4em 1em; border-left: 4px solid var(--accent-2); background: var(--panel); color: var(--muted); border-radius: 0 8px 8px 0; }
      .markdown-body table { border-collapse: collapse; margin: 0 0 1em; display: block; overflow: auto; }
      .markdown-body th, .markdown-body td { padding: 6px 12px; border: 1px solid var(--border); }
      .markdown-body th { background: var(--panel-2); text-align: left; }
      .markdown-body tr:nth-child(even) td { background: var(--panel); }
      .markdown-body img { max-width: 100%; height: auto; }
      .markdown-body hr { border: 0; border-top: 1px solid var(--border); margin: 2em 0; }
      .markdown-body svg { width: auto; height: auto; stroke: none; fill: initial; }
      .task-list { list-style: none; padding-left: .4em; }

      /* ---------- svg ---------- */
      .svg-toolbar { display: flex; align-items: center; gap: 18px; margin-bottom: 14px; flex-wrap: wrap; }
      .svg-toolbar .title { font-weight: 600; font-family: var(--mono); font-size: 14px; margin-right: auto; }
      .svg-toolbar .group { display: inline-flex; border: 1px solid var(--border); border-radius: 8px; overflow: hidden; }
      .svg-toolbar button { padding: 5px 12px; border: 0; background: var(--panel); color: var(--muted); font: 13px var(--font); cursor: pointer; }
      .svg-toolbar button + button { border-left: 1px solid var(--border); }
      .svg-toolbar button.on { background: rgba(90,176,255,.16); color: var(--text); }
      .svg-stage { margin: 0; padding: 24px; border-radius: var(--radius); border: 1px solid var(--border); overflow: auto; min-height: 60vh; display: flex; align-items: flex-start; justify-content: center; }
      .svg-stage.bg-dark { background: var(--bg); }
      .svg-stage.bg-light { background: #f7f8fa; }
      .svg-stage.bg-checker { background: repeating-conic-gradient(#2a3140 0 25%, #1a1f2a 0 50%) 0 0 / 24px 24px; }
      .svg-stage > svg { width: auto; height: auto; stroke: none; fill: initial; stroke-width: initial; stroke-linecap: initial; stroke-linejoin: initial; }
      .svg-stage.fit > svg { width: 100%; max-height: calc(100vh - var(--header-h) - 150px); }

      @media (max-width: 900px) {
        .tdv-header { grid-template-columns: auto 1fr; height: auto; padding: 8px 12px; row-gap: 6px; }
        .brand-tag, .nav-btn span { display: none; }
        .actions { grid-column: 1 / -1; flex-wrap: wrap; }
        .search { margin-left: 0; flex: 1; }
        .search input { width: 100%; }
        .tdv-shell { grid-template-columns: 1fr; }
        .tdv-sidebar { position: static; max-height: none; border-right: 0; border-bottom: 1px solid var(--border); }
        .tdv-main { padding: 20px 16px 48px; }
        .tdv-footer .keys { display: none; }
      }
    CSS
  end

  def self.javascript
    @javascript ||= <<~JS
      (() => {
        const body = document.body;
        const LS = 'tdv.sidebar';

        // Sidebar toggle (remembered across pages).
        try { if (localStorage.getItem(LS) === 'off') body.classList.add('no-sidebar'); } catch (e) {}
        const toggleSidebar = () => {
          body.classList.toggle('no-sidebar');
          try { localStorage.setItem(LS, body.classList.contains('no-sidebar') ? 'off' : 'on'); } catch (e) {}
        };
        document.querySelector('.sidebar-toggle')?.addEventListener('click', toggleSidebar);

        // "On this page" outline for Markdown documents.
        const outline = document.getElementById('outline');
        if (outline) {
          const heads = [...document.querySelectorAll('.markdown-body :is(h2,h3,h4)[id]')];
          if (heads.length === 0) outline.closest('section').remove();
          heads.forEach(h => {
            const li = document.createElement('li');
            const a  = document.createElement('a');
            a.href = '#' + h.id; a.textContent = h.textContent; a.className = h.tagName.toLowerCase();
            li.appendChild(a); outline.appendChild(li);
          });
          const items = [...outline.children];
          const mark = () => {
            const y = window.scrollY + 90;
            let idx = heads.findIndex(h => h.offsetTop > y) - 1;
            if (idx < -1) idx = heads.length - 1;
            items.forEach((li, i) => li.classList.toggle('active', i === idx));
          };
          window.addEventListener('scroll', mark, { passive: true }); mark();
        }

        // Live filter on index pages.
        const filter = document.getElementById('filter');
        if (filter) {
          const entries = [...document.querySelectorAll('[data-name]')];
          filter.addEventListener('input', () => {
            const q = filter.value.trim().toLowerCase();
            entries.forEach(el => el.hidden = q !== '' && !el.dataset.name.includes(q));
          });
        }

        // SVG view controls.
        const stage = document.querySelector('.svg-stage');
        if (stage) {
          document.querySelectorAll('.svg-toolbar button').forEach(btn => btn.addEventListener('click', () => {
            const group = btn.parentElement;
            group.querySelectorAll('button').forEach(b => b.classList.toggle('on', b === btn));
            if (btn.dataset.bg)  stage.className = stage.className.replace(/bg-\\w+/, 'bg-' + btn.dataset.bg);
            if (btn.dataset.fit) stage.classList.toggle('fit', btn.dataset.fit === 'fit');
          }));
        }

        // Keyboard shortcuts.
        const go = key => { const a = document.querySelector(`a[data-key="${key}"]`); if (a) location.href = a.href; };
        document.addEventListener('keydown', e => {
          if (e.metaKey || e.ctrlKey || e.altKey) return;
          const tag = e.target.tagName;
          if (tag === 'INPUT' || tag === 'TEXTAREA' || e.target.isContentEditable) { if (e.key === 'Escape') e.target.blur(); return; }
          switch (e.key) {
            case 'h': go('h'); break;
            case 'u': go('u'); break;
            case 'v': go('v'); break;
            case 'ArrowLeft':  go('←'); break;
            case 'ArrowRight': go('→'); break;
            case 's': toggleSidebar(); break;
            case '/': e.preventDefault(); (filter || document.querySelector('.search input'))?.focus(); break;
          }
        });
      })();
    JS
  end

  # ------------------------------------------------------------------
  # Routes
  # ------------------------------------------------------------------

  helpers do
    def root = settings.files_directory

    def not_found_page(relpath)
      status 404
      content_type :html
      Web.not_found_page(root, relpath)
    end

    # Serve a relative path through the requested route, redirecting to
    # the canonical route when the file type calls for a different one.
    def serve(relpath, route)
      path = Web.resolve(root, relpath)
      return not_found_page(relpath) unless path
      return redirect(to(Web.href_for('dir', relpath))) if File.directory?(path)

      actual = Web.route_for(relpath)
      if route == 'raw'
        params.key?('plain') ? send_file(path, type: 'text/plain') : send_file(path)
      elsif actual == route
        content_type :html
        route == 'md' ? Web.markdown_page(root, relpath, File.read(path)) : Web.svg_page(root, relpath, File.read(path))
      elsif actual
        redirect to(Web.href_for(actual, relpath))
      else
        send_file path
      end
    end
  end

  get '/' do
    content_type :html
    Web.index_page(root, '')
  end

  get '/dir/*' do
    relpath = params['splat'].first
    path    = Web.resolve(root, relpath)
    return not_found_page(relpath) unless path && File.directory?(path)
    return redirect(to(Web.href_for('dir', relpath))) unless request.path_info.end_with?('/')

    content_type :html
    Web.index_page(root, relpath)
  end

  get('/md/*')  { serve(params['splat'].first, 'md') }
  get('/svg/*') { serve(params['splat'].first, 'svg') }
  get('/raw/*') { serve(params['splat'].first, 'raw') }

  get '/search' do
    content_type :html
    Web.search_page(root, params['q'])
  end
end

if __FILE__ == $PROGRAM_NAME
  options = parse_options(ARGV)

  Web.set :files_directory, options[:dir]
  Web.set :bind, options[:bind]
  Web.set :port, options[:port]

  puts <<~INFO
    #{APP_NAME} - #{APP_FULL}
    Serving #{options[:dir]}
    Open http://#{options[:bind]}:#{options[:port]}/ in your browser
    Press Ctrl-C to stop
  INFO

  Web.run!
end
