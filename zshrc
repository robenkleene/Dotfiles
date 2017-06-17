# Profile
# Run `zprof` after to see results
# zmodload zsh/zprof

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
# Key for Abbreviations & Aliases
# `g`: `git`
# `v`: `vim`
# `a`: `ack`
# `t`: `tig`
# `tm`: `tmux`
source ~/.zsh/abbr.zsh
# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh
source ~/.zsh/startup.zsh

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

# Plugins
# Plugins should be sourced last
# source ~/.zplug/init.zsh
# zplug "zsh-users/zsh-autosuggestions"
# # Syntax highlighting must be sourced last
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug 'zsh-users/zsh-history-substring-search'
# zplug "lib/termsupport", from:oh-my-zsh
# zplug "lib/functions", from:oh-my-zsh
# zplug load

# source ~/.zsh/plugins.zsh
