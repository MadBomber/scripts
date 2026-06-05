#!/usr/bin/env ruby
# frozen_string_literal: true
#
# razer_macro_daemon.rb
#
# DIAGNOSTIC / DEVELOPMENT TOOL for the Razer BlackWidow Chroma V2 M-keys.
#
# PRODUCTION SETUP (what actually runs day-to-day):
#   1. razer_kb_enable_m_keys.rb — called from ~/.bashrc at login.
#      Sets device mode 0x02 so M1–M5 emit F13–F17 as standard HID keycodes.
#      Exits immediately; the mode persists until the keyboard loses power.
#   2. USB Overdrive — maps F13–F17 to macros/text/keystrokes.
#      Already installed for extra mouse buttons; handles M-key macros too.
#
# This file is useful for:
#   --inspect    Enumerate HID interfaces and show which is the command interface.
#   --sniff-all  Set mode 0x02 and poll raw HID bytes (confirms mode setting works).
#   --debug      Run CGEventTap daemon and print every keydown virtual keycode.
#                Used to discover keycode values when adding new key mappings.
#   (no flag)    Full CGEventTap macro daemon (superseded by USB Overdrive in
#                production, but kept here as a pure-Ruby reference implementation).
#
# INPUT MONITORING PERMISSION (required for --debug and daemon mode):
#   CGEventTap needs the ruby process itself — not just iTerm — in the
#   Input Monitoring list. On an rbenv system the actual binary is deep inside
#   ~/.rbenv/versions/<ver>/bin/ruby, which the macOS file picker hides.
#
#   Workaround that worked: add the rbenv SHIM instead:
#     /Users/dewayne/.rbenv/shims/ruby
#   The shim exec-chains to the real binary, and macOS accepted it for the
#   permission check. To navigate to it in the System Settings file picker,
#   press Cmd+Shift+G and type: /Users/dewayne/.rbenv/shims
#   then select "ruby".
#
# ARCHITECTURE:
#   1. HIDAPI (libhidapi.dylib, IOKit backend):
#      Sends Razer feature report to Interface 2 (GenDesktop/Mouse, usage=2)
#      to set device mode 0x02. M-keys then emit F13–F17 as standard HID
#      keycodes. Safe on force-kill — normal typing is never affected.
#   2. CGEventTap (CoreGraphics framework):
#      Passive system-wide keydown monitor via Fiddle::Closure callback.
#      Intercepts F13–F17 virtual keycodes and fires AppleScript macros.
#      macOS 13+ blocks raw IOHIDDeviceOpen on keyboard interfaces even with
#      Input Monitoring permission, so CGEventTap is the correct approach.
#
# M-KEY VIRTUAL KEYCODES (confirmed on this keyboard in mode 0x02):
#   M1=105 (F13/kVK_F13)  M2=107 (F14/kVK_F14)  M3=113 (F15/kVK_F15)
#   M4=106 (F16/kVK_F16)  M5=64  (F17/kVK_F17)
#
# Requirements: brew install hidapi

require 'fiddle'
require 'fiddle/import'

# ---------------------------------------------------------------------------
# Locate libhidapi
# ---------------------------------------------------------------------------
HIDAPI_LIB = [
  '/opt/homebrew/lib/libhidapi.dylib',   # Homebrew on Apple Silicon
  '/usr/local/lib/libhidapi.dylib',       # Homebrew on Intel
].find { |p| File.exist?(p) }

abort "libhidapi not found. Install it with: brew install hidapi" unless HIDAPI_LIB

# ---------------------------------------------------------------------------
# libhidapi Fiddle bindings
# ---------------------------------------------------------------------------
module LibHIDAPI
  extend Fiddle::Importer
  dlload HIDAPI_LIB

  extern 'void* hid_enumerate(unsigned short vendor_id, unsigned short product_id)'
  extern 'void  hid_free_enumeration(void* devs)'
  extern 'void* hid_open_path(const char* path)'
  extern 'int   hid_read_timeout(void* dev, void* data, unsigned long length, int milliseconds)'
  extern 'int   hid_read(void* dev, void* data, unsigned long length)'
  extern 'int   hid_set_nonblocking(void* dev, int nonblock)'
  extern 'int   hid_send_feature_report(void* dev, void* data, unsigned long length)'
  extern 'void  hid_close(void* dev)'

  # hid_device_info struct offsets — 64-bit macOS, hidapi 0.15.0 (verified from hidapi.h):
  #   0=path(ptr8)  8=vid(u16)  10=pid(u16)  [4 pad]  16=serial(ptr8)
  #  24=rel(u16)  [6 pad]  32=mfr(ptr8)  40=prod(ptr8)
  #  48=usage_page(u16)  50=usage(u16)  52=interface_number(i32)  56=next(ptr8)
  DeviceInfo = Struct.new(:path, :vendor_id, :product_id, :usage_page, :usage, :interface_number)

  def self.enumerate(vid, pid)
    list_head = hid_enumerate(vid, pid)
    return [] if list_head.to_i == 0

    devices = []
    node    = list_head
    until node.to_i == 0
      path_addr = node[0, 8].unpack1('Q')
      path      = path_addr == 0 ? '' : Fiddle::Pointer.new(path_addr).to_s
      devices << DeviceInfo.new(path,
        node[8,  2].unpack1('S'), node[10, 2].unpack1('S'),
        node[48, 2].unpack1('S'), node[50, 2].unpack1('S'),
        node[52, 4].unpack1('i'))
      node = Fiddle::Pointer.new(node[56, 8].unpack1('Q'))
    end
    hid_free_enumeration(list_head)
    devices
  end
end

# ---------------------------------------------------------------------------
# CoreFoundation Fiddle bindings (for CFRunLoop)
# ---------------------------------------------------------------------------
module CoreFoundation
  extend Fiddle::Importer
  dlload '/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation'

  extern 'void* CFRunLoopGetCurrent()'
  extern 'void  CFRunLoopRun()'
  extern 'void  CFRunLoopStop(void* rl)'
  extern 'void* CFMachPortCreateRunLoopSource(void* allocator, void* port, long order)'
  extern 'void  CFRunLoopAddSource(void* rl, void* source, void* mode)'
  extern 'void  CFRelease(void* obj)'
end

# kCFRunLoopCommonModes is a global CFStringRef exported from CoreFoundation.
# Look it up by symbol, then dereference to get the actual CFStringRef value.
_cf_lib = Fiddle.dlopen('/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation')
CF_COMMON_MODES = Fiddle::Pointer.new(
  Fiddle::Pointer.new(_cf_lib['kCFRunLoopCommonModes'])[0, 8].unpack1('Q')
)

# ---------------------------------------------------------------------------
# CoreGraphics Fiddle bindings (for CGEventTap)
# ---------------------------------------------------------------------------
module CoreGraphics
  extend Fiddle::Importer
  dlload '/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics'

  # CGEventTapCreate(tap, place, options, eventsOfInterest, callback, userInfo)
  extern 'void*     CGEventTapCreate(int tap, int place, int options, unsigned long long eventsOfInterest, void* callback, void* userInfo)'
  extern 'void      CGEventTapEnable(void* tap, int enable)'
  extern 'long long CGEventGetIntegerValueField(void* event, int field)'
end

# CGEventTap constants
CG_SESSION_EVENT_TAP      = 1   # kCGSessionEventTap
CG_HEAD_INSERT_EVENT_TAP  = 0   # kCGHeadInsertEventTap
CG_TAP_OPTION_LISTEN_ONLY = 1   # kCGEventTapOptionListenOnly (passive, no blocking)
CG_EVENT_KEY_DOWN         = 10  # kCGEventKeyDown
CG_KEYBOARD_EVENT_KEYCODE = 9   # kCGKeyboardEventKeycode field

# ---------------------------------------------------------------------------
# Device constants
# ---------------------------------------------------------------------------
RAZER_VID         = 0x1532
BLACKWIDOW_V2_PID = 0x0221

REPORT_SIZE = 90

# Razer device modes (feature report: class 0x00, cmd 0x04, arg[0] = mode)
DEVICE_MODE_NORMAL  = 0x00  # M-keys produce no events
DEVICE_MODE_FACTORY = 0x02  # M-keys emit F13–F17 as standard HID keycodes
DEVICE_MODE_DRIVER  = 0x03  # Proprietary reports (openrazer/Linux only)

# macOS Carbon virtual keycodes for F13–F17.
# These are what CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode)
# returns when the keyboard sends HID usage codes 0x68–0x6C in mode 0x02.
#   kVK_F13=0x69(105)  kVK_F14=0x6B(107)  kVK_F15=0x71(113)
#   kVK_F16=0x6A(106)  kVK_F17=0x40(64)
#
# NOTE: M2 and M3 have not been observed to emit F14/F15 on this firmware.
# Run --debug and press them to discover their actual virtual keycodes.
FKEY_VIRTUAL_CODES = {
  105 => :m1,   # F13  (kVK_F13)
  107 => :m2,   # F14  (kVK_F14) — may need updating
  113 => :m3,   # F15  (kVK_F15) — may need updating
  106 => :m4,   # F16  (kVK_F16)
   64 => :m5,   # F17  (kVK_F17)
}.freeze

# ---------------------------------------------------------------------------
# Macro definitions — customise as needed
# ---------------------------------------------------------------------------
MACROS = {
  # M1 → Ctrl+Option+Cmd+8  (macOS Invert Colors / Inverse Video)
  m1: -> { applescript('tell application "System Events" to key code 28 using {command down, option down, control down}') },

  # m2: -> { applescript('tell application "System Events" to keystroke "c" using {command down}') },
}.freeze

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def applescript(script)
  system('osascript', '-e', script)
end

def calculate_crc(report)
  report[2..87].reduce(0) { |crc, b| crc ^ b }
end

def build_report(transaction_id, command_class, command_id, data_size, args = [])
  report = Array.new(REPORT_SIZE, 0)
  report[0] = 0x00
  report[1] = transaction_id
  report[2] = 0x00; report[3] = 0x00; report[4] = 0x00
  report[5] = data_size
  report[6] = command_class
  report[7] = command_id
  args.each_with_index { |b, i| report[8 + i] = b }
  report[88] = calculate_crc(report)
  report[89] = 0x00
  report
end

def send_report(handle, report)
  data = ([0x00] + report).pack('C*')
  LibHIDAPI.hid_send_feature_report(handle, data, data.bytesize)
end

# Returns bytes written (> 0) on success, -1 on error.
def set_device_mode(ctrl_handle, mode)
  report = build_report(0xFF, 0x00, 0x04, 0x02, [mode, 0x00])
  result = send_report(ctrl_handle, report)
  sleep(0.05)
  result
end

# ---------------------------------------------------------------------------
# Interface selection helpers
# ---------------------------------------------------------------------------

USAGE_PAGE_NAMES = { 0x0001 => 'GenDesktop', 0x000C => 'Consumer', 0xFF00 => 'Vendor' }.freeze
USAGE_NAMES = {
  [0x0001, 0x0001] => 'Pointer',  [0x0001, 0x0002] => 'Mouse',
  [0x0001, 0x0006] => 'Keyboard', [0x0001, 0x0080] => 'SysCtrl',
  [0x000C, 0x0001] => 'Consumer',
}.freeze

def iface_label(d)
  up = USAGE_PAGE_NAMES.fetch(d.usage_page, "0x#{d.usage_page.to_s(16).upcase}")
  u  = USAGE_NAMES.fetch([d.usage_page, d.usage], "0x#{d.usage.to_s(16).upcase}")
  "IF#{d.interface_number} #{up}/#{u}"
end

# Interface 2, usage=2 (GenDesktop/Mouse): confirmed command interface for
# PID 0x0221 per razer_driver_rs. Feature reports sent here reach the
# keyboard's control endpoint (endpoint 0).
def find_ctrl_interface(all)
  all.find { |d| d.interface_number == 2 && d.usage == 2 } ||
    all.find { |d| d.interface_number == 2 } ||
    all.first
end

def open_handle!(dev_info)
  h = LibHIDAPI.hid_open_path(dev_info.path)
  abort "Could not open #{iface_label(dev_info)} at #{dev_info.path}" if h.to_i == 0
  h
end

# ---------------------------------------------------------------------------
# Inspect mode
# ---------------------------------------------------------------------------
def inspect_devices(all)
  ctrl_info = find_ctrl_interface(all)
  puts "Razer BlackWidow Chroma V2 — #{all.size} HID interface(s) via IOKit:"
  puts "(★ = command interface used for feature reports)"
  puts
  all.each do |d|
    star = (d.path == ctrl_info&.path && d.usage == ctrl_info&.usage) ? ' ★' : '  '
    puts "#{star} #{iface_label(d)}"
    puts "     #{d.path}"
    puts
  end
  puts "Ruby binary: #{RbConfig.ruby}"
  puts "Add the above to System Settings → Privacy & Security → Input Monitoring"
  puts "so CGEventTap can intercept F13-F17 keystrokes for the daemon."
end

# ---------------------------------------------------------------------------
# Sniff-all mode — set mode 0x02, poll all unique HID interfaces non-blocking
# ---------------------------------------------------------------------------

INPUT_MONITORING_HINT = <<~MSG

  NOTE: Could not open one or more keyboard HID interfaces.
  This is expected on macOS 13+. The daemon uses CGEventTap instead,
  which only needs the Ruby binary in Input Monitoring permission.

  Add to System Settings → Privacy & Security → Input Monitoring:
    #{RbConfig.ruby}

MSG

def run_sniff_all(all)
  ctrl_info   = find_ctrl_interface(all)
  ctrl_handle = LibHIDAPI.hid_open_path(ctrl_info.path)
  abort "Could not open command interface #{iface_label(ctrl_info)}." if ctrl_handle.to_i == 0

  result = set_device_mode(ctrl_handle, DEVICE_MODE_FACTORY)
  if result < 0
    warn "Warning: set_device_mode(0x02) returned #{result}."
  else
    puts "Device mode 0x02 (factory) set — M-keys should now emit F13-F17."
  end

  extra_handles = []
  pairs = all.uniq { |d| d.path }.map do |d|
    if d.path == ctrl_info.path
      [d, ctrl_handle]   # reuse — already open
    else
      h = LibHIDAPI.hid_open_path(d.path)
      if h.to_i == 0
        nil
      else
        extra_handles << h
        [d, h]
      end
    end
  end.compact

  if pairs.all? { |_, h| h.to_i == ctrl_handle.to_i }
    warn INPUT_MONITORING_HINT
    puts "Polling only #{iface_label(ctrl_info)} (events unlikely here — use daemon for real monitoring)."
  end

  puts "Polling #{pairs.size} interface(s). Press M1–M5 (Ctrl-C to stop)."
  puts
  pairs.each { |d, _| puts "  #{iface_label(d)}  (#{d.path})" }
  puts

  pairs.each { |_, h| LibHIDAPI.hid_set_nonblocking(h, 1) }
  bufs = pairs.map { Fiddle::Pointer.malloc(64) }

  loop do
    pairs.each_with_index do |(d, h), i|
      n = LibHIDAPI.hid_read(h, bufs[i], 64)
      next if n <= 0
      hex = bufs[i][0, n].bytes.map { |b| format('%02X', b) }.join(' ')
      puts "#{iface_label(d)}: #{n} bytes: [#{hex}]"
    end
    sleep(0.01)
  rescue Interrupt
    break
  end

  puts "\nDone."
ensure
  set_device_mode(ctrl_handle, DEVICE_MODE_NORMAL) rescue nil
  puts "Device mode restored to normal."
  LibHIDAPI.hid_close(ctrl_handle) rescue nil
  extra_handles.each { |h| LibHIDAPI.hid_close(h) rescue nil }
end

# ---------------------------------------------------------------------------
# Daemon — set mode 0x02 then intercept F13-F17 via CGEventTap
# ---------------------------------------------------------------------------
def run_daemon(all)
  ctrl_info   = find_ctrl_interface(all)
  ctrl_handle = open_handle!(ctrl_info)

  result = set_device_mode(ctrl_handle, DEVICE_MODE_FACTORY)
  if result < 0
    warn "Warning: set_device_mode(0x02) returned #{result}. M-keys may not respond."
  else
    puts "Device mode 0x02 (factory) set — M-keys will emit F13-F17."
  end

  debug = ARGV.include?('--debug')

  # CGEventTap callback — called on the run loop thread for every keydown event.
  # Must be stored in a global to prevent GC while the run loop is active.
  $cg_callback = Fiddle::Closure::BlockCaller.new(
    Fiddle::TYPE_VOIDP,
    [Fiddle::TYPE_VOIDP, Fiddle::TYPE_INT, Fiddle::TYPE_VOIDP, Fiddle::TYPE_VOIDP]
  ) do |_proxy, _type, event, _user_info|
    keycode = CoreGraphics.CGEventGetIntegerValueField(event, CG_KEYBOARD_EVENT_KEYCODE).to_i

    if debug
      puts "keydown virtualKeyCode=#{keycode} (0x#{keycode.to_s(16).upcase})"
    end

    key = FKEY_VIRTUAL_CODES[keycode]
    if key
      macro = MACROS[key]
      if macro
        puts "#{key.upcase} pressed — firing macro"
        macro.call
      else
        puts "#{key.upcase} pressed — no macro defined"
      end
    end

    event   # pass the event through unchanged
  end

  event_tap = CoreGraphics.CGEventTapCreate(
    CG_SESSION_EVENT_TAP,
    CG_HEAD_INSERT_EVENT_TAP,
    CG_TAP_OPTION_LISTEN_ONLY,
    (1 << CG_EVENT_KEY_DOWN),
    $cg_callback,
    nil
  )

  if event_tap.nil? || event_tap.to_i == 0
    set_device_mode(ctrl_handle, DEVICE_MODE_NORMAL) rescue nil
    LibHIDAPI.hid_close(ctrl_handle) rescue nil
    abort <<~MSG
      CGEventTapCreate failed — cannot intercept keyboard events.

      Add the Ruby binary to System Settings → Privacy & Security → Input Monitoring:
        #{RbConfig.ruby}
      Then re-run the daemon.
    MSG
  end

  run_loop = CoreFoundation.CFRunLoopGetCurrent()
  src = CoreFoundation.CFMachPortCreateRunLoopSource(nil, event_tap, 0)
  CoreFoundation.CFRunLoopAddSource(run_loop, src, CF_COMMON_MODES)
  CoreGraphics.CGEventTapEnable(event_tap, 1)

  puts "Listening for M1–M5 globally via CGEventTap. Ctrl-C to stop."
  puts

  trap(:INT) { CoreFoundation.CFRunLoopStop(run_loop) }
  CoreFoundation.CFRunLoopRun()

ensure
  set_device_mode(ctrl_handle, DEVICE_MODE_NORMAL) rescue nil
  puts "\nDevice mode restored to normal. Goodbye."
  LibHIDAPI.hid_close(ctrl_handle) rescue nil
  CoreFoundation.CFRelease(event_tap) rescue nil if event_tap && event_tap.to_i != 0
end

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if ARGV.include?('--help') || ARGV.include?('-h')
  puts <<~HELP
    Usage: ruby razer_macro_daemon.rb [OPTION]

    Options:
      --inspect    Show all HID interfaces and the command interface used.
                   Also prints the Ruby binary path to add to Input Monitoring.
      --sniff-all  Set device mode 0x02 and poll all HID interfaces.
                   Useful to confirm mode setting works.
      --debug      Run daemon and print every keydown virtual keycode received.
                   Useful for discovering M2/M3 keycodes if they differ from
                   the expected F14/F15 values.
      --help, -h   Show this help and exit.
      (none)       Run the macro daemon.

    Requirements:
      brew install hidapi
      Add Ruby binary to System Settings → Privacy & Security → Input Monitoring:
        ruby -e 'puts RbConfig.ruby'

    How it works:
      1. Sends Razer device mode 0x02 (factory) via HIDAPI to Interface 2.
         M-keys now emit F13-F17 as standard HID keycodes.
      2. Installs a passive CGEventTap to intercept F13-F17 globally and
         fire the AppleScript macros defined in MACROS.
      Safe on force-kill: keyboard stays in mode 0x02, normal typing unaffected.

    Current macro assignments:
  HELP
  FKEY_VIRTUAL_CODES.each_value.uniq.each do |key|
    puts "      #{key.upcase}#{MACROS[key] ? '' : '  (no macro defined)'}"
  end
  exit
end

all = LibHIDAPI.enumerate(RAZER_VID, BLACKWIDOW_V2_PID)
if all.empty?
  abort "Razer BlackWidow Chroma V2 not found (VID=0x#{RAZER_VID.to_s(16)} PID=0x#{BLACKWIDOW_V2_PID.to_s(16)})"
end

case
when ARGV.include?('--inspect')  then inspect_devices(all)
when ARGV.include?('--sniff-all') then run_sniff_all(all)
else run_daemon(all)
end
