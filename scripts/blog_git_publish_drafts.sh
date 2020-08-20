#!/usr/bin/env bash

set -e

blog_directory=~/Developer/Projects/Web/robenkleene.github.io/
cd "$blog_directory"
git add -A :/ 
if git diff-index --quiet HEAD; then
  echo "No drafts"
  exit 1
fi

git add -A :/ && git commit -m "Drafts"
~/.bin/jekyll_publish_drafts
git add -A :/ && git commit -m "Publish"
git push
