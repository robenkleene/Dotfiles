try
	makeNewFile()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

on makeNewFile()
	tell application "Finder"
		try
			set the theFolder to (folder of the front window) as alias
		on error
			set the theFolder to path to desktop folder as alias
		end try

		set theUnixPath to POSIX path of theFolder
		set theNewFilePath to do shell script "
cd " & quoted form of theUnixPath & "
BASENAME=untitled
FILENAME=
for i in $(seq 1 9); do
  if [ $i -eq 1 ]; then
    F=$BASENAME
  else
    F=\"$BASENAME $i\"
  fi
  if [ ! -f \"$F\" ]; then
    FILENAME=$F
    break
  fi
done
if [ -z \"$FILENAME\" ]; then
  echo 'Failed to create a new file because there are too many untitled files' >&2
  exit 1
fi
touch \"$FILENAME\"
echo \"$(pwd)/$FILENAME\"
"

		set theNewFilePath to POSIX file theNewFilePath as string
		reveal theNewFilePath
	end tell
end makeNewFile
