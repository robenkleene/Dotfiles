#!/usr/bin/env bash

set -euo pipefail

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
elif command -v pbcopy &> /dev/null; then
  sed s'/⏎$//' | sed '/^\^c$/d' | pbcopy
else
  sed s'/⏎$//' | sed '/^\^C$/d' > /tmp/robenkleene.transient/clipboard
fi
