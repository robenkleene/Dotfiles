#!/usr/bin/env bash

set -e

if [[ $# -eq 0 ]]; then
  code-insiders -n .
else
  code-insiders -n "$@"
fi
