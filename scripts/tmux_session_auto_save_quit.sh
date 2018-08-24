#!/usr/bin/env bash

tmux run-shell '~/.tmux/plugins/tmux-resurrect/scripts/save.sh'
tmux kill-server
