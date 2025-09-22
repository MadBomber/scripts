#!/usr/bin/osascript

on run argv
  if (count of argv) < 1 then
    error "Usage: new_project.scpt <project_name>"
  end if

  set project_name to item 1 of argv

  -- Write project name to ~/.current_project
  set home_path to system attribute "HOME"
  set file_path to home_path & "/.current_project"

  try
    set file_ref to open for access POSIX file file_path with write permission
    set eof of file_ref to 0
    write project_name to file_ref
    close access file_ref
  on error
    try
      close access POSIX file file_path
    end try
  end try

  tell application "iTerm2"
    tell current window
      repeat with tab_number from 4 to 6
        if (count of tabs) ≥ tab_number then
          tell tab tab_number
            select
            tell current session
              write text "j " & project_name
            end tell
          end tell
        end if
      end repeat
    end tell
  end tell
end run
