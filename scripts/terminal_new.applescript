#!/usr/bin/osascript

set thePath to do shell script "pwd"
tell application "System Events"
	if application process "iTerm2" exists then
		tell application "iTerm"
			set theWindow to (create window with default profile)
			tell theWindow
				delay 0.5 -- Delay because of a bug, try removing later
				tell current session of theWindow
					write text "cd " & the quoted form of thePath
					activate
				end tell
			end tell
		end tell
	else
		tell application "Terminal"
			set theWindow to do script ""
			do script "cd " & quoted form of thePath in theWindow
			activate
		end tell
	end if
end tell
return
