#!/usr/bin/env bash

set -eo pipefail

if [[ "$(uname)" = "Linux" && -z "$SSH_AGENT_PID" ]]; then
  eval "$(ssh-agent -s)"
  ssh-add
fi
exec ~/.bin/tmux_server_restore
