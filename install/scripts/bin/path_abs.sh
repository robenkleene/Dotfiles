#!/usr/bin/env bash

set -euo pipefail

# `s| |\\\\ |g` escapes spaces with backslashes for shell-safe paths
realpath "$@" | sed "s|^$HOME|~|; s| |\\\\ |g"
