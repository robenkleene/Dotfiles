#!/usr/bin/env bash

set -euo pipefail

# `-N` is required because `-es` starts in `compatible` mode, which breaks the
# line continuations in the vimrc
# `PlugClean!` removes plugins no longer listed, `PlugUpdate --sync` installs
# missing plugins and updates existing ones
# vim -N -es -u ~/.vimrc -i NONE -c 'PlugClean!' -c 'PlugUpdate --sync' -c 'qa'

# emacs --script ~/.emacs.d/robenkleene/install.el

# Instead of above, we're syncing the `.vim` and `.el` files then compiling Emacs
# We can't sync the `.elc` files because they might have been compiled for a different version of Emacs
# exec emacs -Q --batch --eval '(progn (package-initialize) (byte-recompile-directory package-user-dir 0))'

# yazi
if ! command -v yazi >/dev/null 2>&1; then
  (
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT
    asset=yazi-x86_64-unknown-linux-musl
    curl -fsSL -o "$tmp/$asset.zip" "https://github.com/sxyazi/yazi/releases/latest/download/$asset.zip"
    unzip -q "$tmp/$asset.zip" -d "$tmp"
    mkdir -p ~/.local/bin
    install -m 755 "$tmp/$asset/yazi" "$tmp/$asset/ya" ~/.local/bin/
  )
fi
# Same as above just sync the yazi package files
# ya pkg install
