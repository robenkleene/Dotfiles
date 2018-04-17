#!/usr/bin/osascript

set thePath to do shell script "pwd"
set theAlias to POSIX file thePath as alias
tell application "Finder"
	activate
	make new Finder window to theAlias
end tell
return