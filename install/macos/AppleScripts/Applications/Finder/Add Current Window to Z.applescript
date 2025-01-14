try
	zAdd()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

on zAdd()
	tell application "Finder"
		try
			set the theFolder to (folder of the front window) as alias
			set theUnixPath to POSIX path of theFolder
			do shell script "~/.brew/bin/zoxide add -- " & the quoted form of theUnixPath
		end try
	end tell
end zAdd
