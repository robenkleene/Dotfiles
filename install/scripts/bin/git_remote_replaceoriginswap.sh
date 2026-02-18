#!/usr/bin/env bash

set -euo pipefail

~/.bin/git_remote_replace_origin $(git ls-remote --get-url | ~/.bin/t_url_url_git)
