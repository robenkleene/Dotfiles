#!/usr/bin/env bash

set -euo pipefail

sed -E 's/\[\[file:([^:]+)::([^]]+)\]\]/\1:\2/g'
