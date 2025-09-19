#!/usr/bin/env bash

set -euo pipefail



if [[ $# -gt 1 ]]; then
  for arg in "$@"; do
    if [[ "$arg" == "-d" ]]; then
      today=$(~/.bin/rk_today)
      args+="$today "
    else
      args+="$arg "
    fi
  done
  echo "$args" | ~/.bin/f_slug
else
  ~/.bin/f_slug
fi
