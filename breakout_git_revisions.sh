#!/bin/sh
# breakout_gjt_revisions.sh

echo "output directory $1"
echo $1
mkdir -p $1

git branch

# list every revision in format
# UNIXTIMESTAMP-SHA1HASHOFCOMMIT
for l in `git log --pretty=format:"%at-%H"`; do
    stamp=`echo $l | sed -n 's/\-\([^\-]*\)$//p'`
    sha=`echo $l | sed -n 's/^\([^\-]*\)\-//p'`
    mkdir -p "$1/$stamp"
    git checkout $sha
    cp -r * $1/$stamp
done