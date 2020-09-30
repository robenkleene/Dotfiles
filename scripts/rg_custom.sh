#!/usr/bin/env bash

set -e

# Only use colors in an interactive shell
if [ -t 1 ]; then
    exec rg --with-filename --smart-case --line-number --colors 'match:fg:black' --colors 'match:bg:cyan' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@" | less -RFX
else
    exec rg --with-filename --smart-case --line-number "$@"
fi
