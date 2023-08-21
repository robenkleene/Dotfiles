#!/usr/bin/env bash

set -euo pipefail

{ ~/.bin/egit -p || ~/.bin/egit -n && exit 1; } && ~/.bin/sgitt_auto
