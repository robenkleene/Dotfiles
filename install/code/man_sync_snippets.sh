#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

destination_dir="../man/markdown"
source_dir="~/.config/Code/User/snippets"