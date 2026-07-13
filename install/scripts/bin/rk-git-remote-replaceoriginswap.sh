#!/usr/bin/env bash

set -euo pipefail

-/.bin/rk-git-remote-replace-origin $(git ls-remote --get-url | ~/.bin/rk-t-url-url-git)
