#!/usr/bin/env bash

set -e

if [[ $# -eq 0 ]]; then
  code -n .
else
  code -n "$@"
fi
