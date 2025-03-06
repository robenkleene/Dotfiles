#!/usr/bin/env bash

set -euo pipefail

exec ~/.brew/bin/rg --hyperlink-format='vscode://file/{path}:{line}' "$@"
