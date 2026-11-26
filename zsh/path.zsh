# Every `path` setting, sourced from `zshenv`, `zprofile`, and `zshrc` (in
# `var.zsh`), so every kind of shell gets the same path:
# - `zshenv` for non-interactive shells, e.g., scripts and `ssh <host> <command>`
# - `zprofile` for login shells (e.g., `ssh <host> zsh -lc <command>`), since on
#   macOS `/etc/zprofile` runs `path_helper` after `zshenv`, which moves the
#   system paths ahead of these
# - `zshrc` to move these back to the front in interactive shells
# Only cheap checks belong here, since it runs for every shell. Each setting
# goes in front of the ones before it.

# `typeset -U` prevents duplicates in `path`, this needs to be here even if `-U`
# was set earlier
typeset -U path

# `~/.brew/bin` *must* be in `ZSHENV` so that the brew installed version
# of `mosh` gets picked up that supports truecolor
# `~/.bin` also needs to be here to makes scripts available in non-interactive
# shells, e.g., BBEdit `Run Unix Command...`
path=(~/.bin ~/.brew/bin $path)
# Allow local bin to override
if [[ -d "$HOME/.bin-local" ]]; then
  path=(~/.bin-local $path)
fi

# `~/.rubies/current` is a symlink to the Ruby in use
if [[ -d ~/.rubies/current/bin ]]; then
  path=(~/.rubies/current/bin $path)
fi

# Python
# `uv tool` and Claude Code install here
path=(~/.local/bin $path)

# llvm
if [[ "$(uname)" = "Darwin" ]]; then
  # Make tools like `clangd` available
  path=(/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin $path)
elif [[ "$(uname)" = "Linux" && -d ~/swift/swift-6.0.2-RELEASE-ubuntu20.04/usr/bin ]]; then
  path=(~/swift/swift-6.0.2-RELEASE-ubuntu20.04/usr/bin $path)
fi

# Rust
if [[ -d $HOME/.cargo/bin ]]; then
  path=(~/.cargo/bin $path)
fi

# Node, see `nvm` in `installs.zsh`
if [[ -d "$HOME/.config/nvm/21.6.1/bin" ]]; then
  path=(~/.config/nvm/21.6.1/bin $path)
elif [[ -d "$HOME/.nvm/versions/node/v21.6.1/bin" ]]; then
  path=(~/.nvm/versions/node/v21.6.1/bin $path)
fi
