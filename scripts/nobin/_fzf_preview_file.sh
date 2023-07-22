#!/usr/bin/env bash

set -euo pipefail

bat_param=""
verbose="false"
if [[ "$#" -gt 1 ]]; then
  bat_param=" --style=plain"
  verbose="true"
fi

for var in "$@"; do
  if [[ -f "$1" ]]; then
    bat$bat_param --color=always "$var"
  elif [[ -d "$var" ]]; then
    if [[ "$verbose" == "true" ]]; then
      echo "$var"
      echo
    fi
    ls -Cp "$var"
  fi
done
