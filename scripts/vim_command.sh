#!/usr/bin/env bash

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  nvim_edit $@
else
  nvim $@
fi
