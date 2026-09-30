#!/usr/bin/env bash

set -euo pipefail

# Reset every option and key binding to the `tmux` defaults, so re-sourcing
# `tmux.conf` doesn't leave behind stale settings. The defaults are dumped from
# a config-less server (`-f /dev/null`) on a separate socket (`-L`), which exits
# on its own because it has no sessions.
socket="rk-tmux-init-rst-$$"
{
  # `awk` strips array indexes (e.g., `status-format[0]`) and skips user `@`
  # options. It also skips `default-shell`, because its default comes from
  # `$SHELL` at server start, so `set-option -ug default-shell` would change it
  # to `/bin/sh`.
  tmux -L "$socket" -f /dev/null start-server \; show-options -s \; show-options -g \; show-options -gw |
    awk '{ sub(/\[.*/, "", $1) } $1 !~ /^(@|default-shell$)/ && !seen[$1]++ { print "set-option -ug " $1 }'
  # `unbind-key -a -T` clears each table first because `bind-key` never removes
  # custom bindings, and `unbind-key -a` without `-T` only clears `prefix`.
  printf 'unbind-key -a -T %s\n' prefix root copy-mode copy-mode-vi
  tmux -L "$socket" -f /dev/null start-server \; list-keys
} | tmux source-file -
rm -f "${TMUX_TMPDIR:-/tmp}/tmux-$(id -u)/$socket"
