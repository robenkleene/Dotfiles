#!/usr/bin/env bash

set -euo pipefail

~/.bin/git_remote_replace_origin $(git ls-remote --get-url | ~/.bin/f_url_to_git)
