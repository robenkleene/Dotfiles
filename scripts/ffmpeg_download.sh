#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
  echo "No URL specified"
  exit 1
fi

cd ~/Downloads/
# Hack to get a temp path by making file with an extension and then deleting it
filename=$(mktemp "ffmpeg-XXXX")
filename_ext=${filename}.mp4
mv -n "$filename" "$filename_ext"
rm "$filename_ext"

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -c copy "$filename_ext"
