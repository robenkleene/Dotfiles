#!/usr/bin/env bash

set -eo pipefail

exec ~/.bin/rg_custom "$@" ~/Text ~/Documentation
