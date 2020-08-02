#!/bin/sh

~/.bin/urls | while read -r LINE; do
  # This doesn't work for some reasosn
  /Applications/IINA.app/Contents/MacOS/iina-cli --no-stdin "\"$LINE\""
done
