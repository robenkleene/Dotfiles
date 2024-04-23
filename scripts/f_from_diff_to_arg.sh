#!/usr/bin/env bash

set -euo pipefail

arg=" ${1:-}"
~/.bin/f_from_diff_to_grep$arg | ~/.bin/f_from_grep_to_arg
