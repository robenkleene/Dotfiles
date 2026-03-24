#!/usr/bin/env bash

set -euo pipefail

sed -E 's/\[\[([^]]+)\]\[([^]]+)\]\]/[\2](\1)/g'
