#!/usr/bin/env bash

set -euo pipefail

~/.bin/emacs_kill_server
exec ~/.bin/emacsclient_wrapper
