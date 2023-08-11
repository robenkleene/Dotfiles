#!/usr/bin/env bash

set -euo pipefail

~/.bin/git_remote_replace_origin $(git ls-remote --get-url | ~/.bin/f_git_url_to_swapped_format)
