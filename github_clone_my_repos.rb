#!/usr/bin/env ruby
# ~/scripts/github_clone_my_repos.rb
#

require 'debug_me'
include DebugMe

require 'amazing_print'
require 'github_api'
require 'pathname'

require 'cli_helper'
include CliHelper

configatron.version = '0.0.2'

HELP = <<EOHELP
Important:

  --dryrun  will not download the content of any repo.
            It will just list the repo names.
EOHELP


cli_helper("Clone all github for a given user") do |o|
  o.bool          '--dryrun', 'only report stuff',      default: false
  o.string  '-u', '--user',   'user account on github'
  o.path    '-p', '--path',   'base directory path',    default: Pathname.new(ENV['HOME']) + 'sandbox/git_repos'
end


# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end

# Error check your stuff; use error('some message') and warning('some message')

abort_if_errors


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

github_account        = configatron.user

sandbox_path          = configatron.path + github_account
clone_command         = 'git clone ssh://git@github.com/'
git_remote_command    = 'git remote -v'
git_upstream_command  = 'git remote add upstream '


my_github_repos = Github.repos.list(
  user:             github_account,
  auto_pagination:  true
)

puts "\n#{github_account}'s github repos"
ap my_github_repos.map{|r| r.name}

forked_repos    = my_github_repos.select{|r| r.fork}
original_repos  = my_github_repos.select{|r| !r.fork}

puts "\nforked repos"
ap forked_repos.map{|r| r.name}

puts "\noriginal repos"
ap original_repos.map{|r| r.name}


cloned_repos = sandbox_path.children.select {|c| c.directory?}
  .map{|c| c.basename.to_s}

puts "\ncloned repos"
ap cloned_repos

new_github_repos = my_github_repos.reject{|r| cloned_repos.include? r.name}

puts "\nnew github repos"
ap new_github_repos.map{|r| r.name}

new_github_repos.each do |r|
  command = "#{clone_command}#{r.full_name} #{sandbox_path}/#{r.name}"
  puts "\n#{command} ..."
  `#{command}` unless dryrun?

  if r.fork
    target_dir = Pathname.new("#{sandbox_path}/#{r.name}")
    target_dir.mkdir unless target_dir.exist?

    remotes = `cd #{target_dir} && #{git_remote_command}`

    unless dryrun?  ||  remotes.include?('upstream')

      puts "Setting upstream remote for a forked repo ..."

      my_repo = Github.repos.get(
        user: github_account,
        repo: r.name
      )

      upstream = my_repo.parent.html_url

      command = "cd #{sandbox_path}/#{r.name} && #{git_upstream_command} #{upstream}"
      puts command
      `#{command}`

    end
  end
end

__END__

{
                   "id" => 151115029,
              "node_id" => "MDEwOlJlcG9zaXRvcnkxNTExMTUwMjk=",
                 "name" => "30-seconds-of-code",
            "full_name" => "MadBomber/30-seconds-of-code",
              "private" => false,
                "owner" => {
                      "login" => "MadBomber",
                         "id" => 21101,
                    "node_id" => "MDQ6VXNlcjIxMTAx",
                 "avatar_url" => "https://avatars2.githubusercontent.com/u/21101?v=4",
                "gravatar_id" => "",
                        "url" => "https://api.github.com/users/MadBomber",
                   "html_url" => "https://github.com/MadBomber",
              "followers_url" => "https://api.github.com/users/MadBomber/followers",
              "following_url" => "https://api.github.com/users/MadBomber/following{/other_user}",
                  "gists_url" => "https://api.github.com/users/MadBomber/gists{/gist_id}",
                "starred_url" => "https://api.github.com/users/MadBomber/starred{/owner}{/repo}",
          "subscriptions_url" => "https://api.github.com/users/MadBomber/subscriptions",
          "organizations_url" => "https://api.github.com/users/MadBomber/orgs",
                  "repos_url" => "https://api.github.com/users/MadBomber/repos",
                 "events_url" => "https://api.github.com/users/MadBomber/events{/privacy}",
        "received_events_url" => "https://api.github.com/users/MadBomber/received_events",
                       "type" => "User",
                 "site_admin" => false
    },
             "html_url" => "https://github.com/MadBomber/30-seconds-of-code",
          "description" => "Curated collection of useful JavaScript snippets that you can understand in 30 seconds or less.",
                 "fork" => true,
                  "url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code",
            "forks_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/forks",
             "keys_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/keys{/key_id}",
    "collaborators_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/collaborators{/collaborator}",
            "teams_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/teams",
            "hooks_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/hooks",
     "issue_events_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/issues/events{/number}",
           "events_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/events",
        "assignees_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/assignees{/user}",
         "branches_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/branches{/branch}",
             "tags_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/tags",
            "blobs_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/git/blobs{/sha}",
         "git_tags_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/git/tags{/sha}",
         "git_refs_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/git/refs{/sha}",
            "trees_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/git/trees{/sha}",
         "statuses_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/statuses/{sha}",
        "languages_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/languages",
       "stargazers_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/stargazers",
     "contributors_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/contributors",
      "subscribers_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/subscribers",
     "subscription_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/subscription",
          "commits_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/commits{/sha}",
      "git_commits_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/git/commits{/sha}",
         "comments_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/comments{/number}",
    "issue_comment_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/issues/comments{/number}",
         "contents_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/contents/{+path}",
          "compare_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/compare/{base}...{head}",
           "merges_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/merges",
          "archive_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/{archive_format}{/ref}",
        "downloads_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/downloads",
           "issues_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/issues{/number}",
            "pulls_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/pulls{/number}",
       "milestones_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/milestones{/number}",
    "notifications_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/notifications{?since,all,participating}",
           "labels_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/labels{/name}",
         "releases_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/releases{/id}",
      "deployments_url" => "https://api.github.com/repos/MadBomber/30-seconds-of-code/deployments",
           "created_at" => "2018-10-01T15:51:40Z",
           "updated_at" => "2018-10-01T15:51:44Z",
            "pushed_at" => "2018-10-01T12:29:10Z",
              "git_url" => "git://github.com/MadBomber/30-seconds-of-code.git",
              "ssh_url" => "git@github.com:MadBomber/30-seconds-of-code.git",
            "clone_url" => "https://github.com/MadBomber/30-seconds-of-code.git",
              "svn_url" => "https://github.com/MadBomber/30-seconds-of-code",
             "homepage" => "https://30secondsofcode.org/",
                 "size" => 13031,
     "stargazers_count" => 0,
       "watchers_count" => 0,
             "language" => "JavaScript",
           "has_issues" => false,
         "has_projects" => true,
        "has_downloads" => true,
             "has_wiki" => true,
            "has_pages" => false,
          "forks_count" => 0,
           "mirror_url" => nil,
             "archived" => false,
    "open_issues_count" => 0,
              "license" => {
            "key" => "cc0-1.0",
           "name" => "Creative Commons Zero v1.0 Universal",
        "spdx_id" => "CC0-1.0",
            "url" => "https://api.github.com/licenses/cc0-1.0",
        "node_id" => "MDc6TGljZW5zZTY="
    },
                "forks" => 0,
          "open_issues" => 0,
             "watchers" => 0,
       "default_branch" => "master"
}
              #=> nil
