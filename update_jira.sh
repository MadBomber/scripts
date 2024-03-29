#!/usr/bin/env bash
# scripts/update_jira.sh
# gem install jirasync
# brew install gron
# brew install jq


asof="YYYY-MM-DD$1"

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

if [ "YYYY-MM-DD" != "$asof" ] ; then
  for project in $JIRA_DB_PROJECTS ; do
    sed s/YYYY-MM-DD/$asof/ $JIRA_DB_DIR/resync_state.json > $JIRA_DB_DIR/$project/sync_state.json
  done
fi


for project in $JIRA_DB_PROJECTS ; do

    echo "Updating JIRA project: $project ..."

    # TODO: capture list of changed jira tickets

    jira-sync \
        --baseurl $JIRA_HOST \
        --project $project \
        --user $JIRA_USER \
        --password $JIRA_PASS \
        --target $JIRA_DB_DIR/$project \
        fetch

    # TODO: only apply gron to the list of changed tickets

    # for a_file in $JIRA_DB_DIR/$project/*.json ; do
    #   gron $a_file > $a_file.txt
    # done
done
