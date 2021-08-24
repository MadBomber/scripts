#!/usr/bin/env bash
# scripts/fetch_jira.sh
# gem install jira-sync

if [ "x" = "x$JIRA_DB_PROJECTS" ] ; then
  echo
  echo "ERROR: JIRA_DB_PROJECTS is not defined"
  echo
  exit 1
fi

if [ "x" = "x$JIRA_DB_DIR" ] ; then
  echo
  echo "ERROR: JIRA_DB_DIR is not defined"
  echo
  exit 1
fi


for project in $JIRA_DB_PROJECTS ; do

    echo "Fetching JIRA project: $project ..."

    jira-sync \
        --baseurl $JIRA_HOST \
        --project $project \
        --user $JIRA_USER \
        --password $JIRA_PASS \
        --target $JIRA_DB_DIR/$project \
        fetch

done
