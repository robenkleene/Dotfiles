#!/usr/bin/env bash

set -euo pipefail

process_dir() {
  if [[ -d ".git" ]]; then
    git diff
    return 0
  elif [[ -d ".hg" ]]; then
    hg diff
    return 0
  fi
}

while [[ $PWD != / ]]; do
  process_dir
  status=$?
  if [[ $status -eq 0 ]]; then
    break
  fi
  cd ..
done

if [[ $PWD == / ]]; then
  echo "No root directory found" >&2
  exit 1
fi

