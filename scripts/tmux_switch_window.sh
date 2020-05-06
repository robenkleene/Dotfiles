#!/usr/bin/env bash

set -e

tmux list-windows -F "#W" | fzf-tmux | tr "\n" "\0" | xargs -0 tmux select-window -t
