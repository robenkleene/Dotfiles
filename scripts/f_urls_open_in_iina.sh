#!/bin/sh

~/.bin/f_to_urls | while read -r LINE; do
  # This doesn't work for some reasosn
  /Applications/IINA.app/Contents/MacOS/iina-cli --no-stdin "\"$LINE\""
done
