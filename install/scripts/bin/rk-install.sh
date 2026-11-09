#!/usr/bin/env bash

set -euo pipefail

# `-N` is required because `-es` starts in `compatible` mode, which breaks the
# line continuations in the vimrc
# `PlugClean!` removes plugins no longer listed, `PlugUpdate --sync` installs
# missing plugins and updates existing ones
vim -N -es -u ~/.vimrc -i NONE -c 'PlugClean!' -c 'PlugUpdate --sync' -c 'qa'

emacs --script ~/.emacs.d/robenkleene/install.el
