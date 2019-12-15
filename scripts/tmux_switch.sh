#!/usr/bin/env bash

set -e

tmux list-sessions -F "#S" | fzf-tmux | tr "\n" "\0" | xargs -0 tmux switch-client -t
