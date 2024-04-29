#!/bin/bash

set -euo pipefail

skip_system="false"
while getopts ":sh" option; do
  case "$option" in
    s)
      skip_system="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -n "${INSIDE_EMACS:-}" ]]; then
  if [ "$(uname)" = "Darwin" ] && command -v pbpaste &> /dev/null && [ "$skip_system" == "false" ]; then
    pbpaste
  else
    TERM=xterm-256color tmux saveb - &> /dev/null || cat /tmp/robenkleene.transient/clipboard 2>/dev/null
  fi
elif [[ -n "${TMUX:-}" ]]; then
  TERM=xterm-256color tmux saveb -
elif [ "$(uname)" = "Darwin" ] && command -v pbpaste &> /dev/null && [ "$skip_system" == "false" ]; then
  pbpaste
else
  cat /tmp/robenkleene.transient/clipboard 2>/dev/null || echo ''
fi
