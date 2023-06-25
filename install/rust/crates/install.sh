#!/usr/bin/env bash

set -e

# Helper for generating cargo files
# If this is failing just comment it out
# cargo install cargo-generate
# Language server for toml files
cargo install taplo-cli --locked --features lsp
cargo install reap-grep

