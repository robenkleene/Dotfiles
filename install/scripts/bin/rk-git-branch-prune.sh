#!/usr/bin/env bash

set -e

git remote prune origin
if [[ "$1" = "-D" ]]; then
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
fi
