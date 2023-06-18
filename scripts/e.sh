#!/usr/bin/env bash

set -euo pipefail

# exec emacsclient -nw "$@"
exec emacsclient_wrapper "$@"
