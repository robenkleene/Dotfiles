#!/usr/bin/env bash

set -e

if [[ ${#1} -gt 1 ]] || [[ $# -gt 1 ]]; then
  exec rg --no-heading --with-filename --smart-case --line-number --colors 'match:fg:white' --colors 'match:bg:91' --colors 'path:fg:cyan' --colors 'line:fg:white' --pretty -- "$@"
fi
