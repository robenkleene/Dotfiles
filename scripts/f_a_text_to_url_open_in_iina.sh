#!/bin/sh

~/.bin/f_text_to_url | while read -r LINE; do
  # This doesn't work for some reasosn
  /Applications/IINA.app/Contents/MacOS/iina-cli --no-stdin "\"$LINE\""
done
