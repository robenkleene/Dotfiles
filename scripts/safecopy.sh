#!/usr/bin/env bash

set -euo pipefail

skip_history="false"
while getopts ":sh" option; do
  case "$option" in
    s)
      skip_history="true"
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

if [ -n "$TMUX" ]; then
  if [[ "$skip_history" == "true" ]]; then
    sed s'/⏎$//' | tmux loadb -
  else
    sed s'/⏎$//' | tee >(~/.bin/clipboard_history_save) | tmux loadb -
  fi
elif [[ "$(uname)" == "Darwin" ]]; then
  if [[ "$skip_history" == "true" ]]; then
    pbcopy
  else
    tee >(~/.bin/clipboard_history_save) | pbcopy
  fi
else
  cat >/dev/null
fi
