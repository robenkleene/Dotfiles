#!/usr/bin/env bash

set -euo pipefail

# Can't depend on `TMUX` running when `INSIDE_EMACS` is set because that
# variable is recorded when the emacs server was started
if command -v pbcopy &> /dev/null; then
  if [[ -n "${INSIDE_EMACS:-}" ]]; then
    { sed s'/⏎$//' | sed '/^\^C$/d' | tee >(pbcopy) | tmux loadb - ; } || sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
  elif [[ -n "${TMUX:-}" ]]; then
    # Always also copy to the tmux clipboard so that pasting inside tmux with
    # `paste-buffer` works
    sed s'/⏎$//' | sed '/^\^C$/d' | tee >(pbcopy) | tmux loadb -
  else
    sed s'/⏎$//' | sed '/^\^C$/d' | pbcopy
  fi
elif [[ -n "${INSIDE_EMACS:-}" ]]; then
  { sed s'/⏎$//' | sed '/^\^C$/d' | tmux loadb - ; } || sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
elif [[ -n "${TMUX:-}" ]]; then
  sed s'/⏎$//' | sed '/^\^C$/d' | tmux loadb -
else
  sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
fi
