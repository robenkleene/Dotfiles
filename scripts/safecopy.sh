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

# Fish adds `⏎` and zsh adds `%` to the end of output
# `^C` is the character to terminate a command
# We don't do this now for simplicity, but here's how you'd strip those:
# sed s'/⏎$//'
# sed '/^\^C$/d'

# Can't depend on `TMUX` running when `INSIDE_EMACS` is set because that
# variable is recorded when the emacs server was started
if [[ -n "${INSIDE_EMACS:-}" ]]; then
  if [ "$(uname)" = "Darwin" ] && command -v pbcopy &> /dev/null && [ "$skip_system" == "false" ]; then
    tee >(pbcopy) | tmux loadb - || cat > /tmp/robenkleene.transient/clipboard
  else
    tmux loadb - || cat > /tmp/robenkleene.transient/clipboard
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
  if [[ ! -e /tmp/robenkleene.transient/clipboard ]]; then
    if [[ ! -e /tmp/robenkleene.transient/ ]]; then
      mkdir -p /tmp/robenkleene.transient/
    fi
    touch /tmp/robenkleene.transient/clipboard
  fi
  cat > /tmp/robenkleene.transient/clipboard
fi

