# fasd
if [[ $(whence -p "fasd") ]]; then
  eval "$(fasd --init auto)"
fi

# chruby
if [[ -f $HOMEBREW_DIR/share/chruby/chruby.sh ]]; then
  source "$HOMEBREW_DIR/share/chruby/chruby.sh"
  source "$HOMEBREW_DIR/share/chruby/auto.sh"
  chruby ruby-3.0.2
fi

# Python
if [[ "$(uname)" = "Darwin" ]]; then
  PATH=$HOME/Library/Python/3.9/bin:$PATH
elif [[ "$(uname)" = "Linux" ]]; then
  PATH=$HOME/.local/bin:$PATH
fi

# llvm
if [[ "$(uname)" = "Darwin" ]]; then
  # This gets rid of errors when importing C headers
  export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
  # Make tools like `clangd` available
  PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH"
fi

# Rust
if [[ -d $HOME/.cargo/bin ]]; then
  PATH=$HOME/.cargo/bin:$PATH
fi

# nvm
# Official installation is really slow:
# Do not use homebrew `nvm` because it overrides `NVM_DIR` which causes issues.
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# This is faster:
# Automatic node version switching is probably broken by this
nvm() {
  if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm "$@"
   fi
}
if [[ -d "$HOME/.config/nvm/17.0.1/bin" ]]; then
  PATH=$HOME/.config/nvm/17.0.1/bin:$PATH
elif [[ -d "$HOME/.nvm/versions/node/v17.0.1/bin" ]]; then
  PATH=$HOME/.nvm/versions/node/v17.0.1/bin:$PATH
fi

# Syntax highlighting installed via Homebrew
if [[ -n "${HOMEBREW_DIR-}" ]]; then
  source "$HOMEBREW_DIR/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# The `-U` option prevens duplicates when `tmux` starts `zsh` instances
export -U PATH
