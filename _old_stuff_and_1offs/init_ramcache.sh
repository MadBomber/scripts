#!/bin/sh
mkfs -t ext2 -q /dev/ram1 8192
[ ! -d /ramcache ] && mkdir -p /ramcache
mount /dev/ram1 /ramcache
#
# TODO: copy stuff to /ramcache

