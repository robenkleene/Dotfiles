#!/usr/bin/env bash

set -euo pipefail

# Files

# `.editorconfig` is only supported in directories that are children of the
# home directory. To support other directories, symlink them here.
if [[ -e "$HOME/../Shared/Max 9/" ]]; then
  if [[ ! -e "$HOME/../Shared/Max 9/.editorconfig" ]]; then
    ln -s ~/.editorconfig "$HOME/../Shared/Max 9/.editorconfig"
  fi
fi

# Directories

developer_path="${HOME}/Developer"
if [[ ! -e "$developer_path" ]]; then
  mkdir -p "$developer_path"
elif [[ ! -d "$developer_path" ]]; then
  echo "Error: A file exists at $developer_path and it's not a directory" >&2
  exit 1
fi

org_src_path="${HOME}/Documents/Text/org/"
org_dst_path="${HOME}/org"
if [[ ! -L "$org_dst_path" ]]; then
  if [[ ! -e "$org_src_path" ]]; then
    mkdir -p "$org_src_path"
  elif [[ ! -d "$org_src_path" ]]; then
    echo "Error: A file exists at $org_src_path and it's not a directory" >&2
    exit 1
  fi
  ln -s "$org_src_path" "$org_dst_path"
elif [[ -e "$org_dst_path" ]]; then
  echo "Error: A file exists at $org_dst_path is not a symlink" >&2
  exit 1
fi