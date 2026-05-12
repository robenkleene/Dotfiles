#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

if [[ -f "$HOME/.personal" ]]; then
  ./setup_repos.zsh -f
else
  ./setup_repos.zsh -f -H -p
fi
