try
	copyReminders()
on error errMsg number errNum
	if errNum is not equal to -128 then
		activate -- This prevents a beep when scripts are run from LaunchBar but it also makes the script run slower from the Script Menu
		display dialog "AppleScript encountered an error." & ¬
			" Error Message: " & errMsg & " Number " & errNum
	end if
end try

on copyReminders()
	tell application "Reminders"
		set currentList to front list
		if currentList is missing value then
			return
		end if
		set selectedReminders to (reminders of currentList whose completed is false)
		repeat with task in selectedReminders
			set reminderName to name of task
			set reminderDueDate to due date of task
			tell application "OmniFocus"
				tell default document
					set newTask to make new inbox task with properties {name:reminderName}
					if reminderDueDate is not missing value then
						set due date of newTask to reminderDueDate
					end if
				end tell
			end tell
		end repeat
	end tell
end copyReminders
