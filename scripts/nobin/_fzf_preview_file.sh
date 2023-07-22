#!/usr/bin/env bash

set -euo pipefail

bat_param=" --style=plain"
verbose="false"
if [[ "$#" -gt 1 ]]; then
  bat_param=""
  verbose="true"
fi

for var in "$@"; do
  if [[ -f "$var" ]]; then
    bat$bat_param --color=always "$var"
  elif [[ -d "$var" ]]; then
    if [[ "$verbose" == "true" ]]; then
      echo "$var"
      echo
    fi
    ls -Cp "$var"
  fi
done
