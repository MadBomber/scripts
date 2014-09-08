#!/bin/env ruby
#########################################################
###
##  File: launch_background_jobs.rb
##  Desc: Uses sudo to launch the typical set of background jobs
#

require 'systemu'

# user ENV variables are not passed in the sudo environment
ENV['GEMS_ROOT']  ||= '/home/Dewayne/sandbox/gems/trunk'

unless "root" == `whoami`
  sudo_command = "sudo "  # NOTE: space at end is required
else
  sudo_command = ""
end

jobs  = { # NOTE: start the command with '=' to avoid sudo prefix
          :rackup   => "=#{ENV['GEMS_ROOT']}/bin/start.sh",     # NOTE: geminabox
          :svnserve => "svnserve -d -r /media/James/svnroot/",
          :ejabberd => "ejabberdctl start",
          :rabbitmq => "rabbitmq-server -detached"
        }

running_processes = `ps aux`

puts "Starting Background Jobs:"

jobs.each_pair do | key, job_command |

  key_str = key.to_s + ' '
  key_str += '.'  while key_str.length < 16
  print "  #{key_str} "
  
  if running_processes.include? key.to_s
    puts "running"
  else

    if '=' == job_command[0]
      puts job_command[1,1024]
      process_id, stdoutput, stderror = systemu("#{job_command[1,1024]}")
    else
      puts job_command
      process_id, stdoutput, stderror = systemu("#{sudo_command}#{job_command}")
    end
    unless stdoutput.empty?
      puts stdoutput
    end
  end

end

puts "Done."

