#!/usr/bin/env bash
# healthmatters/new_branch.sh
# Expecting a JIRA ticket id as a CLI parameter
#
# $BASE_PROJECT_DIR is an absolute path
# $SPRINT_DIR is a relative path to the $BASE_PROJECT_DIR
# $DEV_BRANCH_PREFIX is a string like "dv_"
#

if [ "x" == "x$DEV_BRANCH_PREFIX" ] ; then
  export DEV_BRANCH_PREFIX=dv_
fi

jira_ticket=$1
source_branch=$2

if [ "x" == "x$jira_ticket" ] ; then
  echo 'ERROR: No JIRA ticket was provided'
  exit -1
fi


if [ "x" == "x$source_branch" ] ; then
  echo 'WARNING: No source branch was provided. Using latest sprint directory'
  echo "         $SPRINT_DIR"
  # sprint_dir is an alias
  source_branch=${BASE_PROJECT_DIR}/$SPRINT_DIR
fi

echo "Creating new branch for JIRA ticket: $jira_ticket"

jira_ticket_url=$JIRA_BROWSE_URL/$jira_ticket

echo $jira_ticket_url
echo


new_branch_name=${DEV_BRANCH_PREFIX}$jira_ticket
target_dir=${WORKING}/$jira_ticket

cd $source_branch
sleep 1
direnv allow
sleep 1
git up
cd ..

cp -R $source_branch $target_dir

cd $target_dir
direnv allow

git checkout -b $new_branch_name

echo "Done."
