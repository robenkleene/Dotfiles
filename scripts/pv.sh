#!/usr/bin/env bash

set -euo pipefail

exec ~/.bin/safepaste | $VIM_COMMAND -
