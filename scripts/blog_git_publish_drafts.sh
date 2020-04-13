#!/usr/bin/env bash

set -e

blog_directory=~/Development/Projects/Web/robenkleene.github.io/
cd "$blog_directory"
if ! git diff --exit-code _drafts; then
  echo "No drafts"
  exit 1
fi
git add -A :/ && git commit -m "Drafts"
~/.bin/jekyll_publish_drafts
git add -A :/ && git commit -m "Publish"
