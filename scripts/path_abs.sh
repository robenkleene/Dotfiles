#!/usr/bin/env bash

set -euo pipefail

realpath "$@" | sed "s|^$HOME|~|"
