#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") [-H] [<path>...]"
  echo ""
  echo "Copies the absolute <path>s, or STDIN if there are none."
  echo ""
  echo "Options:"
  echo "  -H  Copy in host format (<host>:<path>), for \`ssh\`, \`scp\`, etc."
  echo "  -h  Help"
}

host=false

while getopts "Hh" option; do
  case "$option" in
    H)
      host=true
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      usage >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND - 1))

if [[ $host == true ]]; then
  # Default to the current directory, since host format only makes sense for
  # paths
  [[ $# -gt 0 ]] || set -- "$PWD"
  # `realpath` instead of `rk-path-abs` because `~` would expand to the remote
  # home directory, and `s| |\\\\ |g` escapes spaces with backslashes for
  # shell-safe paths
  path=$(realpath "$@" | sed "s|^|$(hostname):|; s| |\\\\ |g")
elif [[ $# -gt 0 ]]; then
  # `$(...)` strips `rk-path-abs`'s trailing newline so it isn't copied
  path=$(~/.bin/rk-path-abs "$@")
else
  exec ~/.bin/nobin/_rk-tmux-safecopy.sh
fi

printf '%s' "$path" | ~/.bin/nobin/_rk-tmux-safecopy.sh
# Print the copied path as feedback
printf '%s\n' "$path"
