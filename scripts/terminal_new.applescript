#!/usr/bin/osascript

set thePath to do shell script "pwd"
# tell application "Terminal"
# 	set theWindow to do script ""
# 	do script "cd " & the quoted form of thePath in theWindow
# 	activate
# end tell
tell application "iTerm"
	set theWindow to (create window with default profile)
	tell theWindow
		tell current session of theWindow
			write text "cd " & the quoted form of thePath
			activate
		end tell
	end tell
end tell
return
