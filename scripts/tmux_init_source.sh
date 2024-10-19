#!/usr/bin/env bash

set -euo pipefail

# ~/.bin/tmux_init_reset &> /dev/null
tmux source-file ~/.config/tmux/tmux.conf
