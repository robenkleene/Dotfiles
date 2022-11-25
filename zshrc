# Profile
# Run `zprof` after to see results
zmodload zsh/zprof

# Homebrew
# This was moved from `zshenv` because the brew path (in `/usr/local/bin`) is
# set by `/etc/profile`, and that's sourced *after* loading `zshenv`
if command -v brew &> /dev/null; then
  export HOMEBREW_DIR
  HOMEBREW_DIR=$(brew --prefix)
  export MANPATH="$HOMEBREW_DIR/share/man:$MANPATH"
  export INFOPATH="$HOMEBREW_DIR/share/info:$INFOPATH"
fi

# This is early so that any path settings can be overridden later, e.g, for
# `nvm` and `chruby`
if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

# Emacs Tramp mode sets the term to dumb
if [[ $TERM == "dumb" ]]; then
  return
fi

# Setup
source ~/.zsh/settings.zsh
# Bindings have to be before `fzf` otherwise the `fzf` bindings won't stick
source ~/.zsh/bindings.zsh
# Functions before aliases so functions don't use aliases
source ~/.zsh/functions.zsh
# `fzf` functions before aliases so functions don't use aliases and after 
# bindings, otherwise `fzf` bindings don't work
source ~/.zsh/fzf.zsh
source ~/.zsh/installs.zsh
# Interactive
source ~/.zsh/ui.zsh
source ~/.zsh/abbr.zsh

# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh
source ~/.zsh/startup.zsh
