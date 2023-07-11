#!/usr/bin/env zsh

set -euo pipefail

if [[ "$#" -ne 1 ]]; then
  echo "Error: Missing path to binary" >&2
  exit 1
fi

entitlements='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd"\>
<plist version="1.0">
    <dict>
        <key>com.apple.security.get-task-allow</key>
        <true/>
    </dict>
</plist>'
codesign -s - -v -f --entitlements =(echo -n "$entitlements") "$1"
