#!/usr/bin/env bash

set -e

source ~/.bin/nobin/_giterator.sh

message="$1"
if [[ -z "$message" ]]; then
  message="Update"
fi

nothing_to_commit=$(commit_status)

if [ -n "$message" ] && [ "$nothing_to_commit" = "false" ]; then
  git add -A :/ && git commit -m "$message"
  nothing_to_commit=$(commit_status)
fi

if [ "$nothing_to_commit" = "true" ]; then
  if ! git diff --exit-code "@{upstream}" >/dev/null; then
    git push
  fi
fi

