#!/usr/bin/env ruby
# frozen_string_literal: true
#
# jira_get.rb — fetch Jira tickets as JSON and generate a markdown rendering.
#
# Usage:
#   jira_get.rb [options] TICKET [TICKET ...]
#
# Options:
#   -h, --help      show help and exit
#   -d, --debug     print debug_me diagnostics to STDERR
#   -v, --verbose   report each step as it happens
#   -s, --status S  also fetch every ticket in status S (repeatable)
#   -a, --assigned N also fetch tickets assigned to users matching N (repeatable)
#   -r, --reported N also fetch tickets reported by users matching N (repeatable)
#   -p, --project K project key for --status and bare numbers (default JIRA_PROJECT)
#   -l, --list      list ticket id and title only; fetch nothing to disk
#   -g, --graph     also write <KEY>.svg: the ticket, what it depends on, and what depends on it
#   -n, --dry-run   show what would be fetched/written; no network, no files
#       --version   show version and exit
#
# A TICKET may be a full key (DSVBR-148), a bare number (148), or a range
# (166-171, or ABC-166-171), inclusive. Bare numbers and bare ranges use the
# project key from the JIRA_PROJECT envar (default: DSVBR). Duplicates are
# fetched once.
#
# --status adds every ticket in the project whose status matches (JQL
# `status in (...)`); repeat it for several statuses. Status tickets are
# combined with any TICKET arguments. With --status, TICKET may be omitted.
#
# --graph writes <KEY>.svg next to the .json/.md for each ticket fetched. It
# shows direct dependencies only, taken from the issue links: "is blocked by"
# / "depends on" links point left of the ticket, "blocks" links right. Other
# link types (relates to, duplicates, ...) are ignored. When a ticket is an
# Epic, its <EPIC>.svg is one graph of the epic and every ticket in it (found
# with JQL `parent = EPIC`) with all of their dependency links; linked
# tickets outside the epic are drawn dashed.
#
# --assigned NAME adds tickets assigned to any active user matching NAME.
# Jira's JQL cannot do substring matching on the assignee field (no `~`), so
# NAME is first resolved via /rest/api/3/user/search (which matches the start
# of display-name words and email), and the search then uses account ids.
# --reported NAME does the same for the reporter field. All of --status,
# --assigned and --reported are ANDed together.
#
# Environment:
#   JIRA_API_KEY     required — Atlassian API token
#   JIRA_USER_EMAIL  email the token belongs to (default: dewayne.vanhoozer@cuanschutz.edu)
#   JIRA_SITE        Jira site URL (default: https://ds-connect.atlassian.net)
#   JIRA_PROJECT     default project key for bare ticket numbers (default: DSVBR)
#
# For each ticket, writes <KEY>.json (full raw issue, pretty-printed) and
# <KEY>.md (markdown rendering) into the current working directory.

require "debug_me"
require "json"
require "net/http"
require "optparse"
require "uri"

include DebugMe

class JiraGet
  DEFAULT_SITE    = "https://ds-connect.atlassian.net"
  DEFAULT_EMAIL   = "dewayne.vanhoozer@cuanschutz.edu"
  DEFAULT_PROJECT = "DSVBR"

  VERSION = "0.2.0"
  DEFAULT_OPTIONS = {debug: false, verbose: false, dry_run: false, list: false, graph: false, statuses: [], assigned: [], reported: [], project: nil}.freeze
  RANGE_PATTERN = /\A(?:(?<project>[A-Z][A-Z0-9_]*)-)?(?<first>\d+)-(?<last>\d+)\z/

  attr_reader :site, :email, :api_key, :project, :options

  # Parses argv (non-destructively) and returns [options, tickets, parser].
  # Prints help/version and exits for --help/--version; aborts on bad flags.
  def self.parse_options(argv)
    options = DEFAULT_OPTIONS.merge(statuses: [], assigned: [], reported: [])
    parser = OptionParser.new do |o|
      o.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] TICKET [TICKET ...]"
      o.separator ""
      o.separator "A TICKET is a key (DSVBR-148), a number (148), or an inclusive range"
      o.separator "(166-171 or ABC-166-171). Bare numbers/ranges use JIRA_PROJECT (default #{DEFAULT_PROJECT})."
      o.separator ""
      o.separator "Options:"
      o.on("-d", "--debug", "Print debug_me diagnostics to STDERR") { options[:debug] = true }
      o.on("-v", "--verbose", "Report each step as it happens") { options[:verbose] = true }
      o.on("-s", "--status STATUS", "Also fetch all tickets in STATUS (repeatable, e.g. -s Done -s Backlog)") { |v| options[:statuses] << v }
      o.on("-a", "--assigned NAME", "Also fetch tickets assigned to users matching NAME (repeatable)") { |v| options[:assigned] << v }
      o.on("-r", "--reported NAME", "Also fetch tickets reported by users matching NAME (repeatable)") { |v| options[:reported] << v }
      o.on("-p", "--project KEY", "Project key for --status and bare numbers (default JIRA_PROJECT)") { |v| options[:project] = v.upcase }
      o.on("-l", "--list", "List ticket id and title only; write no files") { options[:list] = true }
      o.on("-g", "--graph", "Also write KEY.svg showing the ticket's dependencies and dependents") { options[:graph] = true }
      o.on("-n", "--dry-run", "Show what would happen; no network, no files written") { options[:dry_run] = true }
      o.on("--version", "Show version and exit") { puts VERSION; exit }
      o.on("-h", "--help", "Show this help and exit") { puts o; exit }
    end
    tickets = parser.parse(argv)
    [options, tickets, parser]
  rescue OptionParser::ParseError => e
    abort "jira_get: #{e.message}\nTry --help"
  end

  def initialize(env: ENV, options: {})
    @options = DEFAULT_OPTIONS.merge(options)
    @site    = env.fetch("JIRA_SITE", DEFAULT_SITE).chomp("/")
    @email   = env.fetch("JIRA_USER_EMAIL", DEFAULT_EMAIL)
    @api_key = dry_run? ? env.fetch("JIRA_API_KEY", nil) : env.fetch("JIRA_API_KEY")
    @project = @options[:project] || env.fetch("JIRA_PROJECT", DEFAULT_PROJECT)
    debug_me { %i[site email project options] } if debug?
  rescue KeyError => e
    abort "jira_get: missing required envar #{e.key}"
  end

  def statuses = Array(options[:statuses])
  def assigned = Array(options[:assigned])
  def reported = Array(options[:reported])

  # True when --status and/or --assigned ask for a search.
  def search? = !(statuses.empty? && assigned.empty? && reported.empty?)

  def quote_jql(value) = %("#{value.gsub('"', '\"')}")

  # JQL for the --status/--assigned/--reported selection. resolved holds the
  # account ids per field ({assignee: [...], reporter: [...]}); nil (dry-run)
  # shows a placeholder instead.
  def build_jql(resolved = nil)
    clauses = ["project = #{project}"]
    clauses << "status in (#{statuses.map { |n| quote_jql(n) }.join(", ")})" unless statuses.empty?
    {assignee: assigned, reporter: reported}.each do |field, names|
      next if names.empty?

      shown = resolved ? resolved[field].map { |id| quote_jql(id) } : names.map { |n| "<users matching #{quote_jql(n)}>" }
      clauses << "#{field} in (#{shown.join(", ")})"
    end
    "#{clauses.join(" AND ")} ORDER BY key ASC"
  end

  # The JQL to run; resolves user names over the network unless dry-run.
  def search_jql
    return build_jql if dry_run?

    build_jql(assignee: resolve_users(assigned), reporter: resolve_users(reported))
  end

  # Active users whose name/email matches the text, as [{id:, name:}].
  def find_users(text)
    users = http_get("/rest/api/3/user/search", query: text, maxResults: 50, label: "user search")
    users.select { |u| u["active"] != false && u["accountType"].to_s != "app" }
         .map { |u| {id: u["accountId"], name: u["displayName"]} }
  end

  # Account ids for every name (empty list for no names); raises if a name matches no active user.
  def resolve_users(names)
    names.flat_map do |name|
      users = find_users(name)
      raise "no active user matches #{name.inspect}" if users.empty?

      $stderr.puts "jira_get: #{name.inspect} matches: #{users.map { |u| u[:name] }.join(", ")}" if verbose?
      users.map { |u| u[:id] }
    end.uniq
  end

  # Returns the raw issues (with the requested fields) matching the JQL,
  # following pagination.
  def search_raw(jql, fields)
    issues = []
    token = nil
    loop do
      page = http_get("/rest/api/3/search/jql", jql:, fields:, maxResults: 100, nextPageToken: token)
      issues.concat(page.fetch("issues", []))
      token = page["nextPageToken"]
      break if token.nil? || page["isLast"]
    end
    issues
  end

  # Returns [{key:, summary:}] for all tickets matching the JQL.
  def search_issues(jql)
    search_raw(jql, "summary").map { |i| {key: i["key"], summary: i.dig("fields", "summary").to_s} }
  end

  def search_keys(jql) = search_issues(jql).map { |issue| issue[:key] }

  # Title of a single ticket, fetched with only the summary field.
  def fetch_summary(key)
    http_get("/rest/api/3/issue/#{key}", fields: "summary", label: key).dig("fields", "summary").to_s
  end

  def format_listing(key, summary) = "#{key}  #{summary}"

  # Prints "KEY  title" for each ticket named or matched by --status.
  # Returns the keys that could not be looked up.
  def list_tickets(args)
    explicit = expand_tickets(args)
    return list_dry_run(explicit) if dry_run?

    found = search? ? search_issues(search_jql) : []
    titles = found.to_h { |issue| [issue[:key], issue[:summary]] }
    failed = []
    (explicit + titles.keys).uniq.each do |key|
      titles[key] ||= begin
        fetch_summary(key)
      rescue StandardError => e
        $stderr.puts "jira_get: #{key}: #{e.message}"
        failed << key
        next
      end
      puts format_listing(key, titles[key])
    end
    failed
  end

  def list_dry_run(explicit)
    puts "[dry-run] would search: #{search_jql}" if search?
    explicit.each { |key| puts "[dry-run] would look up title of #{key}" }
    []
  end

  def debug?   = options[:debug]
  def verbose? = options[:verbose]
  def dry_run? = options[:dry_run]
  def list?    = options[:list]
  def graph?   = options[:graph]

  # "148" -> "DSVBR-148"; "DSVBR-148" passes through; case-normalized.
  def normalize_key(ticket)
    ticket = ticket.strip.upcase
    ticket.match?(/\A\d+\z/) ? "#{project}-#{ticket}" : ticket
  end

  # Expands one command-line argument into ticket keys:
  #   "148" -> ["DSVBR-148"]; "ABC-7" -> ["ABC-7"]
  #   "166-171" -> DSVBR-166..DSVBR-171; "ABC-5-8" -> ABC-5..ABC-8
  # Raises ArgumentError for a descending range.
  def expand_ticket(arg)
    match = RANGE_PATTERN.match(arg.strip.upcase)
    return [normalize_key(arg)] unless match

    first, last = match[:first].to_i, match[:last].to_i
    raise ArgumentError, "invalid range #{arg} (#{first} > #{last})" if first > last

    prefix = match[:project] || project
    (first..last).map { |n| "#{prefix}-#{n}" }
  end

  # Expands every argument, dropping duplicate keys while keeping order.
  def expand_tickets(args) = args.flat_map { |arg| expand_ticket(arg) }.uniq

  def fetch_issue(key)
    debug_me("GET #{key}") if debug?
    http_get("/rest/api/3/issue/#{key}", expand: "renderedFields", label: key)
  end

  # GET site+path with query params (nil values dropped); returns parsed JSON.
  def http_get(path, label: nil, **query)
    uri = URI("#{site}#{path}")
    uri.query = URI.encode_www_form(query.compact)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(email, api_key)
      request["Accept"] = "application/json"
      http.request(request)
    end
    raise "HTTP #{response.code} fetching #{label || path}: #{response.body[0, 200]}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end

  def process(ticket)
    key       = normalize_key(ticket)
    json_path = "#{key}.json"
    md_path   = "#{key}.md"
    svg_path  = "#{key}.svg"

    if dry_run?
      puts "#{key}: [dry-run] would fetch #{site}/rest/api/3/issue/#{key} and write #{[json_path, md_path, (svg_path if graph?)].compact.join(", ")}#{" (an epic gets one graph covering all its tickets)" if graph?}"
      return
    end

    $stderr.puts "jira_get: fetching #{key} from #{site}" if verbose?
    issue = fetch_issue(key)
    $stderr.puts "jira_get: rendering markdown for #{key}" if verbose?
    File.write(json_path, JSON.pretty_generate(issue))
    File.write(md_path, MarkdownRenderer.new(issue, site:).render)
    note = write_graph(issue) if graph?
    puts "#{key}: wrote #{[json_path, md_path, (svg_path if graph?)].compact.join(", ")}#{note}"
  end

  def epic?(issue) = issue.dig("fields", "issuetype", "name").to_s.casecmp?("Epic")

  def graph_path(key) = "#{key}.svg"

  # Writes <KEY>.svg: the ticket's own graph, or for an epic one graph of the
  # epic and all its tickets. Returns a note for the status line (or nil).
  def write_graph(issue)
    key = issue["key"]
    $stderr.puts "jira_get: building dependency graph for #{key}" if verbose?
    return File.write(graph_path(key), DependencyGraph.new(issue, site:).to_svg) && nil unless epic?(issue)

    children = epic_children(key)
    $stderr.puts "jira_get: #{key} is an epic with #{children.size} ticket(s)" if verbose?
    File.write(graph_path(key), EpicGraph.new(issue, children, site:).to_svg)
    " (epic graph: #{children.size} ticket#{"s" unless children.size == 1})"
  end

  # Raw issues (summary, status, links) of every ticket directly in the epic.
  def epic_children(epic_key)
    search_raw("parent = #{epic_key} ORDER BY key ASC", "summary,status,issuetype,issuelinks")
  end

  # Keys named on the command line plus (when --status/--assigned is used) those found
  # by searching, de-duplicated. In dry-run mode no search is made.
  def collect_keys(args)
    keys = expand_tickets(args)
    return keys unless search?

    jql = search_jql
    debug_me { :jql } if debug?
    if dry_run?
      puts "[dry-run] would search: #{jql}"
      return keys
    end
    $stderr.puts "jira_get: searching: #{jql}" if verbose?
    found = search_keys(jql)
    $stderr.puts "jira_get: #{found.size} ticket(s) found by search" if verbose?
    (keys + found).uniq
  end

  def run_list(args)
    abort "usage: jira_get.rb --list [options] TICKET [TICKET ...]  (see --help)" if args.empty? && !search?
    failures = begin
      list_tickets(args)
    rescue ArgumentError, RuntimeError => e
      abort "jira_get: #{e.message}"
    end
    exit(failures.empty? ? 0 : 1)
  end

  def run(args)
    return run_list(args) if list?

    abort "usage: jira_get.rb [options] TICKET [TICKET ...]  (see --help)" if args.empty? && !search?
    keys = begin
      collect_keys(args)
    rescue ArgumentError, RuntimeError => e
      abort "jira_get: #{e.message}"
    end
    debug_me { :keys } if debug?
    failures = keys.reject do |key|
      process(key)
      true
    rescue StandardError => e
      $stderr.puts "jira_get: #{key}: #{e.message}"
      false
    end
    exit(failures.empty? ? 0 : 1)
  end
end

# Renders one Jira issue (as returned by /rest/api/3/issue) to markdown,
# converting the ADF (Atlassian Document Format) description body.
class MarkdownRenderer
  def initialize(issue, site:)
    @issue = issue
    @site  = site
  end

  def render
    <<~MARKDOWN
      # #{key} — #{fields["summary"]}

      #{metadata_table}

      ## Description

      #{description_markdown}
    MARKDOWN
  end

  def key = @issue["key"]

# Real "fields" win; values missing there (some saved JSON keeps only
# "parent") fall back to versionedRepresentations, whose entries are keyed
# by version number ("1").
def fields = @fields ||= versioned_fields.merge(@issue["fields"] || {})

def versioned_fields
  (@issue["versionedRepresentations"] || {}).transform_values { |v| v.is_a?(Hash) ? v.values.last : v }
end

  def metadata_table
    rows = {
      "Ticket"   => "[#{key}](#{@site}/browse/#{key})",
      "Type"     => dig_name("issuetype"),
      "Status"   => dig_name("status"),
      "Priority" => dig_name("priority"),
      "Assignee" => dig_display("assignee"),
      "Reporter" => dig_display("reporter"),
      "Labels"   => Array(fields["labels"]).join(", "),
      "Created"  => fields["created"],
      "Updated"  => fields["updated"],
      "Parent"   => fields.dig("parent", "key"),
      "Resolution" => dig_name("resolution")
    }.reject { |_, v| v.nil? || v.to_s.empty? }

    lines = ["| Field | Value |", "| --- | --- |"]
    rows.each { |label, value| lines << "| #{label} | #{value} |" }
    lines.join("\n")
  end

  def dig_name(field) = fields.dig(field, "name")

  def dig_display(field) = fields.dig(field, "displayName")

  def description_markdown
    adf = fields["description"]
    return "_(no description)_" if adf.nil?

    adf_to_markdown(adf).strip
  end

  # --- ADF conversion -------------------------------------------------------

  def adf_to_markdown(node, depth = 0)
    return node.map { |child| adf_to_markdown(child, depth) }.join if node.is_a?(Array)

    content = -> { adf_to_markdown(node["content"] || [], depth) }
    case node["type"]
    when "doc"         then content.call
    when "paragraph"   then "#{inline(node)}\n\n"
    when "heading"     then "#{"#" * node.dig("attrs", "level").to_i.clamp(1, 6)} #{inline(node)}\n\n"
    when "bulletList"  then "#{list_items(node, depth) { "-" }}\n"
    when "orderedList" then "#{list_items(node, depth) { |i| "#{i + 1}." }}\n"
    when "blockquote"  then "#{content.call.strip.lines.map { |l| "> #{l}" }.join}\n\n"
    when "codeBlock"   then "```#{node.dig("attrs", "language")}\n#{inline(node)}\n```\n\n"
    when "rule"        then "---\n\n"
    when "table"       then "#{table(node)}\n"
    when "mediaGroup", "mediaSingle" then "_(attached media)_\n\n"
    else content.call
    end
  end

  def list_items(node, depth)
    items = (node["content"] || []).each_with_index.map do |item, index|
      marker = yield(index)
      body = adf_to_markdown(item["content"] || [], depth + 1).strip
      indented = body.lines.map.with_index { |line, n| n.zero? ? line : "#{" " * (marker.length + 1)}#{line}" }.join
      "#{"  " * depth}#{marker} #{indented}"
    end
    "#{items.join("\n")}\n"
  end

  def table(node)
    rows = (node["content"] || []).map do |row|
      cells = (row["content"] || []).map { |cell| adf_to_markdown(cell["content"] || []).strip.gsub("\n", " ") }
      "| #{cells.join(" | ")} |"
    end
    return "" if rows.empty?

    header_width = (node.dig("content", 0, "content") || []).size
    rows.insert(1, "|#{" --- |" * header_width}")
    "#{rows.join("\n")}\n"
  end

  # Renders the inline (text-level) content of a block node.
  def inline(node)
    (node["content"] || []).map { |child| inline_node(child) }.join
  end

  def inline_node(node)
    case node["type"]
    when "text"        then apply_marks(node["text"].to_s, node["marks"] || [])
    when "hardBreak"   then "  \n"
    when "mention"     then "@#{node.dig("attrs", "text") || node.dig("attrs", "displayName")}"
    when "emoji"       then node.dig("attrs", "shortName").to_s
    when "inlineCard"  then url = node.dig("attrs", "url").to_s; "[#{url}](#{url})"
    when "status"      then "`#{node.dig("attrs", "text")}`"
    when "date"        then Time.at(node.dig("attrs", "timestamp").to_i / 1000).strftime("%Y-%m-%d")
    else inline(node)
    end
  end

  def apply_marks(text, marks)
    marks.reduce(text) do |wrapped, mark|
      case mark["type"]
      when "strong"    then "**#{wrapped}**"
      when "em"        then "_#{wrapped}_"
      when "code"      then "`#{wrapped}`"
      when "strike"    then "~~#{wrapped}~~"
      when "link"      then "[#{wrapped}](#{mark.dig("attrs", "href")})"
      else wrapped
      end
    end
  end
end

# Shared pieces for the dependency graphs: how issue links map to
# "depends on" / "depended on by", plus the SVG building blocks (dark theme,
# transparent background).
module GraphSupport
  DEPENDS_ON = /blocked by|depends on|requires|waiting on|is dependent on/i
  DEPENDED_ON_BY = /\bblocks\b|is required by|dependency of|is depended on|is a prerequisite/i

  NODE_W = 270
  NODE_H = 62
  GAP_Y  = 18
  GAP_X  = 130
  MARGIN = 24
  HEADER = 30

  CATEGORY_COLORS = {"new" => "#8b949e", "indeterminate" => "#58a6ff", "done" => "#3fb950"}.freeze
  TICKET_COLOR   = "#f0883e"
  EXTERNAL_COLOR = "#6e7681"

  # Background and border color for each Jira status, in workflow order.
  # Names are matched case-insensitively; edit here when the workflow changes.
  # A status not listed gets DEFAULT_FILL with a grey border.
  STATUS_STYLES = {
    "Backlog"   => {fill: "#262c33", stroke: "#8b949e"}, # grey
    "Shaping"   => {fill: "#3b2a63", stroke: "#a371f7"}, # purple
    "Planning"  => {fill: "#124a4a", stroke: "#39c5cf"}, # teal
    "Up Next"   => {fill: "#1d4577", stroke: "#58a6ff"}, # blue
    "Building"  => {fill: "#5c2340", stroke: "#f778ba"}, # rose
    "In Review" => {fill: "#6b5a0c", stroke: "#e3b341"}, # yellow
    "Done"      => {fill: "#1e5a32", stroke: "#3fb950"}  # green
  }.freeze
  DEFAULT_FILL   = "#161b22"
  DEFAULT_STROKE = "#8b949e"

  # {fill:, stroke:} for a status name; nil when it is not in STATUS_STYLES.
  def status_style(name)
    STATUS_STYLES.find { |status, _| status.casecmp?(name.to_s) }&.last
  end

  def links_of(issue) = Array(issue.dig("fields", "issuelinks"))

  # The linked issue and the link's wording relative to the owning issue
  # ("is blocked by" for an inwardIssue link, "blocks" for an outwardIssue).
  def link_end(link)
    return [link["outwardIssue"], link.dig("type", "outward").to_s] if link["outwardIssue"]

    [link["inwardIssue"], link.dig("type", "inward").to_s]
  end

  def node_for(issue)
    status = issue.dig("fields", "status") || {}
    {key: issue["key"], summary: issue.dig("fields", "summary").to_s, status: status["name"].to_s,
     category: status.dig("statusCategory", "key").to_s}
  end

  def escape(text) = text.to_s.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;").gsub('"', "&quot;")

  def truncate(text, max = 36) = text.length > max ? "#{text[0, max - 1]}…" : text

  # Jira page for a ticket, or nil when the graph was built without a site.
  def browse_url(key) = @site && "#{@site}/browse/#{key}"

  # Wraps SVG markup in a link to the ticket's Jira page (new tab), with a
  # tooltip of the ticket's full title; returns the markup unchanged without a site.
  def linked(key, title, markup)
    url = browse_url(key) or return markup
    %(<a href="#{escape(url)}" xlink:href="#{escape(url)}" target="_blank"><title>#{escape("#{key} — #{title}")}</title>\n#{markup}\n</a>)
  end

  def svg_open(width, height)
    %(<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="#{width}" height="#{height}" viewBox="0 0 #{width} #{height}" font-family="-apple-system, Helvetica, Arial, sans-serif">)
  end

  def defs
    %(<defs><marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#8b949e"/></marker></defs>)
  end

  def heading(text, x, y = MARGIN + 8)
    %(<text x="#{x}" y="#{y}" fill="#8b949e" font-size="13" font-weight="600" letter-spacing="1">#{escape(text.upcase)}</text>)
  end

  def empty_note(x, y)
    %(<text x="#{x}" y="#{y + NODE_H / 2 + 5}" fill="#6e7681" font-size="14" font-style="italic">(none)</text>)
  end

  # Curve from a source's right edge (x1) to a target's left edge (x2); y1/y2 are node tops.
  def edge(x1, y1, x2, y2)
    sy  = y1 + NODE_H / 2.0
    ey  = y2 + NODE_H / 2.0
    mid = (x1 + x2) / 2.0
    %(<path d="M#{x1},#{sy} C#{mid},#{sy} #{mid},#{ey} #{x2 - 2},#{ey}" fill="none" stroke="#8b949e" stroke-width="1.6" marker-end="url(#arrow)"/>)
  end

  # The background always follows the status (see STATUS_STYLES).
  # style picks the border: :member (status color), :ticket (the focus
  # ticket/epic, orange), or :external (outside the epic: grey, dashed).
  def box(node, x, y, style: :member)
    colors = status_style(node[:status])
    fill   = colors ? colors[:fill] : DEFAULT_FILL
    member = colors ? colors[:stroke] : DEFAULT_STROKE
    color  = {ticket: TICKET_COLOR, external: EXTERNAL_COLOR}.fetch(style, member)
    stroke = style == :ticket ? 2.5 : 1.5
    dash   = style == :external ? ' stroke-dasharray="6 4"' : ""
    status = node[:status].to_s.empty? ? "" : %( <tspan fill="#b1bac4" font-size="12" font-weight="400">(#{escape(node[:status])})</tspan>)
    note   = style == :external ? %(\n        <text x="#{x + 12}" y="#{y + 54}" fill="#b1bac4" font-size="11">outside this epic</text>) : ""
    markup = <<~SVG.chomp
      <g>
        <rect x="#{x}" y="#{y}" width="#{NODE_W}" height="#{NODE_H}" rx="8" fill="#{fill}" stroke="#{color}" stroke-width="#{stroke}"#{dash}/>
        <text x="#{x + 12}" y="#{y + 20}" fill="#{color}" font-size="14" font-weight="700">#{escape(node[:key])}#{status}</text>
        <text x="#{x + 12}" y="#{y + 38}" fill="#e6edf3" font-size="12">#{escape(truncate(node[:summary]))}</text>#{note}
      </g>
    SVG
    linked(node[:key], node[:summary], markup)
  end
end

# One ticket's direct dependencies, rendered as an SVG: dependencies on the
# left, the ticket in the middle, dependents on the right. Arrows point in the
# order the work must happen (dependency -> ticket -> dependent).
class DependencyGraph
  include GraphSupport

  def initialize(issue, site: nil)
    @issue = issue
    @site  = site
  end

  def key = @issue["key"]

  # Tickets this one depends on (must finish first).
  def depends_on = linked_nodes(DEPENDS_ON)

  # Tickets that depend on this one.
  def dependents = linked_nodes(DEPENDED_ON_BY)

  # Nodes for links whose wording (relative to this ticket) matches the pattern.
  def linked_nodes(pattern)
    links_of(@issue).filter_map do |link|
      other, text = link_end(link)
      node_for(other) if other && text.match?(pattern)
    end.uniq { |n| n[:key] }
  end

  def to_svg
    left  = depends_on
    right = dependents
    rows  = [left.size, right.size, 1].max
    width  = MARGIN * 2 + NODE_W * 3 + GAP_X * 2
    height = MARGIN * 2 + HEADER + rows * NODE_H + (rows - 1) * GAP_Y
    xs = [MARGIN, MARGIN + NODE_W + GAP_X, MARGIN + (NODE_W + GAP_X) * 2]

    center_y = column_ys(1, rows).first
    left_ys  = column_ys(left.size, rows)
    right_ys = column_ys(right.size, rows)

    parts = [svg_open(width, height), defs]
    parts << heading("Depends on", xs[0]) << heading("Ticket", xs[1]) << heading("Depended on by", xs[2])
    parts << empty_note(xs[0], center_y) if left.empty?
    parts << empty_note(xs[2], center_y) if right.empty?
    left.zip(left_ys).each   { |n, y| parts << edge(xs[0] + NODE_W, y, xs[1], center_y) << box(n, xs[0], y) }
    right.zip(right_ys).each { |n, y| parts << edge(xs[1] + NODE_W, center_y, xs[2], y) << box(n, xs[2], y) }
    parts << box(node_for(@issue), xs[1], center_y, style: :ticket)
    parts << "</svg>\n"
    parts.join("\n")
  end

  # Top y of each of `count` nodes, vertically centered within `rows` rows.
  def column_ys(count, rows)
    total  = rows * NODE_H + (rows - 1) * GAP_Y
    used   = count * NODE_H + [count - 1, 0].max * GAP_Y
    offset = MARGIN + HEADER + (total - used) / 2.0
    Array.new(count) { |i| offset + i * (NODE_H + GAP_Y) }
  end
end

# One SVG for a whole epic: the epic banner, every ticket in the epic, and
# every dependency link of those tickets (including tickets outside the epic,
# drawn dashed). Tickets are laid out in columns by dependency depth, so work
# flows left to right; tickets with no dependency links sit in a grid below.
class EpicGraph
  include GraphSupport

  BANNER_H = 64

  def initialize(epic, children, site: nil)
    @epic     = epic
    @children = children
    @site     = site
  end

  def key = @epic["key"]

  def issues = @children + [@epic]

  # {key => node}; :member is true for the epic and its tickets.
  def nodes
    @nodes ||= issues.each_with_object({}) do |issue, map|
      map[issue["key"]] = node_for(issue).merge(member: true)
    end.tap do |map|
      issues.each do |issue|
        links_of(issue).each do |link|
          other, = link_end(link)
          map[other["key"]] ||= node_for(other).merge(member: false) if other
        end
      end
    end
  end

  # [[from, to]] pairs meaning "from must finish before to".
  def edges
    @edges ||= issues.flat_map do |issue|
      links_of(issue).filter_map do |link|
        other, text = link_end(link)
        next unless other

        if text.match?(DEPENDS_ON) then [other["key"], issue["key"]]
        elsif text.match?(DEPENDED_ON_BY) then [issue["key"], other["key"]]
        end
      end
    end.uniq
  end

  def connected_keys = edges.flatten.uniq

  # Sort key putting DSVBR-6 before DSVBR-10.
  def natural_key(node_key)
    project, number = node_key.to_s.split(/-(?=\d+\z)/, 2)
    [project.to_s, number.to_i]
  end

  # Epic tickets with no dependency links at all.
  def isolated_keys = (@children.map { |c| c["key"] } - connected_keys).sort_by { |k| natural_key(k) }

  def preds_of(node_key) = edges.filter_map { |from, to| from if to == node_key }

  # {key => column}: longest chain of dependencies leading to the ticket.
  # A dependency cycle is broken rather than followed forever.
  def layers
    memo = {}
    visiting = {}
    depth = lambda do |k|
      return memo[k] if memo.key?(k)
      return 0 if visiting[k]

      visiting[k] = true
      memo[k] = preds_of(k).map { |p| depth.call(p) + 1 }.max || 0
      visiting.delete(k)
      memo[k]
    end
    connected_keys.each { |k| depth.call(k) }
    memo
  end

  # Keys per column, ordered by the average row of their dependencies to
  # reduce crossing lines.
  def columns
    cols = layers.group_by { |_, layer| layer }.sort.map { |_, pairs| pairs.map(&:first).sort_by { |k| natural_key(k) } }
    cols.each_index do |i|
      next if i.zero?

      pos = cols.flat_map { |col| col.each_with_index.to_a }.to_h
      cols[i] = cols[i].sort_by do |k|
        ps = preds_of(k)
        [ps.empty? ? pos[k] : ps.sum { |p| pos[p] }.fdiv(ps.size), natural_key(k)]
      end
    end
    cols
  end

  def style_of(node)
    return :ticket if node[:key] == key

    node[:member] ? :member : :external
  end

  def to_svg
    cols      = columns
    grid_cols = [cols.size, 3].max
    width     = MARGIN * 2 + grid_cols * NODE_W + (grid_cols - 1) * GAP_X
    step_x    = NODE_W + GAP_X
    step_y    = NODE_H + GAP_Y
    top       = MARGIN + BANNER_H + 40
    main_rows = cols.map(&:size).max.to_i

    parts = [nil, defs, banner(width)]
    placed = {}
    cols.each_with_index do |col, i|
      offset = (main_rows - col.size) * step_y / 2.0
      col.each_with_index { |k, j| placed[k] = [MARGIN + i * step_x, top + offset + j * step_y] }
    end
    parts << heading("Dependencies (#{edges.size} link#{"s" unless edges.size == 1})", MARGIN, top - 12) unless edges.empty?
    edges.each do |from, to|
      (fx, fy), (tx, ty) = placed[from], placed[to]
      parts << edge(fx + NODE_W, fy, tx, ty)
    end
    placed.each { |k, (x, y)| parts << box(nodes[k], x, y, style: style_of(nodes[k])) }

    bottom = top + main_rows * step_y
    iso = isolated_keys
    unless iso.empty?
      iso_top = edges.empty? ? top : bottom + 24
      parts << heading("No dependencies (#{iso.size})", MARGIN, iso_top - 12)
      iso.each_with_index do |k, i|
        x = MARGIN + (i % grid_cols) * step_x
        y = iso_top + (i / grid_cols) * step_y
        parts << box(nodes[k], x, y, style: :member)
      end
      bottom = iso_top + (iso.size.fdiv(grid_cols).ceil) * step_y
    end
    parts << %(<text x="#{MARGIN}" y="#{top + 14}" fill="#6e7681" font-size="14" font-style="italic">(no tickets in this epic)</text>) if edges.empty? && iso.empty?

    height = [bottom, top + 40].max + MARGIN - GAP_Y
    parts[0] = svg_open(width, height)
    parts << "</svg>\n"
    parts.join("\n")
  end

  # [fill, border, dash, label] for each legend entry: every status in
  # STATUS_STYLES, any other status, and tickets outside the epic.
  def legend_items
    STATUS_STYLES.map { |status, c| [c[:fill], c[:stroke], nil, status] } +
      [[DEFAULT_FILL, DEFAULT_STROKE, nil, "Other status"],
       [DEFAULT_FILL, EXTERNAL_COLOR, "6 4", "Outside this epic"]]
  end

  # Legend swatches, three rows per column, at the right of the banner.
  def legend(width)
    items = legend_items
    columns = items.each_slice(3).to_a
    columns.each_with_index.flat_map do |col, c|
      x = width - MARGIN - 150 * (columns.size - c) - 10
      col.each_with_index.map do |(fill, stroke, dash, label), r|
        y = MARGIN + 9 + r * 17
        dash_attr = dash ? %( stroke-dasharray="#{dash}") : ""
        %(<rect x="#{x}" y="#{y}" width="26" height="12" rx="3" fill="#{fill}" stroke="#{stroke}" stroke-width="1.5"#{dash_attr}/>) +
          %(<text x="#{x + 34}" y="#{y + 10}" fill="#8b949e" font-size="11">#{escape(label)}</text>)
      end
    end.join("\n")
  end

  # Title block for the epic plus the legend.
  def banner(width)
    epic = nodes[key]
    w = width - MARGIN * 2
    summary = "#{@children.size} ticket#{"s" unless @children.size == 1}, #{edges.size} dependency link#{"s" unless edges.size == 1}"
    title_block = <<~SVG.chomp
      <g>
        <rect x="#{MARGIN}" y="#{MARGIN}" width="#{w}" height="#{BANNER_H}" rx="8" fill="#161b22" stroke="#{TICKET_COLOR}" stroke-width="2.5"/>
        <text x="#{MARGIN + 14}" y="#{MARGIN + 24}" fill="#{TICKET_COLOR}" font-size="16" font-weight="700">#{escape(epic[:key])} · EPIC</text>
        <text x="#{MARGIN + 14}" y="#{MARGIN + 43}" fill="#e6edf3" font-size="14">#{escape(truncate(epic[:summary], 70))}</text>
        <text x="#{MARGIN + 14}" y="#{MARGIN + 58}" fill="#8b949e" font-size="11">#{escape(epic[:status])} · #{summary}</text>
      </g>
    SVG
    "#{linked(epic[:key], epic[:summary], title_block)}\n#{legend(width)}"
  end
end

if __FILE__ == $PROGRAM_NAME
  options, tickets = JiraGet.parse_options(ARGV)
  JiraGet.new(options:).run(tickets)
end
