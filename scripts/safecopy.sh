#!/usr/bin/env bash

set -euo pipefail

if command -v pbcopy &> /dev/null; then
  if [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
    # Always also copy to the tmux clipboard so that pasting inside tmux with
    # `paste-buffer` works
    sed s'/⏎$//' | sed '/^\^C$/d' | tee >(pbcopy) | tmux loadb -
  else
    sed s'/⏎$//' | sed '/^\^C$/d' | pbcopy
  fi
elif [ -n "${TMUX:-}" ] && [ -z "${INSIDE_EMACS:-}" ]; then
  # Never use `TMUX` `INSIDE_EMACS` because the `TMUX` session may no longer be
  # running Don't do anything fancy with trimming new lines, otherwise that
  # makes it hard to append multiple selections that contain trailing new lines
  sed s'/⏎$//' | sed '/^\^C$/d' | tmux loadb -
else
  sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
fi
