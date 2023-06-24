#!/usr/bin/env bash

set -euo pipefail

# Override LESS because some nnn commands use LESS and options like
# --quit-if-one-screen interfere because they don't pause at the end
exec export LESS="" nnn -eAQ
