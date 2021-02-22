#!/usr/bin/env bash

set -e

branch="$1"
if [[ -z "$1" ]]; then
  if git show-ref --verify --quiet refs/heads/main; then
    branch="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    branch="master"
  fi
else
  branch="$1"
fi

if ! git show-ref --verify --quiet refs/heads/"${branch}"; then
  echo "Branch $branch does not exist" >&2
  exit 1
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$branch" = "$current_branch" ]]; then
  echo "You're already on $branch" >&2
  exit 1
fi

git checkout "$branch"
git pull -r
git remote prune origin
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
git branch
