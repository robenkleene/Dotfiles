#!/usr/bin/env bash

set -e

if git show-ref --verify --quiet refs/heads/main; then
  branch="main"
elif git show-ref --verify --quiet refs/heads/master; then
  branch="master"
else
  echo "No default branch found" >&2
  exit 1
fi
git branch --set-upstream-to=origin/$branch $branch
