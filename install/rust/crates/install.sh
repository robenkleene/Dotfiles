#!/usr/bin/env bash

set -e

# On intial install, cargo won't be in the `$PATH` yet so use an absolute path

~/.cargo/bin/cargo install rep-grep
~/.cargo/bin/cargo install ren-find
# Helper for generating cargo files
# If this is failing just comment it out
# cargo install cargo-generate
