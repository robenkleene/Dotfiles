#!/usr/bin/env bash

set -euo pipefail

cd $(dirname "$0" || exit 1)

applescripts_path="$HOME/Library/Scripts"
if [ -e "$applescripts_path" ] && [ ! -L "$applescripts_path" ]; then
  echo "Warning: $applescripts_path already exists and it's not a symlink" >&2
else
  if [ ! -e "$applescripts_path" ]; then
    ln -s "$PWD/Scripts" "$applescripts_path"
  fi
fi

services_path="$HOME/Library/Services"
if [ -e "$services_path" ] && [ ! -L "$services_path" ]; then
  echo "Warning: $services_path already exists and it's not a symlink" >&2
else
  if [ ! -e "$services_path" ]; then
    ln -s "$PWD/Services" "$services_path"
  fi
fi

bbedit_path="$HOME/Library/Application Support/BBEdit"
if [ -e "$bbedit_path" ] && [ ! -L "$bbedit_path" ]; then
  echo "Warning: $bbedit_path already exists and it's not a symlink" >&2
else
  if [ ! -e "$bbedit_path" ]; then
    ln -s "$PWD/BBEdit" "$bbedit_path"
  fi
fi
