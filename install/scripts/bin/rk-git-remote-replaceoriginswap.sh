#!/usr/bin/env bash

set -euo pipefail

-/.bin/git-remote-replace-origin $(git ls-remote --get-url | ~/.bin/t-url-url-git)
