#!/usr/bin/env bash

set -euo pipefail

arg=" ${1:-}"
~/.bin/f_fr_diff_to_grep$arg | ~/.bin/f_fr_grep_to_arg
