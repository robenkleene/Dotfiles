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
source ~/.zsh/bindings.zsh
# `installs.zsh` before `alias.zsh` so functions don't use aliases and after
# bindings, otherwise bindings conflict with install bindings
# HOMEBREW before settings so that HOMEBREW commpletions (i.e., `fpath`) are
# before completions are generated
source ~/.zsh/installs.zsh
# Regenerate with `zoxide init zsh > ~/.zsh/zoxide.zsh`
source ~/.zsh/zoxide.zsh

# Functions before aliases so functions don't use aliases
source ~/.zsh/functions.zsh
# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh

# Interactive
source ~/.zsh/ui.zsh

# Variables need to be re-sourced in subshells because otherwise path settings
# won't be pulled to the front
source ~/.zsh/variables.zsh
