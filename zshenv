# `zshenv` is things for all shells

# Don't load the rest of this file if it has already been sourced in particular
# this was added to prevent the path from being re-ordered when a `zsh`
# subshell is started (`vim` does this).
if [[ -v ZSHENV_SOURCED ]]; then
  return
fi
export ZSHENV_SOURCED=1

if [[ "$(uname)" = "Linux" ]]; then
  export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
  export XDG_CONIFG_HOME=${XDG_CONIFG_HOME:="$HOME/.config"}
fi
