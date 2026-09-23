#!/usr/bin/env ruby
# frozen_string_literal: true
#
# jira_get.rb — fetch Jira tickets as JSON and generate a markdown rendering.
#
# Usage:
#   jira_get.rb TICKET [TICKET ...]
#
# A TICKET may be a full key (DSVBR-148) or a bare number (148), in which
# case the project key comes from the JIRA_PROJECT envar (default: DSVBR).
#
# Environment:
#   JIRA_API_KEY     required — Atlassian API token
#   JIRA_USER_EMAIL  email the token belongs to (default: dewayne.vanhoozer@cuanschutz.edu)
#   JIRA_SITE        Jira site URL (default: https://ds-connect.atlassian.net)
#   JIRA_PROJECT     default project key for bare ticket numbers (default: DSVBR)
#
# For each ticket, writes <KEY>.json (full raw issue, pretty-printed) and
# <KEY>.md (markdown rendering) into the current working directory.

require "json"
require "net/http"
require "uri"

class JiraGet
  DEFAULT_SITE    = "https://ds-connect.atlassian.net"
  DEFAULT_EMAIL   = "dewayne.vanhoozer@cuanschutz.edu"
  DEFAULT_PROJECT = "DSVBR"

  attr_reader :site, :email, :api_key, :project

  def initialize(env: ENV)
    @site    = env.fetch("JIRA_SITE", DEFAULT_SITE).chomp("/")
    @email   = env.fetch("JIRA_USER_EMAIL", DEFAULT_EMAIL)
    @api_key = env.fetch("JIRA_API_KEY")
    @project = env.fetch("JIRA_PROJECT", DEFAULT_PROJECT)
  rescue KeyError => e
    abort "jira_get: missing required envar #{e.key}"
  end

  # "148" -> "DSVBR-148"; "DSVBR-148" passes through; case-normalized.
  def normalize_key(ticket)
    ticket = ticket.strip.upcase
    ticket.match?(/\A\d+\z/) ? "#{project}-#{ticket}" : ticket
  end

  def fetch_issue(key)
    uri = URI("#{site}/rest/api/3/issue/#{key}?expand=renderedFields")
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(email, api_key)
      request["Accept"] = "application/json"
      http.request(request)
    end
    raise "HTTP #{response.code} fetching #{key}: #{response.body[0, 200]}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end

  def process(ticket)
    key   = normalize_key(ticket)
    issue = fetch_issue(key)
    json_path = "#{key}.json"
    md_path   = "#{key}.md"
    File.write(json_path, JSON.pretty_generate(issue))
    File.write(md_path, MarkdownRenderer.new(issue, site:).render)
    puts "#{key}: wrote #{json_path} and #{md_path}"
  end

  def run(tickets)
    abort "usage: jira_get.rb TICKET [TICKET ...]  (bare numbers use JIRA_PROJECT, default #{DEFAULT_PROJECT})" if tickets.empty?
    failures = tickets.reject do |ticket|
      process(ticket)
      true
    rescue StandardError => e
      warn "jira_get: #{ticket}: #{e.message}"
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

  def fields = @issue["fields"] || {}

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

JiraGet.new.run(ARGV) if __FILE__ == $PROGRAM_NAME
