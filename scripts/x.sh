#!/usr/bin/env bash

set -euo pipefail

exec tmux attach \; run-shell 'tmux_shell_new'
