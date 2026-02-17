#!/usr/bin/env bash

set -euo pipefail

file="$1"
mkdir -p "${file%/*}" && touch "$file"
