#!/usr/bin/env ruby
##########################################################
###
##  File: github_open_pr.rb
##  Desc: bring up a PR in Firefox
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
##
#   System Environment Variables Used:
#     GITHUB_PR_BASE_URL
#     Example: https://github.com/<owner>/>repo>/pull/


BROWSER = 'Firefox'

if ARGV.empty?
  puts "ERROR: You need at least one PULL REQUEST Number on the command line"
  exit -1
end

if ENV['GITHUB_PR_BASE_URL'].nil?
  puts "ERROR: The system environment variable GITHUB_PR_BASE_URL is not set."
  exit -1
else
  GITHUB_PR_BASE_URL = ENV['GITHUB_PR_BASE_URL']
end

# MacOS specific
OPEN_COMMAND = "open -a #{BROWSER}"


def base_command(pr_number)
  "#{OPEN_COMMAND} #{GITHUB_PR_BASE_URL}/#{pr_number}"
end

# The GH gli puts a "#" in front of each pr_number.  The only
# way to copy/paste those numbers easily into this program is
# to use '"' around to by-pass BASH thinking that they are comments.
#
args = ARGV.join(" ").split(" ")


parameters = args.map do |pr|
  if pr.start_with? '#'
    pr = pr[1..]
  end

  pr.to_i   # traps junk
end


while !parameters.empty?
  pr_number = parameters.shift

  system( base_command(pr_number) )
end # while !ARGV.empty?
