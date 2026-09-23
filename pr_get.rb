#!/usr/bin/env ruby
# frozen_string_literal: true
#
# pr_get.rb — fetch GitHub pull requests as JSON and generate a markdown rendering.
#
# Usage (from inside a git repo's working directory):
#   pr_get.rb NUMBER [NUMBER ...]
#
# The repository is resolved by the `gh` CLI from the current working
# directory (or from the GH_REPO envar when set, e.g. GH_REPO=owner/repo).
#
# For each pull request, writes PR-<NUMBER>.json (full raw data, pretty-printed)
# and PR-<NUMBER>.md (markdown rendering) into the current working directory.

require "json"
require "open3"
require "time"

class PrGet
  FIELDS = %w[
    number title url state isDraft author baseRefName headRefName
    createdAt updatedAt closedAt mergedAt mergedBy mergeCommit body
    additions deletions changedFiles files commits labels milestone
    reviews comments reviewDecision statusCheckRollup
  ].join(",")

  def initialize(env: ENV)
    @env = env
  end

  def ensure_repo_context!
    return if @env["GH_REPO"]

    _out, status = Open3.capture2e("git", "rev-parse", "--is-inside-work-tree")
    abort "pr_get: not inside a git repository (or set GH_REPO=owner/repo)" unless status.success?
  end

  def fetch_pr(number)
    out, err, status = Open3.capture3("gh", "pr", "view", number.to_s, "--json", FIELDS)
    raise "gh pr view #{number} failed: #{err.strip}" unless status.success?

    JSON.parse(out)
  end

  def process(number)
    pr = fetch_pr(number)
    json_path = "PR-#{pr["number"]}.json"
    md_path   = "PR-#{pr["number"]}.md"
    File.write(json_path, JSON.pretty_generate(pr))
    File.write(md_path, PrMarkdownRenderer.new(pr).render)
    puts "PR ##{pr["number"]}: wrote #{json_path} and #{md_path}"
  end

  def run(numbers)
    abort "usage: pr_get.rb NUMBER [NUMBER ...]  (run inside a git repo, or set GH_REPO=owner/repo)" if numbers.empty?
    ensure_repo_context!
    failures = numbers.reject do |number|
      process(number)
      true
    rescue StandardError => e
      warn "pr_get: #{number}: #{e.message}"
      false
    end
    exit(failures.empty? ? 0 : 1)
  end
end

# Renders one pull request (as returned by `gh pr view --json`) to markdown.
class PrMarkdownRenderer
  JIRA_KEY_PATTERN = /\b[A-Z][A-Z0-9]+-\d+\b/

  def initialize(pr)
    @pr = pr
  end

  def render
    sections = [
      "# PR ##{@pr["number"]} — #{@pr["title"]}",
      metadata_table,
      section("Description", body_markdown),
      section("Commits", commits_table),
      section("Files changed", files_table),
      section("Reviews", reviews_markdown),
      section("Comments", comments_markdown),
      section("Status checks", checks_table)
    ].compact
    "#{sections.join("\n\n")}\n"
  end

  def section(title, content)
    return nil if content.nil? || content.empty?

    "## #{title}\n\n#{content}"
  end

  def metadata_table
    rows = {
      "Pull request" => "[##{@pr["number"]}](#{@pr["url"]})",
      "State"        => state_label,
      "Author"       => author_label(@pr["author"]),
      "Branch"       => "`#{@pr["headRefName"]}` → `#{@pr["baseRefName"]}`",
      "Jira"         => jira_key,
      "Created"      => @pr["createdAt"],
      "Updated"      => @pr["updatedAt"],
      "Merged"       => merged_label,
      "Size"         => "#{@pr["changedFiles"]} files, +#{@pr["additions"]} / −#{@pr["deletions"]}, #{Array(@pr["commits"]).size} commits",
      "Labels"       => Array(@pr["labels"]).map { it["name"] }.join(", "),
      "Milestone"    => @pr.dig("milestone", "title"),
      "Review decision" => @pr["reviewDecision"]
    }.reject { |_, v| v.nil? || v.to_s.empty? }

    lines = ["| Field | Value |", "| --- | --- |"]
    rows.each { |label, value| lines << "| #{label} | #{value} |" }
    lines.join("\n")
  end

  def state_label
    @pr["isDraft"] ? "#{@pr["state"]} (draft)" : @pr["state"]
  end

  def author_label(author)
    author&.dig("login")
  end

  def merged_label
    return nil unless @pr["mergedAt"]

    by = author_label(@pr["mergedBy"])
    [@pr["mergedAt"], by && "by #{by}"].compact.join(" ")
  end

  # First Jira-style key found in the branch name, title, or body.
  def jira_key
    [@pr["headRefName"], @pr["title"], @pr["body"]].compact.each do |text|
      match = text.match(JIRA_KEY_PATTERN)
      return match[0] if match
    end
    nil
  end

  def body_markdown
    body = @pr["body"].to_s.strip
    body.empty? ? "_(no description)_" : body
  end

  def commits_table
    commits = Array(@pr["commits"])
    return nil if commits.empty?

    lines = ["| SHA | Message |", "| --- | --- |"]
    commits.each do |commit|
      headline = commit["messageHeadline"] || commit["message"].to_s.lines.first.to_s.strip
      lines << "| `#{commit["oid"].to_s[0, 7]}` | #{headline} |"
    end
    lines.join("\n")
  end

  def files_table
    files = Array(@pr["files"])
    return nil if files.empty?

    lines = ["| File | +/− |", "| --- | --- |"]
    files.each { |f| lines << "| `#{f["path"]}` | +#{f["additions"]} / −#{f["deletions"]} |" }
    lines.join("\n")
  end

  def reviews_markdown
    reviews = Array(@pr["reviews"])
    return nil if reviews.empty?

    reviews.map do |review|
      header = "### #{author_label(review["author"])} — #{review["state"]} (#{review["submittedAt"]})"
      body = review["body"].to_s.strip
      body.empty? ? header : "#{header}\n\n#{body}"
    end.join("\n\n")
  end

  def comments_markdown
    comments = Array(@pr["comments"])
    return nil if comments.empty?

    comments.map do |comment|
      "### #{author_label(comment["author"])} (#{comment["createdAt"]})\n\n#{comment["body"].to_s.strip}"
    end.join("\n\n")
  end

  def checks_table
    checks = Array(@pr["statusCheckRollup"])
    return nil if checks.empty?

    lines = ["| Check | Result |", "| --- | --- |"]
    checks.each do |check|
      name   = check["name"] || check["context"]
      result = check["conclusion"] || check["state"]
      result = "PENDING" if result.to_s.empty?
      lines << "| #{name} | #{result} |"
    end
    lines.join("\n")
  end
end

PrGet.new.run(ARGV) if __FILE__ == $PROGRAM_NAME
