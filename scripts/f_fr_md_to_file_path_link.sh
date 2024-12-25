#!/usr/bin/env bash

set -euo pipefail

~/.bin/f_fr_md_to_md_link | grep -oP "\(\K[^\)]*(?=\))"