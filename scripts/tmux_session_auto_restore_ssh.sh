#!/usr/bin/env bash

set -eo pipefail

if [[ "$(uname)" = "Linux" && -z "$SSH_AGENT_PID" ]]; then
  eval "$(ssh-agent -s)"
  ssh-add
fi
tmux_session_auto_restore
