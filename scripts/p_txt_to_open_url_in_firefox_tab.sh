#!/usr/bin/env bash

set -euo pipefail

input=$(cat)
url=$(echo "$input" | ~/.bin/f_url)
while IFS= read -r line; do
    /Applications/Firefox.app/Contents/MacOS/firefox --new-tab "$line"
done <<< "$urls"
