#!/bin/bash

if [[ -n "$1" ]]; then
  while read -r LINE; do
    open -a "$1" "$LINE"
  done
else
  while read -r LINE; do
    open "$LINE"
  done
fi
# The default browser method

# The Safari method
# THEURLS="{"
# while read LINE; do
#   THEURLS=$THEURLS"\""${LINE}"\", "
# done
# THEURLS=${THEURLS%??}
# THEURLS=$THEURLS"}"

# if [[ "$THEURLS" == "{}" ]]; then
#   echo "No urls"
#   exit 1
# fi

# osascript <<-APPLESCRIPT
# set URLs to $THEURLS
# tell application "Safari"
# 	activate
# 	make new document with properties {URL:item 1 of URLs}
# 	tell window 1
# 		repeat with theURL in rest of the URLs
# 			make new tab with properties {URL:theURL}
# 		end repeat
# 	end tell
# end tell
# APPLESCRIPT
