#!/usr/bin/env bash

set -euo pipefail

tmux copy-mode \; \
  send -X search-backward " " \; \
  send-key -X search-again \; \
  send-key -X cursor-down \; \
  send-key -X select-line \; \
  send -X search-forward " " \; \
  send-key -X cursor-up \; \
  send-key -X copy-pipe-and-cancel "safecopy"
sleep 0.5
~/.bin/safepaste
