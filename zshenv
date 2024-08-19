# `zshenv` is things for all shells

# Don't load the rest of this file if it has already been sourced in particular
# this was added to prevent the path from being re-ordered when a `zsh`
# subshell is started (`vim` does this).
if [[ -v ZSHENV_SOURCED ]]; then
  return
fi
export ZSHENV_SOURCED=1

# This helps with some issues with mosh, e.g., utf-8 support and specifying
# locale
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Note that `~/.brew/bin` *must* be set here so that the brew installed version
# of `mosh` gets picked up that supports truecolor
if [[ "$TERM_PROGRAM" = "Apple_Terminal" ]]; then
  # The other method doesn't work in Apple Terminal for some reason?
  export PATH=~/.bin:~/.brew/bin:$PATH
else
  # This method of setting the path prevents duplicate entries.
  typeset -U path
  path=(~/.bin ~/.brew/bin $path[@])
fi

# The `-U` option prevents duplicates when `tmux` starts `zsh` instances
export -U PATH

# Allow custom man pages
export MANPATH=$MANPATH:$HOME/.man
export -U MANPATH

#
if [[ "$(uname)" = "Linux" ]]; then
  export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
  export XDG_CONIFG_HOME=${XDG_CONIFG_HOME:="$HOME/.config"}
fi
