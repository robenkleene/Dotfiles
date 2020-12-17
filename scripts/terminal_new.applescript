#!/usr/bin/osascript

set thePath to do shell script "pwd"
tell application "System Events"
	if application process "Terminal" exists then
		tell application "Terminal"
			set theWindow to do script ""
			do script "cd " & quoted form of thePath in theWindow
			activate
		end tell
	else if application process "iTerm2" exists then
		tell application "iTerm"
			set theWindow to (create window with default profile)
			tell theWindow
				tell current session of theWindow
					write text "cd " & the quoted form of thePath
					activate
				end tell
			end tell
		end tell
	end if
end tell
return
