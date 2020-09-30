#!/usr/bin/env bash

set -e

if [[ -n "$1" ]]; then
  exec $ACK_COMMAND "$@" | $VIM_COMMAND -c "GrepBuffer" -
else
  exec $VIM_COMMAND -c "GrepBuffer" -
fi
