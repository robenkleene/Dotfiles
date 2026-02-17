#!/usr/bin/env bash

set -euo pipefail
exec git submodule update --init --recursive --remote
