#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: docker_info.rb
##  Desc: get some basic information on all docker containers
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'awesome_print'
require 'json'
require 'tty-table'

header = [
  'Container ID',
  'Container Name',
  'Status',
  'Container IP:Port',
  'Host IP'
]

table = TTY::Table.new(header: header)


container_ids = `docker ps -a -q`.split("\n")

container_ids.each do |cid|
  details = JSON.parse(`docker inspect #{cid}`).first
  # ap details

  key         = details["HostConfig"]["PortBindings"].keys.first
  port        = key.nil? ? 'N/A' : details["HostConfig"]["PortBindings"][key].first["HostPort"]

  status      = details["State"]["Status"]
  name        = details["Name"][1,99]

  key         = details['NetworkSettings']['Networks'].keys.first
  ip_address  = details['NetworkSettings']['Networks'][key]["IPAddress"]

  if 'running' == status
    command = %Q(docker exec -it #{name} bash -c "ip route | fgrep default | cut -f 3 -d' '")
    host_ip = `#{command}`.chomp
  else
    host_ip = 'N/A'
  end

  table << [ cid, name, status, "#{ip_address}:#{port}", host_ip]

end # container_ids.each do |cid|


puts
puts table.render(:unicode, padding: [0,1]) # padding: 0 lines, 1 char on left and right

kb = Array.new

kb << [ "docker logs <container name>",
        "shows the log file of a container"
      ]

kb << [ "docker exec -it <container name> bash",
        "opens a bash shell on a running container"
      ]

kb << [ "docker (start|stop) <container name>",
        "starts or stops a container"
      ]

kb << [ "docker images",
        "shows all docker images on your workstation"
      ]

kb << [ "docker inspect <container name>",
        "show details about a container's configuration"
      ]

kb << [ "docker ps",
        "shows all currently running containers"
      ]

kb << [ "bin/delete_docker_images_etal.rb --delete-containers --delete-images",
        "cleans up the docker mess on your workstation by deleting everything"
      ]

kb << [ "bin/docker_cui_create.sh db redis web",
        "builds and starts this project's containers"
      ]

minmax = kb.map{|entry| entry[0].size}.minmax
guess1 = minmax.first + ( (minmax.last - minmax.first) / 2)

minmax = kb.map{|entry| entry[1].size}.minmax
guess2 = minmax.first + ( (minmax.last - minmax.first) / 2)


table = TTY::Table.new(['KnowledgeBase of Commands', 'Description'], kb)
puts table.render(:unicode,
                  border: {separator: :each_row},
                  resize:         true,
                  multiline:      true,
                  # column_widths:  [guess1, guess2]
                 )

