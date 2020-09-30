#!/usr/bin/env bash

set -e

tmux rename-window "$(basename "$PWD")"
