use AppleScript version "2.4"
use framework "Foundation"
use framework "AVFoundation"
use scripting additions

try
	copyCurrentFrame()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

-- QuickTime Player's dictionary doesn't expose the frame rate, so read it from
-- the file's video track with AVFoundation
on frameRateOfFile(thePath)
	set theURL to current application's NSURL's fileURLWithPath:thePath
	set theAsset to current application's AVURLAsset's URLAssetWithURL:theURL options:(missing value)
	set theTracks to theAsset's tracksWithMediaType:(current application's AVMediaTypeVideo)
	if (count of theTracks) is 0 then
		error "No video track found in " & thePath
	end if
	return (item 1 of theTracks)'s nominalFrameRate() as real
end frameRateOfFile

on copyCurrentFrame()
	tell application "QuickTime Player"
		set theDocument to front document
		set theTime to current time of theDocument
		set thePath to POSIX path of (file of theDocument as alias)
	end tell
	set theFrameRate to frameRateOfFile(thePath)
	-- Round instead of truncate because the time is a float, so a time exactly
	-- on a frame boundary can land slightly before it
	set theFrame to round (theTime * theFrameRate) rounding as taught in school
	set the clipboard to theFrame as integer as string
end copyCurrentFrame
