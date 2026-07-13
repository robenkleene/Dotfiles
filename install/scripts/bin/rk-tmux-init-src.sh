#!/usr/bin/env bash

set -euo pipefail

~/.bin/rk-tmux-init-rst
tmux source-file ~/.config/tmux/tmux.conf
