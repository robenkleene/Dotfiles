#!/usr/bin/env bash

set -euo pipefail

input=$(cat)
urls=$(echo "$input" | ~/.bin/f_o_urls)
while IFS= read -r line; do
    /Applications/Firefox.app/Contents/MacOS/firefox --new-tab "$line"
done <<< "$urls"
