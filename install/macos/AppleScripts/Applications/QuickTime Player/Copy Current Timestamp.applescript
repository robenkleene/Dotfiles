try
	copyCurrentTimestamp()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

on zeroPad(theNumber, theWidth)
	set theText to theNumber as integer as string
	repeat while length of theText < theWidth
		set theText to "0" & theText
	end repeat
	return theText
end zeroPad

-- Formats seconds as `HH:MM:SS.mmm`
on formatTimestamp(theSeconds)
	set totalMilliseconds to round (theSeconds * 1000) rounding as taught in school
	set theMilliseconds to totalMilliseconds mod 1000
	set totalSeconds to totalMilliseconds div 1000
	set theHours to totalSeconds div 3600
	set theMinutes to (totalSeconds mod 3600) div 60
	set theSeconds to totalSeconds mod 60
	return zeroPad(theHours, 2) & ":" & zeroPad(theMinutes, 2) & ":" & ¬
		zeroPad(theSeconds, 2) & "." & zeroPad(theMilliseconds, 3)
end formatTimestamp

on copyCurrentTimestamp()
	tell application "QuickTime Player"
		set theTime to current time of front document
	end tell
	set the clipboard to formatTimestamp(theTime)
end copyCurrentTimestamp
