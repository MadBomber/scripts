#!/usr/bin/osascript

on run argv
  if (count of argv) < 1 then
    error "Usage: new_project.scpt <project_name>"
  end if

  set project_name to item 1 of argv

  tell application "iTerm2"
    tell current window
      repeat with tab_number from 3 to 5
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