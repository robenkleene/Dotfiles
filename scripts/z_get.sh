#!/usr/bin/env bash

set -euo pipefail

zoxide query "$@" | tr -d '\n'
