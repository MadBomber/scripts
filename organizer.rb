#!/usr/bin/env ruby
# frozen_string_literal: true
# encoding: utf-8
##########################################################
###
##  File: organizer.rb
##  Desc: process a text file of addresses
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'address_extractor'
require 'awesome_print'

require 'debug_me'
include DebugMe

require 'email_address'

require 'cli_helper'
include CliHelper

require 'json'

configatron.version = '0.0.1'

HELP = <<EOHELP
Important:

# blank lines and lines starting with '#' are ignored

# First block of contigious lines are HEADER things

Name
Position
Phone
Email
Address
Notes

# follow the header block or other blocks of contact info
# if a data item is missing use "no_*" like "no_email"
# no line within a contact block can be blank or start with a '#'


EOHELP

cli_helper("__file_description__") do |o|

  o.bool    '-c', '--contact_roster', 'Contact Roster',   default: false
  o.bool    '-f', '--full_listing',   'Full Listing',     default: false
  o.bool    '-m', '--mailing_list',   'Mailing List',     default: false

end

# Display the usage info
if  ARGV.empty?
  show_usage
  exit
end


# Error check your stuff; use error('some message') and warning('some message')

raw_file = Pathname.new(ARGV.shift)

unless raw_file.exist?
  error "File does not exist: #{raw_file}"
  if raw_file.directory?
    error "Text file is required not a directory: #{raw_file}"
  else
    unless '.txt' == raw_file.extname
      error "File must be of type '*.txt' not #{raw_file.extname}"
    end
  end
end

unless contact_roster? || mailing_list? || full_listing?
  error "One of these must be selected: contact_roster, mailing_list, full_listing"
end

abort_if_errors


######################################################
# Local methods

class String
  def skipable?
    self.empty?  ||  self.start_with?('#')
  end
end

def skip_forward
  while (not LINES.empty?) && LINES.first.skipable? do
    LINES.shift
  end
end


def get_header
  skip_forward
  until LINES.first.skipable? do
    HEADER << LINES.shift
  end
end


def get_contact
  skip_forward
  contact = Hash.new
  (HEADER.size).times do
    key = HEADER_KEYS.first
    contact[key] = LINES.shift
    contact[key] = '' if contact[key].start_with?('no_')

    if :email == key
      value = contact[key]
      unless value.empty?
        unless EmailAddress.valid?(value)
          contact[key] += " Error: #{EmailAddress.error(value)}"
        end
      end
    end

    if :address == key
      value = contact[key]
      contact[key] = AddressExtractor.first_address value
      contact[:original_address] = value
    end

    HEADER_KEYS.rotate!
  end
  return contact
end




def format_mailing_address(contact)
  result  = [ contact[:name] ]
  address = contact[:address]

  unless address.nil?
    result << address[:street1]  if address.has_key? :street1
    result << address[:street2]  if address.has_key? :street2
    result << "#{address[:city]}, #{address[:state]} #{address[:zip]}"
  else
    result << contact[:original_address]
  end

  result.join("\n")
end


######################################################
# Main

at_exit do
  puts
  puts "Done."
  puts
end

ap configatron.to_h  if verbose? || debug?

LINES = raw_file.read.split("\n")

HEADER = Array.new

get_header

HEADER_KEYS = HEADER.map{|header| header.downcase.to_sym}

CONTACTS = Hash.new

until LINES.empty?
  contact = get_contact
  key = contact[:name]
  CONTACTS[key] = contact
end

max_name_size = CONTACTS.keys.map{|k| k.size}.max + 3


DOTS = "."*(max_name_size)

if contact_roster?

  puts "Contact Roster"
  puts "=============="
  puts

  CONTACTS.keys.sort.each do |key|
    print key
    print DOTS[0..(max_name_size-key.size)] + " "
    print CONTACTS[key][:phone] + "  "
    puts CONTACTS[key][:email]
  end

end # if contact_roster?


if mailing_list?
  CONTACTS.keys.sort.each do |key|
    contact = CONTACTS[key]
    puts
    puts format_mailing_address(contact)
  end

end # if mailing_list?

if full_listing?
  ap CONTACTS
end # if full_listing?

