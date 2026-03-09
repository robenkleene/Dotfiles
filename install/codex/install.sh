#!/usr/bin/env bash

set -euo pipefail

source ~/.bin/nobin/_symlink.sh

safe_symlink "$HOME/.config/agents/AGENTS.md" "$HOME/.codex/AGENTS.md"
