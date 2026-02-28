try
	copyUnixPaths()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

on replaceText(theText, searchString, replacementString)
	set AppleScript's text item delimiters to searchString
	set theItems to every text item of theText
	set AppleScript's text item delimiters to replacementString
	set theText to theItems as text
	set AppleScript's text item delimiters to ""
	return theText
end replaceText

on toUnixPath(theAlias)
	set thePath to POSIX path of theAlias
	set homePath to POSIX path of (path to home folder)
	if thePath starts with homePath then
		set thePath to "~/" & text ((length of homePath) + 1) thru -1 of thePath
	end if
	set thePath to replaceText(thePath, " ", "\\ ")
	return thePath
end toUnixPath

on copyUnixPaths()
	tell application "Finder"
		set theSelection to get selection as alias list
		set thePaths to ""
		if theSelection is {} then
			set thePaths to my toUnixPath(target of front window as alias)
		else
			repeat with theAlias in theSelection
				set thePath to my toUnixPath(theAlias)
				if thePaths as string is equal to "" then
					set thePaths to thePath
				else
					set thePaths to thePaths & "
" & thePath
				end if
			end repeat
		end if
		set the clipboard to thePaths
	end tell
end copyUnixPaths
