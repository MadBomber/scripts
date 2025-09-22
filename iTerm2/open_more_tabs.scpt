# open_more_tabs.scpt

tell application "iTerm2"
  # say "Open them your self"
  # brew install jump
  # directory jump with fuzzy match using the j bash function
  # See: ~/.bashrc__jump

  # Read the current project from ~/.current_project
  set current_project_file to (POSIX path of (path to home folder)) & ".current_project"
  set current_project to do shell script "cat " & quoted form of current_project_file & " | tr -d '\\n'"

  set my_jump_commands to {"echo 2", "echo 3", "j " & current_project, "j " & current_project, "j " & current_project, "j experiments", "redis-server", "postgres"}

  repeat with my_command in my_jump_commands
    tell current window
      create tab with default profile
      tell current session of current tab
        write text my_command
      end tell
    end tell
  end repeat
end tell
