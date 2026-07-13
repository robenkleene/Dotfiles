#!/usr/bin/env bash

set -euo pipefail

# This is safer but sometimes fails, probably a better practice to just connect
# to Emacs and run `save-buffers-kill-emacs` there
# emacsclient -e '(save-buffers-kill-emacs t)'
emacsclient -e '(kill-emacs)'
