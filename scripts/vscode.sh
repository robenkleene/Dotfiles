#!/usr/bin/env bash

set -e

cmd="code"
if pgrep "^Code\ -\ Insider" >/dev/null; then
  cmd="code-insiders"
fi

if [[ $# -eq 0 ]]; then
  exec $cmd -n .
else
  exec $cmd -n "$@"
fi
