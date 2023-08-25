#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${1:-}" ]]; then
  if [[ -d "${1:-}" ]]; then
    dir="$1"
    dir=${1%/}
  elif [[ ! -e "${1:-}" ]]; then
    dst="$1"
  fi
fi

tmp=$(mktemp "clipboard_to_png-XXXXXX")
osascript -e "get the clipboard as «class PNGf»" | sed "s/«data PNGf//; s/»//" | xxd -r -p > "$tmp"

if [[ -z "${dst:-}" ]]; then
  dst="${tmp}.png"
fi

if [[ -n "${dir:-}" ]]; then
  dst="$dir/${tmp}.png"
fi

mv -n "$tmp" "$dst"

if [[ -f "$tmp" ]]; then
  echo -n "$tmp"
elif [[ -f "${dst:-}" ]]; then
  echo -n "$dst"
fi
