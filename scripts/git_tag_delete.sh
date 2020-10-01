#!/usr/bin/env bash

set -e

git push --delete origin "$1" &&
  git fetch --prune --tags
