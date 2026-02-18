#!/usr/bin/env bash

set -e

if [[ "$1" = "-D" ]]; then
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
else
  git branch -vv | grep ': gone]' | awk '{print $1}'
fi
