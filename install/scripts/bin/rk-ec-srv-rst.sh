#!/usr/bin/env bash

set -euo pipefail

~/.bin/rk-ec-srv-qui
exec emacsclient -nw .
