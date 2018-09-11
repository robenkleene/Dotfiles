#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
  python -m json.tool
else
  for file in "$@"; do
    python -m json.tool "$file"
  done
fi
