#!/usr/bin/env bash

set -euo pipefail

stored=""
while read -r line; do
  if [[ -z $line ]]; then
    continue
  fi
  if [[ $line =~ ^LOCATION:[[:space:]]([0-9]+) ]]; then
    printf '`'
    echo -n "${BASH_REMATCH[1]}"
    printf '`:'
    echo
    echo
    echo "> ${stored}"
    echo
    stored=""
  elif [[ -n $stored ]]; then
    echo "# *${stored}* by ${line}"
    echo
    stored=""
  else
    stored+=$line
  fi
done <"${1:-/dev/stdin}"
