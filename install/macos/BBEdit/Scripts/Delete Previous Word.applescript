tell application "BBEdit"
	set theResult to find "\\s[^\\s]+" searching in text of front text window options {search mode:grep, backwards:true, extend selection:false}
	cut {found object of theResult}
end tell