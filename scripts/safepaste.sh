#!/bin/bash

set -euo pipefail

while getopts ":r:h" option; do
  case "$option" in
    r)
      register="$OPTARG"
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

register_parameter=""
if [[ -n "${register-}" ]]; then
  register_parameter=" -b ${register} "
fi

if [[ "$(uname)" == "Darwin" ]]; then
  pbpaste
elif [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
  TERM=xterm-256color tmux saveb"${register_parameter}" -
else
  cat /tmp/robenkleene.transient/clipboard 2>/dev/null || echo ''
fi
