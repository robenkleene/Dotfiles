#!/usr/bin/env bash

set -euo pipefail

# The daily command should always open todays daily file. This is because:
# 1. It's easy for apps to implement, they just have to get the date and open a
# file path based on it.
# 2. Once the path for today is open, it's easy to get to the previous days
# file, since you're already at the correct directory.

path="false"
while getopts ":ph" option; do
  case "$option" in
    p)
      path="true"
      ;;
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

if [[ "$path" == "true" ]]; then
  ~/.bin/daily_file
else
  command="${MD_EDITOR_COMMAND:-${EDITOR:=vim}}"
  exec $command "$(~/.bin/daily_file)"
fi

