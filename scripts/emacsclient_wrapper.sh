#!/usr/bin/env bash

set -euo pipefail

# This script is necessary in order to force opening `emacsclient` without
# specifying a file to use the current directory as the root
if [[ -n "${1-}" ]]; then
  # --eval "(setenv \"PWD\" \"$PWD\")" to set the working directory doesn't work
  # --because `--eval` can't be combined with opening files
  # This also probably wouldn't be ideal because the `PWD` environment variable
  # is scoped to multiple `emacsclient`
  exec emacsclient -nw "$@"
else
  exec emacsclient -nw .
  # exec emacsclient -nw --eval "(cd \"$PWD\")"
  # exec emacsclient -nw . --eval "(switch-to-buffer \"*scratch*\")"
fi
