#!/usr/bin/env bash

set -euo pipefail

exec ~/.bin/safepaste | ~/.bin/vim_diff
