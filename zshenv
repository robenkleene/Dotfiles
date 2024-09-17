# `zshenv` is things for all shells

# Put this in `zshenv` so that `.zshrc_local` can add to the path and have it
# be picked up in non-interactive sessions (e.g., running scripts from Emacs
# via `M-!`)
# This is early so that any path settings can be overridden later, e.g, for
# `nvm` and `chruby`
if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

# Don't load the rest of this file if it has already been sourced in particular
# this was added to prevent the path from being re-ordered when a `zsh`
# subshell is started (`vim` does this).
if [[ -v ZSHENV_SOURCED ]]; then
  return
fi
export ZSHENV_SOURCED=1

# `~/.brew/bin` *must* be in `ZSHENV` so that the brew installed version
# of `mosh` gets picked up that supports truecolor
path=(~/.brew/bin $path[@])

if [[ "$(uname)" = "Linux" ]]; then
  export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
  export XDG_CONIFG_HOME=${XDG_CONIFG_HOME:="$HOME/.config"}
fi
