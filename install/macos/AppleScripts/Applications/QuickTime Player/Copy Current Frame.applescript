try
	copyCurrentFrame()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

-- QuickTime Player's dictionary doesn't expose the frame rate, so measure the
-- frame duration by stepping one frame away and back. This replaces reading
-- the frame rate with AVFoundation, which took about a second to load.
on copyCurrentFrame()
	tell application "QuickTime Player"
		set theDocument to front document
		set wasPlaying to playing of theDocument
		if wasPlaying then pause theDocument
		set theStartTime to current time of theDocument
		-- Step away and back so both times land on frame boundaries, even if the
		-- playhead was left between frames
		step forward theDocument
		set theNextTime to current time of theDocument
		if theNextTime is greater than theStartTime then
			step backward theDocument
			set theFrameTime to current time of theDocument
			set theFrameDuration to theNextTime - theFrameTime
		else
			-- On the last frame stepping forward doesn't move, so measure the
			-- previous frame instead
			step backward theDocument
			set thePreviousTime to current time of theDocument
			step forward theDocument
			set theFrameTime to current time of theDocument
			set theFrameDuration to theFrameTime - thePreviousTime
		end if
		if wasPlaying then play theDocument
	end tell
	if theFrameDuration is not greater than 0 then
		error "Couldn't measure the frame duration"
	end if
	-- Round instead of truncate because the time is a float, so a time exactly
	-- on a frame boundary can land slightly before it
	set theFrame to round (theFrameTime / theFrameDuration) rounding as taught in school
	set the clipboard to theFrame as integer as string
end copyCurrentFrame
