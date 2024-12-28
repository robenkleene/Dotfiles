#!/usr/bin/env bash

set -euo pipefail

arg=" ${1:-}"
~/.bin/t_diff_grep$arg | ~/.bin/t_grep_arg
