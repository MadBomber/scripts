#!/usr/bin/env bash
# scripts/jira_update.sh
# gem install jira-sync
#
# The system environment variables are usually set by a .envrc file
# in the appropriate directory.
# brew install direnv

# TODO: add tests to ensure require environment variables are available

for project in $JIRA_DB_PROJECTS ; do

    echo "Updating JIRA project: $project ..."

    jira-sync \
        --baseurl JIRASYNC_BASEURL \
        --project $project \
        --user $JIRASYNC_USER \
        --password $JIRASYNC_PASS \
        --target $JIRA_DB_DIR/$project \
        update

done

# It is handy having JIRA tickets downloaded as JSON files in the local
# filesystem.  Then you can run various JQ queries against them without
# having to go to the website.
# brew install jq
