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
source ~/.zsh/variables.zsh
# Bindings have to be before `fzf` otherwise the `fzf` bindings won't stick
source ~/.zsh/bindings.zsh
# `fzf` functions before aliases so functions don't use aliases and after 
# bindings, otherwise `fzf` bindings don't work
# HOMEBREW before settings so that HOMEBREW commpletions (i.e., `fpath`) are
# before completions are generated
source ~/.zsh/installs.zsh
# Regenerate with `zoxide init zsh > ~/.zsh/zoxide.zsh`
source ~/.zsh/zoxide.zsh

source ~/.zsh/settings.zsh
# Functions before aliases so functions don't use aliases
source ~/.zsh/functions.zsh
# Interactive
source ~/.zsh/ui.zsh

# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh
