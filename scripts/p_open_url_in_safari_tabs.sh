#!/usr/bin/env bash

set -euo pipefail

urls="{"
while read -r line; do
  urls=$urls\"${line}\", 
done <<< "$(~/.bin/f_url)"

urls=${urls%??}
urls=$urls\"}

if [[ "$urls" == "{}" ]]; then
  echo "No urls"
  exit 1
fi

osascript <<-APPLESCRIPT
set URLs to $urls
tell application "Safari"
	activate
	make new document with properties {URL:item 1 of URLs}
	tell window 1
		repeat with theURL in rest of the URLs
			make new tab with properties {URL:theURL}
		end repeat
	end tell
end tell
APPLESCRIPT
