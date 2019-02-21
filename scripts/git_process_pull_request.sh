#!/usr/bin/env bash

set -e

git checkout master
git pull -r
git remote prune origin
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
git branch
