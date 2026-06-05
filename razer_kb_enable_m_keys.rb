#!/usr/bin/env ruby
# frozen_string_literal: true
#
# razer_kb_enable_m_keys.rb
#
# Sets the Razer BlackWidow Chroma V2 to device mode 0x02 (factory testing),
# which causes M1-M5 to emit F13-F17 as standard HID keycodes.
#
# Exits immediately after setting the mode — no daemon, no cleanup.
# The mode persists until the keyboard loses power or is reprogrammed.
#
# Usage:
#   ruby razer_kb_enable_m_keys.rb           # silent on success
#   ruby razer_kb_enable_m_keys.rb --verbose # confirm when done
#
# Add to ~/.bashrc:
#   ruby ~/sandbox/git_repos/madbomber/scripts/razer_kb_enable_m_keys.rb

require 'fiddle'
require 'fiddle/import'

HIDAPI_LIB = [
  '/opt/homebrew/lib/libhidapi.dylib',
  '/usr/local/lib/libhidapi.dylib',
].find { |p| File.exist?(p) }

abort "libhidapi not found — brew install hidapi" unless HIDAPI_LIB

module LibHIDAPI
  extend Fiddle::Importer
  dlload HIDAPI_LIB
  extern 'void* hid_enumerate(unsigned short vendor_id, unsigned short product_id)'
  extern 'void  hid_free_enumeration(void* devs)'
  extern 'void* hid_open_path(const char* path)'
  extern 'int   hid_send_feature_report(void* dev, void* data, unsigned long length)'
  extern 'void  hid_close(void* dev)'
end

RAZER_VID         = 0x1532
BLACKWIDOW_V2_PID = 0x0221
REPORT_SIZE       = 90

def enumerate(vid, pid)
  head = LibHIDAPI.hid_enumerate(vid, pid)
  return [] if head.to_i == 0
  paths = []
  node  = head
  until node.to_i == 0
    path_addr = node[0, 8].unpack1('Q')
    paths << {
      path:      path_addr == 0 ? '' : Fiddle::Pointer.new(path_addr).to_s,
      usage_page: node[48, 2].unpack1('S'),
      usage:      node[50, 2].unpack1('S'),
      interface:  node[52, 4].unpack1('i'),
    }
    node = Fiddle::Pointer.new(node[56, 8].unpack1('Q'))
  end
  LibHIDAPI.hid_free_enumeration(head)
  paths
end

def build_mode_report(mode)
  report    = Array.new(REPORT_SIZE, 0)
  report[1] = 0xFF   # transaction_id
  report[5] = 0x02   # data_size
  report[6] = 0x00   # command_class
  report[7] = 0x04   # command_id
  report[8] = mode
  report[88] = report[2..87].reduce(0) { |crc, b| crc ^ b }
  report
end

interfaces = enumerate(RAZER_VID, BLACKWIDOW_V2_PID)
abort "Razer BlackWidow Chroma V2 not found." if interfaces.empty?

ctrl = interfaces.find { |d| d[:interface] == 2 && d[:usage] == 2 } ||
       interfaces.find { |d| d[:interface] == 2 } ||
       interfaces.first

handle = LibHIDAPI.hid_open_path(ctrl[:path])
abort "Could not open Razer HID interface." if handle.to_i == 0

data   = ([0x00] + build_mode_report(0x02)).pack('C*')
result = LibHIDAPI.hid_send_feature_report(handle, data, data.bytesize)
LibHIDAPI.hid_close(handle)

if result < 0
  abort "Failed to set device mode (hid_send_feature_report returned #{result})."
end

puts "Razer BlackWidow V2: M-keys enabled (mode 0x02, F13-F17)." if ARGV.include?('--verbose')
