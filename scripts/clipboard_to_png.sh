#!/usr/bin/env bash

set -euo pipefail

tmp=$(mktemp "clipboard_to_png-XXXXXX")
osascript -e "get the clipboard as «class PNGf»" | sed "s/«data PNGf//; s/»//" | xxd -r -p > "$tmp"
dst="${tmp}.png"
mv -n "$tmp" "$dst"
if [[ -f "$tmp" ]]; then
  echo -n "$tmp"
else
  echo -n "$dst"
fi
