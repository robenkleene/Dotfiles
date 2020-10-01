#!/usr/bin/env bash

set -e

git push origin --delete "$1" &&
  git branch -D "$1"
