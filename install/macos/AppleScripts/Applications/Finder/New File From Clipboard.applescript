try
	newFileFromClipboard()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

-- Returns `{dataClass, extension}` for the best type on the clipboard, preferring images over text
on clipboardType()
	set theClasses to {}
	repeat with theEntry in (clipboard info)
		set end of theClasses to item 1 of theEntry
	end repeat
	repeat with theCandidate in {{«class PNGf», "png"}, {JPEG picture, "jpg"}, {TIFF picture, "tiff"}, {GIF picture, "gif"}, {«class utf8», "txt"}}
		if theClasses contains {item 1 of theCandidate} then return contents of theCandidate
	end repeat
	error "No image or text on the clipboard"
end clipboardType

on fileExists(thePath)
	try
		POSIX file thePath as alias
		return true
	on error
		return false
	end try
end fileExists

-- Returns `<folder>/Clipboard.<extension>`, or `Clipboard 2.<extension>` etc. if that's taken
on uniquePath(theFolderPath, theExtension)
	set thePath to theFolderPath & "Clipboard." & theExtension
	set i to 2
	repeat while fileExists(thePath)
		set thePath to theFolderPath & "Clipboard " & i & "." & theExtension
		set i to i + 1
	end repeat
	return thePath
end uniquePath

on newFileFromClipboard()
	set {theClass, theExtension} to clipboardType()

	tell application "Finder"
		try
			set theFolder to (target of front window) as alias
		on error
			set theFolder to path to desktop folder as alias
		end try
	end tell

	set thePath to uniquePath(POSIX path of theFolder, theExtension)
	set theFile to open for access (POSIX file thePath) with write permission
	try
		if theClass is «class utf8» then
			write (the clipboard as text) to theFile as «class utf8»
		else
			write (the clipboard as theClass) to theFile
		end if
	on error errMsg number errNum
		close access theFile
		error errMsg number errNum
	end try
	close access theFile

	tell application "Finder" to select (POSIX file thePath as alias)
end newFileFromClipboard
