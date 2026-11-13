#!/bin/sh
WL="$1" ruby -n -e 'puts $_ if $_.chomp.length == ENV["WL"].to_i'

