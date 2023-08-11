#!/usr/bin/env bash

set -e

if [[ -z "${1:-}" ]]; then
  echo "Error: Replacement origin missing" >&2
  exit 1
fi

git remote rm origin
git remote add origin "$1"
