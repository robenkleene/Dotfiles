#!/usr/bin/env bash

set -euo pipefail

~/.bin/tmux_ini_rst
tmux source-file ~/.config/tmux/tmux.conf
