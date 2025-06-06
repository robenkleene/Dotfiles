tell application "BBEdit"
	find "\\s+[\\S]*$" searching in text of front text window options {search mode:grep, backwards:true}
	cut {found object of result}
	-- select insertion point before (first character of found object of result)
end tell