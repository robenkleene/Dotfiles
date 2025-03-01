#!/usr/bin/env bash

set -euo pipefail

exec ~/.brew/bin/delta --syntax-theme=none --relative-paths --hyperlinks --hyperlinks-file-link-format='vscode://file/{path}:{line}' "$@"