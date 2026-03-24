#!/usr/bin/env bash

set -euo pipefail

git_parameter=""
branch=""
while getopts ":C:b:h" option; do
  case "$option" in
    C)
      git_parameter=" -C $OPTARG"
      ;;
    b)
      branch="$OPTARG"
      ;;
    h)
      echo "Usage: command [-hp] [-f <file>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$branch" ]]; then
  if git$git_parameter show-ref --verify --quiet refs/heads/main; then
    branch="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    branch="master"
  fi
fi

if ! git$git_parameter show-ref --verify --quiet refs/heads/"${branch}"; then
  echo "Branch $branch does not exist" >&2
  exit 1
fi

current_branch=$(git$git_parameter rev-parse --abbrev-ref HEAD)
if [[ "$branch" = "$current_branch" ]]; then
  echo "You're already on $branch" >&2
  exit 1
fi

git$git_parameter checkout "$branch"
git$git_parameter pull -r
git$git_parameter remote prune origin
git$git_parameter branch -vv | grep ': gone]' | awk '{print $1}' | xargs git$git_parameter branch -D
git$git_parameter branch
