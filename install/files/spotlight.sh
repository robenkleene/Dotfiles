#!/usr/bin/env bash

set -euo pipefail

# 1. Ignore all /Applications folders that don't have a `.app` in them

# Also list all the excluded paths that don't exist

raw=$(sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist | sed 's/^[ \t]*//;s/[ \t]*$//' || echo "Error: This terminal probably doesn't have full disk access" >&2)

current=""
while IFS= read -r line; do
  if [[ -d "$line" && $line != "Array {" && $line != "}" ]]; then
    current="${current}$line"
  fi
done <<< "$raw"

echo "current = $current"

exit 1

sudo /usr/libexec/PlistBuddy -c "Add :Exclusions:0 string '/path/to/folder'" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist


sudo launchctl stop com.apple.metadata.mds
sudo launchctl start com.apple.metadata.mds
