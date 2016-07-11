#!/bin/bash
echo
echo

echo "users"
rabbitmqadmin  list users

echo "vhosts"
rabbitmqadmin  list vhosts

echo "connections"
rabbitmqadmin  list connections

echo "exchanges"
rabbitmqadmin  list exchanges

echo "bindings"
rabbitmqadmin  list bindings

echo "permissions"
rabbitmqadmin  list permissions

echo "channels"
rabbitmqadmin  list channels

echo "parameters"
rabbitmqadmin  list parameters

echo "consumers"
rabbitmqadmin  list consumers

echo "queues"
rabbitmqadmin  list queues

echo "policies"
rabbitmqadmin  list policies

echo "nodes"
rabbitmqadmin  list nodes

echo "overview"
rabbitmqadmin  show overview

echo
echo

