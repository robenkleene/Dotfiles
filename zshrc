# Profile
# Run `zprof` after to see results
# zmodload zsh/zprof

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
source ~/.zsh/installs.zsh
# Interactive
source ~/.zsh/ui.zsh

# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh
