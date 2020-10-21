#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" = "Linux" && -z "$SSH_AGENT_PID" ]]; then
  ssh_start
fi
tmux_session_auto_restore
