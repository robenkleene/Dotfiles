#!/usr/bin/osascript

set thePath to do shell script "pwd"
tell application "Terminal"
	set theWindow to do script ""
	do script "cd " & quoted form of thePath in theWindow
	activate
end tell
return
