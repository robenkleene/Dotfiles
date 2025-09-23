# Profile
# Run `zprof` after to see results
# zmodload zsh/zprof

# Emacs Tramp mode sets the term to dumb
if [[ $TERM == "dumb" ]]; then
  return
fi

# Setup
source ~/.zsh/settings.zsh
source ~/.zsh/completion.zsh
# Variables need to be re-sourced in subshells because otherwise path settings
# won't be pulled to the front
# This needs to stay ahead of installs so the path is set before installs,
# otherwise `.brew/bin` won't be in front of `/usr/local/bin`
source ~/.zsh/variables.zsh
# `installs.zsh` before `alias.zsh` so functions don't use aliases and after
# bindings, otherwise bindings conflict with install bindings
# HOMEBREW before settings so that HOMEBREW commpletions (i.e., `fpath`) are
# before completions are generated
source ~/.zsh/installs.zsh
# After installs so bindings take precedence over install bindings
source ~/.zsh/bindings.zsh

# Functions before aliases so functions don't use aliases
source ~/.zsh/functions.zsh
# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh

# Interactive
source ~/.zsh/ui.zsh
