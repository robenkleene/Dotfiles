#!/usr/bin/env bash

set -euo pipefail

# Use `command -v tmux &>/dev/null && tmux has-session 2>/dev/null` instead of
# `$TMUX` because for `emacsclient`, the `$TMUX` variable is recorded when the
# Emacs server was started.
# if command -v tmux &>/dev/null && tmux has-session 2>/dev/null; then
# Going back to straightfoward approach, if we need Emacs support we should add
# custom support for it separately
if [[ -n "${TMUX:-}" ]]; then
  # `-w` flag also syncs this to the system clipboard, including over SSH (with `OSC 52`)
  exec tmux loadb -w "$@" -
fi

if [[ "$(uname)" = "Darwin" && -z "${SSH_TTY:-}" ]]; then
  exec pbcopy
fi

# `{ : >/dev/tty; }` checks that a controlling terminal exists before writing `OSC 52` to it
if { : >/dev/tty; } 2>/dev/null; then
  printf '\e]52;c;%s\a' "$(base64 | tr -d '\n')" > /dev/tty
fi
