#!/usr/bin/env bash

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  nvim-edit $@
else
  nvim $@
fi
