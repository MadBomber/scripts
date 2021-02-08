#!/usr/bin/env ruby
# scripts/monitor_websites.com
# https://istheservicedown.com/problems/suddenlink/4327084-haughton-bossier-parish-louisiana-united-states
# Having multiple outages per day for 10-20 minutes at a time
#

QUITE = true  # when true no output to the console

require 'amazing_print' # Because amazing_print is not being maintained
require 'concurrent'    # Using: Concurrent::TimerTask
require 'faraday'       # Used to access a url and get status
require 'json'          # to read/write config.json file
require 'pathname'      # Because I like it

TEMP_DIR        = Pathname.new(ENV['HOME']) + 'temp' + 'monitor_websites'
LOG_FILEPATH    = TEMP_DIR + 'monitor_websites.log'
LOG_FILE        = File.open(LOG_FILEPATH, 'a')
CONFIG_FILEPATH = TEMP_DIR + 'config.json'


if CONFIG_FILEPATH.exist?
  URLs = JSON.parse(CONFIG_FILEPATH.read)
else
  # Format of the config.json file
  URLs = {
    'suddenlink'  => {
      'url'           => "https://istheservicedown.com/problems/suddenlink/4327084-haughton-bossier-parish-louisiana-united-states",
      'keep'          => 3,
      'last_checked'  => "20200731_164807",
      'last_status'   => 0,
      'period'        => 60      # seconds
    },
    'google'  => {
      'url'           => "http://google.com",
      'keep'          => 3,
      'last_checked'  => "20200731_164807",
      'last_status'   => 0,
      'period'        => 3600      # seconds
    },
  }
end

# saves the webpage just retrieved
def save_file(timestamp, who, options, response)
  filepath  = TEMP_DIR + "#{who}_#{timestamp}.html"
  filepath.write response.body

  delete_old_files(who, options['keep'])
end # def save_file(who, options)


# if files are kept, delete the old ones
def delete_old_files(who, how_many_to_keep=0)
  filenames = `ls -1 #{TEMP_DIR}/#{who}*`.split.sort

  while filenames.size > how_many_to_keep do
    oldest = filenames.shift
    Pathname.new(oldest).delete
  end
end # def keep_files(who, how_many)


# write the retrieval status to a log file
def log_it(timestamp, who, status, out=LOG_FILE)
  entry   = "#{timestamp} #{who} #{status}"
  entry  += " changed" if (URLs[who]['last_status'] != status) and (URLs[who]['last_status'] != 0)
  out.puts entry
  out.flush
end


# Put that same retrieval status on the console unless we should be quite
def to_console(timestamp, who, status, out=STDOUT)
  log_it(timestamp, who, status, out) unless QUITE
end


# save the current status results back to the config.json file
def save_current_status
  CONFIG_FILEPATH.write JSON.pretty_generate(URLs)
end


# update the status of the current retrieval
def update_status(timestamp, who, status)
  URLs[who]['last_checked'] = timestamp
  URLs[who]['last_status']  = status
end


# try to get a website
def check_the_website(who, options)
  timestamp = Time.now.strftime('%Y%m%d_%H%M%S')

  conn = Faraday.new(options['url'], request: {
    open_timeout:  5, # opening a connection
    timeout:      15  # waiting for response
  })

  response  = conn.get('/')
  status    = response.status

  to_console(timestamp, who, status)

  log_it(timestamp, who, status)

  update_status(timestamp, who, status)

  if 200 == status
    # TODO: determine if anything has changed between
    #       response.body and the previouslly save version
    save_file(timestamp, who, options, response) if options.has_key?('keep')
  end
end


# ckean up stuff before the program terminates
def thats_all_folks
  save_current_status

  LOG_FILE.close

  ap URLs

  print "\nDone.\n\n"
end

#####################################################
## Main

# If control-c then exit
trap("SIGINT") { exit }

# make sure everything is clean before program terminates
at_exit do
  thats_all_folks
end

tasks = []  # keep track of all of the concurrent(sic) tasks

# create a timer task for each website
URLs.each_pair do |who, options|
  tasks <<  Concurrent::TimerTask.new(execution_interval: options['period']) do
              check_the_website(who, options)
            end
end

# start all of the tasks running
tasks.each {|task| task.execute}

# intentionally add an infinit loop to this program
while true  do
  sleep 60
end
