#!/usr/bin/env bash

set -e

rg() {
    if [ -t 1 ]; then
        command rg --with-filename --smart-case --line-number --colors 'match:fg:black' --colors 'match:bg:cyan' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$@" | less -RFX
    else
        command rg --with-filename --smart-case --line-number "$@"
    fi
}

rg "$@" ~/Text ~/Documents/Text/Notes ~/Documentation
