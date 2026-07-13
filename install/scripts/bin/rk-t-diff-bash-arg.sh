#!/usr/bin/env bash

set -euo pipefail

arg=" ${1:-}"
~/.bin/rk-t-diff-grep$arg | ~/.bin/rk-t-grep-bash-arg
