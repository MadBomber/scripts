#!/usr/bin/env bash
# Reviews a git log and show all changes
# made to a specific method in a specific
# filepath.

method=$1
filepath=$2

git log -L "$method:$filepath" -n3
