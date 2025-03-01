#!/usr/bin/env bash

set -euo pipefail

exec ~/.brew/bin/hg --config pager.pager='delta --syntax-theme=none --hyperlinks --hyperlinks-file-link-format=" vscode://file/{path}:{line}"' "$@"