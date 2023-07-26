#!/usr/bin/env bash

set -euo pipefail

input=$(cat)
urls=$(echo "$input" | ~/.bin/f_only_urls)
while IFS= read -r line; do
    /Applications/Firefox.app/Contents/MacOS/firefox --new-tab "$line"
done <<< "$urls"
echo "$input"