#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${1:-}" ]]; then
  dst="$1"
  dir=$(dirname "$dst")
fi

tmp=$(mktemp "clipboard_to_png-XXXXXX")
osascript -e "get the clipboard as «class PNGf»" | sed "s/«data PNGf//; s/»//" | xxd -r -p > "$tmp"

if [[ -n "${dst:-}" ]]; then
  if [[ -n "${dir:-}" ]]; then
    mkdir -p "$dir"
  fi
else
  dst="${tmp}.png"
fi

mv -n "$tmp" "$dst"

if [[ -f "$tmp" ]]; then
  echo -n "$tmp"
elif [[ -f "${dst:-}" ]]; then
  echo -n "$dst"
fi
