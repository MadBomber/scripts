#!/usr/bin/env bash
###################################################################################
###
##  File: test_rubies.sh
##  Desc: Execute a Ruby project under various Ruby versions
#

# Turn on bash verbose mode
set -o verbose
RBXOPT="-Xrbc.db" rvm ruby-1.8.7-p334,ruby-1.9.2-p180,rbx,jruby-1.6.2 exec bundle
RBXOPT="-Xrbc.db" rvm ruby-1.8.7-p334,ruby-1.9.2-p180,rbx,jruby-1.6.2 exec bundle exec rake spec
