#!/usr/bin/env bash

for file in "$@"; do
  python -m json.tool "$file"
done
