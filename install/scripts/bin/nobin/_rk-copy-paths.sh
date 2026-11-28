#!/usr/bin/env bash

set -euo pipefail

# Copy each file's path, host and path (`<host>:<path>`), directory, filename,
# or filename without extension to the clipboard (one per line) with
# `_rk-tmux-safecopy.sh`.
#
# Usage: _rk-copy-paths.sh <path|host|dirname|filename|name_without_ext> <file>...

mode="$1"
shift

separator=""
for file in "$@"; do
  case "$mode" in
    path) text="$file" ;;
    # Escape spaces with backslashes so the result is shell-safe for `ssh`,
    # `scp`, etc.
    host) text="$(hostname):${file// /\\ }" ;;
    dirname) text="$(dirname -- "$file")" ;;
    filename) text="${file##*/}" ;;
    name_without_ext)
      text="${file##*/}"
      # Keep dotfiles without another extension (e.g., `.bashrc`) whole
      case "$text" in
        ?*.*) text="${text%.*}" ;;
      esac
      ;;
    *)
      echo "Unknown mode: $mode" >&2
      exit 1
      ;;
  esac
  printf '%s%s' "$separator" "$text"
  separator=$'\n'
done | ~/.bin/nobin/_rk-tmux-safecopy.sh
