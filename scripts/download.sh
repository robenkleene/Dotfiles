#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Too many arguments" >&2
    exit 1
fi
cd ~/Downloads/
curl --remote-name --location "$1"
