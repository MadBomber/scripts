#!/usr/bin/env ruby
# branch_report.rb — generate a markdown report of every branch in a git repo:
# creation date, creator, last activity, merged/active/stale status, and
# associated pull requests (exact head match, plus PRs sharing the same
# ticket ID for repos whose PRs come from differently named branches).
#
# Usage:
#   branch_report.rb [output_file]
#
# Run from anywhere inside the repo. Output defaults to notes/branch_report.md
# under the repo root. Requires: git, gh (authenticated).

require "json"
require "date"
require "open3"

STALE_DAYS   = 30
TICKET_REGEX = /([a-z]{2,10})[-_ ]?(\d+)/i # e.g. DSVBR-155, dsvbr_155

def sh(*args)
  out, err, status = Open3.capture3(*args)
  abort "command failed: #{args.join(' ')}\n#{err}" unless status.success?
  out
end

def git(*args) = sh("git", "-C", REPO, *args).strip

REPO = sh("git", "rev-parse", "--show-toplevel").strip
TODAY = Date.today

output_path = ARGV[0] || File.join(REPO, "notes", "branch_report.md")

# --- Gather PRs -------------------------------------------------------------

prs = JSON.parse(
  sh("gh", "pr", "list", "--state", "all", "--limit", "1000",
     "--json", "number,title,headRefName,state,createdAt,mergedAt,author,url")
)
prs_by_head = prs.group_by { |pr| pr["headRefName"] }

BOT_BRANCH_PREFIXES = %w[dependabot/ trunk-io/].freeze

def ticket_of(name)
  return nil if BOT_BRANCH_PREFIXES.any? { |p| name.start_with?(p) }

  m = name.match(TICKET_REGEX)
  m && "#{m[1].upcase}-#{m[2]}"
end

prs_by_ticket = prs.group_by { |pr| ticket_of(pr["headRefName"]) }
prs_by_ticket.delete(nil)

# --- Gather branches --------------------------------------------------------

current_branch = git("rev-parse", "--abbrev-ref", "HEAD")
default_branch = git("rev-parse", "--abbrev-ref", "origin/HEAD")
                   .sub(%r{\Aorigin/}, "")

refs = git("for-each-ref",
           "--format=%(refname:short)\t%(committerdate:iso8601)\t%(authorname)",
           "refs/heads", "refs/remotes/origin")
         .lines.map { |l| l.chomp.split("\t") }

skip = ["origin", "origin/HEAD", "origin/#{default_branch}", default_branch]
branches = refs.reject { |name, _, _| skip.include?(name) }

def merged_into_default?(ref)
  _out, _err, status = Open3.capture3(
    "git", "-C", REPO, "merge-base", "--is-ancestor", ref, "origin/#{DEFAULT}"
  )
  status.success?
end
DEFAULT = default_branch
CURRENT = current_branch

rows = branches.map do |ref, tip_date_s, tip_author|
  short  = ref.sub(%r{\Aorigin/}, "")
  local  = !ref.start_with?("origin/")
  ticket = ticket_of(short)

  exact_prs   = prs_by_head.fetch(short, [])
  related_prs = (prs_by_ticket.fetch(ticket, []) - exact_prs if ticket) || []
  merged_pr   = exact_prs.find { |pr| pr["state"] == "MERGED" }
  open_pr     = exact_prs.find { |pr| pr["state"] == "OPEN" }

  # Creation date: first commit unique to the branch; when everything has been
  # merged into the default branch that history is gone, so fall back to the
  # exact-head PR's creation date.
  first_unique = git("log", "--reverse", "--format=%aI",
                     "origin/#{DEFAULT}..#{ref}").lines.first&.strip
  created = first_unique || exact_prs.map { |pr| pr["createdAt"] }.min
  created_date = created && Date.parse(created)

  # Creator: author of the first unique commit, else PR author, else tip author.
  creator = if first_unique
              git("log", "--reverse", "--format=%an",
                  "origin/#{DEFAULT}..#{ref}").lines.first&.strip
            end
  creator ||= exact_prs.min_by { |pr| pr["createdAt"] }&.dig("author", "login")
  creator ||= tip_author

  merged    = merged_into_default?(ref) || !merged_pr.nil?
  merged_at = merged_pr && Date.parse(merged_pr["mergedAt"])

  tip_date = Date.parse(tip_date_s)
  age_days = (TODAY - tip_date).to_i

  status =
    if local && short == CURRENT               then "Current branch"
    elsif open_pr                              then "Active (open PR)"
    elsif merged                               then "Merged — delete"
    elsif age_days <= STALE_DAYS               then "Active"
    else                                            "Stale — review & delete"
    end

  {
    short:, local:, creator:, created_date:, tip_date:, age_days:,
    merged:, merged_at:, status:, exact_prs:, related_prs:
  }
end

rows.sort_by! { |r| [r[:status].start_with?("Merged") ? 1 : 0, -r[:tip_date].jd] }

# --- Render -----------------------------------------------------------------

def fmt(date) = date ? date.strftime("%Y-%m-%d") : "—"

def pr_cell(row)
  cells = row[:exact_prs].sort_by { |pr| pr["number"] }.map do |pr|
    "[##{pr['number']}](#{pr['url']}) (#{pr['state'].capitalize})"
  end
  cells += row[:related_prs].sort_by { |pr| pr["number"] }.map do |pr|
    "[##{pr['number']}](#{pr['url']}) (#{pr['state'].capitalize}, same ticket)"
  end
  cells.empty? ? "—" : cells.join("<br>")
end

def table_row(r)
  name = r[:local] ? "**#{r[:short]}** (local)" : r[:short]
  "| #{name} | #{fmt(r[:created_date])} | #{r[:creator]} | " \
    "#{fmt(r[:tip_date])} (#{r[:age_days]}d ago) | " \
    "#{r[:merged] ? (r[:merged_at] ? fmt(r[:merged_at]) : 'yes') : 'no'} | " \
    "#{r[:status]} | #{pr_cell(r)} |"
end

TABLE_HEADER = <<~MD
  | Branch | Created | Creator | Last Commit | Merged | Status | Pull Request(s) |
  |--------|---------|---------|-------------|--------|--------|-----------------|
MD

active = rows.select { |r| r[:status] =~ /\A(Active|Current)/ }
stale  = rows.select { |r| r[:status].start_with?("Stale") }
merged = rows.select { |r| r[:status].start_with?("Merged") }

report = +<<~MD
  # Branch Report — #{File.basename(REPO)}

  Generated: #{TODAY.strftime('%Y-%m-%d')} · Default branch: `#{default_branch}` · #{rows.size} branches analyzed (excluding `#{default_branch}`)

  **Legend**

  - **Created** — date of the branch's first commit not on `#{default_branch}` (falls back to the PR creation date; `—` means the branch was fully merged, so its start point can no longer be recovered from history).
  - **Merged** — the branch tip is an ancestor of `origin/#{default_branch}`, or a PR from this branch was merged (date shown = PR merge date; squash/rebase merges leave the tip as a non-ancestor, so the PR is the source of truth).
  - **Status** — `Active` = open PR or commits within the last #{STALE_DAYS} days; `Stale` = unmerged, no open PR, no activity for over #{STALE_DAYS} days; `Merged` = safe to delete.
  - **Pull Request(s)** — exact matches are PRs opened from this branch; *same ticket* marks PRs opened from a sibling branch for the same ticket ID.

  ## Summary

  | Category | Count |
  |----------|-------|
  | Active (open PR or recent commits) | #{active.size} |
  | Stale — candidates for deletion | #{stale.size} |
  | Merged — safe to delete | #{merged.size} |

  ## Active branches

MD

report << TABLE_HEADER
active.each { |r| report << table_row(r) << "\n" }

report << "\n## Stale branches (unmerged, inactive > #{STALE_DAYS} days)\n\n"
report << "These have no open PR and no recent activity. Review for salvageable work, then delete.\n\n"
report << TABLE_HEADER
stale.each { |r| report << table_row(r) << "\n" }

report << "\n## Merged branches (safe to delete)\n\n"
report << TABLE_HEADER
merged.each { |r| report << table_row(r) << "\n" }

report << <<~MD

  ## Cleanup commands

  Prune remote-tracking refs that no longer exist on the remote:

  ```bash
  git fetch --prune
  ```

  Delete a merged remote branch:

  ```bash
  git push origin --delete <branch-name>
  ```

  > Dependabot and trunk-io branches are managed by their bots — they are deleted automatically when their PRs merge or are superseded, so manual cleanup is rarely needed.
MD

require "fileutils"
FileUtils.mkdir_p(File.dirname(output_path))
File.write(output_path, report)
puts "Wrote #{output_path} (#{report.lines.size} lines)"
puts "Active: #{active.size}, Stale: #{stale.size}, Merged: #{merged.size}"
