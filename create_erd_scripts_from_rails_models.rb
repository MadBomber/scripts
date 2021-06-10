#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: create_erd_scripts_from_rails_models.rb
##  Desc: Create two shell scripts that invoke erd_for.rb default
##        configuration on each ActiveRecord-based model in a
##        Rails application whose root directory is in the
##        ENV['RR'] system environment variable.
##
##        The list of model names is created from the path
##        to the model which is of course relying on standard
##        Rails class and file naming conventions.
##
##        Uses the_silver_searcher (ag) installed by brew
##        find the files in the app/models directory.
##
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

# Get String#camelcase from here:
require 'mods/string_mods'  # from lib/ruby

require 'pathname'

if ENV['RR'].nil?
  puts
  puts "ERROR: this is not one of my Rails apps."
  puts "       $RR must point to a Rails.root"
  puts
  exit(-1)
end

# There is one big Rails app that has a namespace that
# does not match CamelCase convention.
# TODO: makes this a command line option.
layers = {
  'cds' => 'CDS'
}



rr              = Pathname.new ENV['RR']
app_models_dir  = rr + 'app/models'


search_hits = `cd #{app_models_dir.to_s} && ag ActiveRecord::Base`
                  .split("\n")
                  .map{|hit| hit.split(/[ :<]+/)}

file_names  = search_hits
                .reject{|hit| !hit[0].end_with?('.rb')}
                .select{|hit| 'class' == hit[2]}
                .map{|hit| hit[0].gsub('.rb', '')}

model_names = []

file_names.each do |f|
  model_name = ''
  f.split('/').each do |layer|
    if layers.has_key?(layer)
      model_name += layers[layer]
    else
      model_name += layer.camelcase
    end
    model_name += '::'
  end
  model_names << model_name[0..-3]
end

simple_models_file      = File.open(rr+'erd_for_simple_models.sh', 'w')
namespaced_models_file  = File.open(rr+'erd_for_namespaced_models.sh', 'w')

simple_models_file.puts     '#!/bin/bash'
namespaced_models_file.puts '#!/bin/bash'

command_base = 'erd_for.rb -m'

model_names.sort.each_with_index do |m, x|
  if m.include?(':')
    namespaced_models_file.puts "#{command_base} #{m}"
  else
    simple_models_file.puts "#{command_base} #{m}"
  end
end

simple_models_file.close
namespaced_models_file.close
