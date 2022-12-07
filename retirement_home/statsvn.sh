#!/bin/sh

export PROJECT=MicroGrid
export VIEWVC=http://138.209.52.146/viewvc/MicroGrid/trunk/
export IN_DIR=/home/hudson/hudson_home/jobs/mg-prototype/workspace
export OUT_DIR=/var/www/html/statsvn/$PROJECT
mkdir $OUT_DIR

svn log -v --xml --username hudson --password hudson . > svn_log.xml

java -jar $HOME/statsvn.jar -username hudson -password hudson -viewvc $VIEWVC -output-dir $OUT_DIR svn_log.xml $IN_DIR




