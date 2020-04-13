#!/usr/bin/env bash

set -e
file=$(~/.bin/fzf_documentation_less -p "$@")
eval "open \"$file\""
