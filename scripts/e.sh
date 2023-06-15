#!/usr/bin/env bash

set -euo pipefail

# exec emacsclient_wrapper "$@"
exec emacsclient -nw "$@"
