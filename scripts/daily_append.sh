#!/usr/bin/env bash

set -euo pipefail

file_path=$(~/.bin/daily_file)
cat >> "$file_path"
