#!/usr/bin/env bash

set -euo pipefail

executable_path=$(command -v -- "claude")

if [[ "$executable_path" != "$HOME/.brew/bin/claude" ]]; then
  if [ ! -e "$HOME/.claude/" ]; then
    # Create the directory so that the symlink isn't created later
    mkdir "$HOME/.claude/"
  elif [ -L "$HOME/.claude/" ]; then
    echo "Warning: $HOME/.claude/ is a symlink for alternative install" >&2
  fi

  if [ ! -e "$HOME/.claude/CLAUDE.md" ]; then
    cd "$(dirname "$0")" && cd ../.. || exit 1
    source_dir=$(pwd -P);
    ln -s "$source_dir/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  fi

  if [ ! -e "$HOME/.claude/commands" ]; then
    cd "$(dirname "$0")" && cd ../.. || exit 1
    source_dir=$(pwd -P);
    ln -s "$source_dir/claude/commands" "$HOME/.claude/commands"
  fi

  if [ ! -e "$HOME/.claude/robenkleene" ]; then
    cd "$(dirname "$0")" && cd ../.. || exit 1
    source_dir=$(pwd -P);
    ln -s "$source_dir/claude/robenkleene" "$HOME/.claude/robenkleene"
  fi
fi
