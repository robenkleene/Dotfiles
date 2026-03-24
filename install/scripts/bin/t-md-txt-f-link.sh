#!/usr/bin/env bash

set -euo pipefail

grep --only-matching "\[.*\](.*)" | sed -E 's/\[(.*)\]\((.*)\)/\1 \2/'
