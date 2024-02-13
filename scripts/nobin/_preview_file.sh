#!/usr/bin/env bash

set -euo pipefail

# bat_param=" --style=plain"
verbose="false"
if [[ "$#" -gt 1 ]]; then
  # Never paginate for multiple files so they can all be dumped to the terminal
  # bat_param=" --paging=never"
  verbose="true"
fi

for var in "$@"; do
  if [[ -f "$var" ]]; then
    cat "$var"
    # bat$bat_param --color=always "$var"
  elif [[ -d "$var" ]]; then
    if [[ "$verbose" == "true" ]]; then
      echo "$var"
      echo
    fi
    ls -Cp "$var"
  fi
done
