# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# Home brew should already be set, but this moves it back to the front of path
PATH=~/.brew/bin:$PATH
# Homebrew
# This was moved from `zshenv` because the brew path (in `/usr/local/bin`) is
# set by `/etc/profile`, and that's sourced *after* loading `zshenv`
if command -v brew &> /dev/null; then
  export HOMEBREW_DIR
  HOMEBREW_DIR=$(brew --prefix)
  export MANPATH="$HOMEBREW_DIR/share/man:$MANPATH"
  export INFOPATH="$HOMEBREW_DIR/share/info:$INFOPATH"
  FPATH="$HOMEBREW_DIR/share/zsh/site-functions:${FPATH}"
fi

# fzf
if [[ -f "$HOMEBREW_DIR/opt/fzf/shell/completion.zsh" ]]; then
  source "$HOMEBREW_DIR/opt/fzf/shell/completion.zsh"
fi
if [[ -f "$HOMEBREW_DIR/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$HOMEBREW_DIR/opt/fzf/shell/key-bindings.zsh"
fi
_fzf_z_widget() {
  setopt localoptions pipefail 2> /dev/null

  local result
  result="$(~/.bin/z_fzf)"
  local ret=$?
  if (( $ret )) then
    zle reset-prompt
    return $ret
  fi

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return
  fi

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result
    zle redisplay
    return $ret
  fi

  cd "$result" || return 1
  local result_parameter
  result_parameter=${(qq)result}
  print -sr -- "cd ${result_parameter}"
  zle reset-prompt
  return $ret
}
zle -N _fzf_z_widget
bindkey '\ez' _fzf_z_widget

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

# The `-U` option prevens duplicates when `tmux` starts `zsh` instances
export -U PATH
