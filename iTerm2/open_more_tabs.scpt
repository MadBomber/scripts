# open_more_tabs.scpt
tell application "iTerm2"
  # say "Open them your self"
  # brew install jump
  # directory jump with fuzzy match using the j bash function
  # See: ~/.bashrc__jump

  set my_jump_commands to {"echo 2", "echo 3", "j vaiu", "j vaiu", "j vaiu", "j experiments", "redis-server", "postgres"}

  repeat with my_command in my_jump_commands
    tell current window
      create tab with default profile
      tell current session of current tab
        write text my_command
      end tell
    end tell
  end repeat
end tell
