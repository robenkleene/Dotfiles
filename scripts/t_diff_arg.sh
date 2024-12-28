#!/usr/bin/env bash

set -euo pipefail

arg=" ${1:-}"
~/.bin/t_diff_grep$arg | ~/.bin/f_fr_grep_to_arg
