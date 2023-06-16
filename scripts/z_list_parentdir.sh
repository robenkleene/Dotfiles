#!/usr/bin/env bash

set -euo pipefail

grep --word-regexp --fixed-strings -f <(~/.brew/bin/zoxide query --list "$@") <(~/.bin/list_parentdir)
