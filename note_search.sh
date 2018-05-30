#!/usr/bin/env bash
# note_search.sh      ... typically aliased as _s
# search through all of the _notes.txt files looking for something
#
# Mac-only because of use of `mdfind` ???
#   mdfind makes use of the spotlight index to find files quickly
#

echo "Search for $@ ..."
mdfind -name "_notes.txt" | xargs \agrep -n $@ | pr -td
