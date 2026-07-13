#!/usr/bin/env bash

set -euo pipefail

~/.bin/tmux-init-rst
tmux source-file ~/.config/tmux/tmux.conf
