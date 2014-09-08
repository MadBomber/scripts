#!/bin/sh
wl=$1
ruby -n -e 'puts $_ if $_.chomp.length == ENV["wl"].to_i'


