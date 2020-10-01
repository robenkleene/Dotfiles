#!/usr/bin/env bash

set -e

git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)"
