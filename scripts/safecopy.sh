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
if [[ ! -e /tmp/robenkleene.transient/clipboard ]]; then
  if [[ ! -e /tmp/robenkleene.transient/ ]]; then
    mkdir -p /tmp/robenkleene.transient/
  fi
  touch /tmp/robenkleene.transient/clipboard
fi

if [[ -n "${INSIDE_EMACS:-}" ]]; then
  if [ "$(uname)" = "Darwin" ] && command -v pbcopy &> /dev/null && [ "$skip_system" == "false" ]; then
    tee >(pbcopy) | tee >(tmux loadb -) | cat > /tmp/robenkleene.transient/clipboard
  else
    # Have to pipe to both `tmux loadb -` and clipboard file because `tmux loadb
    # -` will succeed if tmux is running even if not currently attached to a
    # session
    tee >(tmux loadb -) | cat > /tmp/robenkleene.transient/clipboard
  fi
elif [[ -n "${TMUX:-}" ]]; then
  tmux loadb -
  if [[ "$skip_system" == "false" ]]; then
    if [ "$(uname)" = "Darwin" ] && command -v pbcopy &> /dev/null; then
      TERM=xterm-256color tmux saveb - | pbcopy
    fi
  fi
elif [ "$(uname)" = "Darwin" ] && command -v pbcopy &> /dev/null && [ "$skip_system" == "false" ]; then
  pbcopy
else
  cat > /tmp/robenkleene.transient/clipboard
fi
