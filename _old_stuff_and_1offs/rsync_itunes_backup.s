#######################################################################
###
##  File: rsync_itunes_backup.s
##  Desc: from "elk.local" backup the primary itunes library to
##        a different place
#

cd /Volumes/Volume_1/iTunes
rsync -v -r --exclude=.DS_Store /Volumes/PUBLIC/Music/iTunes/ . 


