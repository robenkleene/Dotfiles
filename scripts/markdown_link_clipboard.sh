#!/usr/bin/env bash

set -e

url=$(~/.bin/safepaste | ~/.bin/url_filter -b)

if [[ -z "$url" ]]; then
  echo "No URL found on the clipboard" >&2
  exit 1
fi

text="$1"
if [[ -z "$text" ]]; then
  text=$(cat)
fi

echo -n "[$text]($url)"
