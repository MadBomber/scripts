#!/usr/bin/env ruby
require 'rubygems'  # STDLIB
require 'colortail' # Tail a file and color lines based on regular expressions within that line

Groupings = {

  # This default matching scheme
  'default' => [
      { :match => /EMERGENCY/,    :color => :red,     :attribute => :reverse },
      { :match => /FATAL/,        :color => :red,     :attribute => :bright },
      { :match => /CRITICAL/,     :color => :red },
      { :match => /DEBUG/,        :color => :green },
      { :match => /ERROR/,        :color => :green },
      { :match => /INFO/,         :color => :none },
      { :match => /WARN/,         :color => :yellow }  
  ],
  
  # Matchers for syslog
  'syslog' => [ 
      { :match => /EMERGENCY/,    :color => :red,     :attribute => :reverse },
      { :match => /FATAL/,        :color => :red,     :attribute => :bright },
      { :match => /CRITICAL/,     :color => :red },
      { :match => /DEBUG/,        :color => :green },
      { :match => /ERROR/,        :color => :green },
      { :match => /INFO/,         :color => :none },
      { :match => /WARN/,         :color => :yellow }
  ]

}

