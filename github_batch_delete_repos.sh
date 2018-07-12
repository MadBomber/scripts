#!/usr/bin/env bash
# Delete all of the repositories in the text file.
# file format is: OwnerAccount/RepoName

# WARNING: There is no safety on this cannon.  You pull the trigger and
#          something is going to happen.

usage=`Usage: $me < some_text_file.txt`

while read r ; do
  echo $r
  echo curl -XDELETE -H "'Authorization: token $GITHUB_API_TOKEN'" "https://api.github.com/repos/$r "
done
