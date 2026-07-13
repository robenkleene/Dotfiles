#!/usr/bin/env bash

set -euo pipefail

arg=" ${1:-}"
~/.bin/t-diff-grep$arg | ~/.bin/t-grep-bash-arg
