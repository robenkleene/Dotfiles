# Put this in `zshenv` so that `.zshrc_local` can add to the path and have it
# be picked up in non-interactive sessions (e.g., running scripts from Emacs
# via `M-!`)
# This is early so that any path settings can be overridden later, e.g, for
# `nvm` and `chruby`
if [[ -f ~/.zshrc_local.zsh ]]; then
  source ~/.zshrc_local.zsh
fi

# `~/.brew/bin` *must* be in `ZSHENV` so that the brew installed version
# of `mosh` gets picked up that supports truecolor
# `~/.bin` also needs to be here to makes scripts available in non-interactive
# shells, e.g., BBEdit `Run Unix Command...`
# `-U` prevents duplicates
export -U path=(~/.bin ~/.brew/bin $path)
# Allow local bin to override
if [[ -d "$HOME/.bin-local" ]]; then
  path=(~/.bin-local $path)
fi

if [[ "$(uname)" = "Linux" ]]; then
  export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
  export XDG_CONIFG_HOME=${XDG_CONIFG_HOME:="$HOME/.config"}
fi
