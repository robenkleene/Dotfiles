#!/usr/bin/env bash

set -e

file=$(journal_new_make_default)
eval "$EDITOR $file"
