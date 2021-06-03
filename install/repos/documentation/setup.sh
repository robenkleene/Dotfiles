#!/usr/bin/env bash

set -e

force_string=""
use_https="false"
while getopts ":fHh" option; do
  case "$option" in
    H)
      use_https="true"
      ;;
    f)
      force_string="run"
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

mkdir -p ~/Documentation/

cd "$(dirname "$0")" || exit 1
if [[ "$use_https" == "true" ]]; then
  ~/.bin/git_sync_clone ~/Documentation/ <(~/.bin/git_swap_format -H < documentation.txt) "$force_string"
else
  ~/.bin/git_sync_clone ~/Documentation/ documentation.txt "$force_string"
fi
