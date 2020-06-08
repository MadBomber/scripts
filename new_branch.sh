#!/usr/bin/env bash
# healthmatters/new_branch.sh
# Expecting a JIRA ticket id as a CLI parameter
# An optional source directory/branch from which to branch.
#
# External dependencies: git, direnv, git-up

# TODO: check for the required ARG and the optional ARG
# TODO: if no args provided to -h --help then issue usage.


if [ "x" == "x$DEV_BRANCH_PREFIX" ] ; then
  export DEV_BRANCH_PREFIX=dv_
  echo "WARNING: DEV_BRANCH_PREFIX defaulted to: $BASE_PROJECT_DIR"
fi

if [ "x" == "x$BASE_PROJECT_DIR" ] ; then
  echo "ERROR: BASE_PROJECT_DIR is undefined"
  exit -1
fi

jira_ticket=$1
source_branch=$2

if [ "x" == "x$jira_ticket" ] ; then
  echo 'ERROR: No JIRA ticket was provided'
  exit -1
fi


if [ "x" == "x$source_branch" ] ; then
  echo 'Warning: No source branch was provided. Using "develop"'
  source_branch='develop'
fi

echo "Creating new branch for JIRA ticket: $jira_ticket"

jira_ticket_url=$JIRA_BROWSE_URL/$jira_ticket

echo $jira_ticket_url
echo


new_branch_name=${DEV_BRANCH_PREFIX}$jira_ticket
target_dir=working/$jira_ticket

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
echo "cd $BASE_PROJECT_DIR/$target_dir"
