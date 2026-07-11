try
	body()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

on body()
	tell application "Finder"
		set currentDate to do shell script "date '+%Y-%m-%d'"
		if exists Finder window 1 then
			set targetFolder to target of Finder window 1
		else
			set targetFolder to desktop
		end if
		set folderName to currentDate
		if exists (folder folderName of targetFolder) then
			repeat with i from 2 to 9
				set candidateName to currentDate & " " & i
				if not (exists (folder candidateName of targetFolder)) then
					set folderName to candidateName
					exit repeat
				end if
			end repeat
		end if
		set newFolder to make new folder at targetFolder with properties {name:folderName}
		reveal newFolder
		activate
	end tell
end body
