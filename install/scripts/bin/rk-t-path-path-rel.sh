#!/usr/bin/env bash

set -euo pipefail

grep --fixed-strings "$PWD" | sed "s#^${PWD}/##"
