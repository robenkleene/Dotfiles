#!/usr/bin/env bash

/usr/local/bin/wdiff --avoid-wraps -w $'\033[30;41m' -x $'\033[0m' -y $'\033[30;42m' -z $'\033[0m' "$@"
