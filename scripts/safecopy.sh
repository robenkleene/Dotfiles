#!/usr/bin/env bash

set -euo pipefail

while getopts ":sh" option; do
  case "$option" in
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done


# macOS has to go first to be able to copy from tmux to macOS
if [[ "$(uname)" == "Darwin" ]]; then
  exec pbcopy
elif [ -n "${TMUX:-}" ]; then
  exec sed s'/⏎$//' | tmux loadb -
else
  exec cat >/dev/null
fi
