#!/usr/bin/env bash

set -euo pipefail

if [[ $1 =~ ^\+[0-9]+$ ]]; then
  echo hx $2:${1#"+"}
else
  exec hx "$@"
fi
