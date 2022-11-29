#!/usr/bin/env bash

set -euo pipefail

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
  exec $VIM_COMMAND "$(~/.bin/daily_file)"
fi

