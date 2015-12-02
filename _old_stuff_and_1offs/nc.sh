#!/usr/bin/env sh
###############################
# send
echo "$@" | nc -4 -w 1 -u 138.209.52.122 8085


# receive
#nc -4 -w 1 -k -l -u 8085

