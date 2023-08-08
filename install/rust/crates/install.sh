#!/usr/bin/env bash

set -e

cargo install rep-grep
cargo install ren-find
# Helper for generating cargo files
# If this is failing just comment it out
# cargo install cargo-generate
# Language server for toml files
cargo install taplo-cli --locked --features lsp

