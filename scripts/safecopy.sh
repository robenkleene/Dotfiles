#!/usr/bin/env bash

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

# Can't depend on `TMUX` running when `INSIDE_EMACS` is set because that
# variable is recorded when the emacs server was started
if [[ -n "${INSIDE_EMACS:-}" ]]; then
  if command -v pbcopy &> /dev/null; then
    { sed s'/⏎$//' | sed '/^\^C$/d' | tee >(pbcopy) | tmux loadb - ; } || sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
  else
    { sed s'/⏎$//' | sed '/^\^C$/d' | tmux loadb - ; } || sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
  fi
elif [[ -n "${TMUX:-}" ]]; then
  sed s'/⏎$//' | sed '/^\^C$/d' | tmux loadb -
  if [[ "$skip_system" == "false" ]]; then
    if command -v pbcopy &> /dev/null; then
      TERM=xterm-256color tmux saveb - | sed s'/⏎$//' | sed '/^\^c$/d' | pbcopy
    fi
  fi
elif command -v pbcopy &> /dev/null; then
  if [[ "$skip_system" == "false" ]]; then
    sed s'/⏎$//' | sed '/^\^c$/d' | pbcopy
  fi
else
  sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
fi

