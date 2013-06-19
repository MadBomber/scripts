######################################################################
###
##	File:	resolve.s
##	Desc:	Resolves svn conflicts in a directory to a specific revision number
#

echo "param: $1"
echo "param: $2"

svn status $1 | grep '^C' | gawk -v REV=$2 '{print "cp " $2 ".*.r" REV " " $2; print "svn resolved " $2}' > temp.s

source temp.s

