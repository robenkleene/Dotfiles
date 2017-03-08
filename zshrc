# Profile
# Run `zprof` after to see results
# zmodload zsh/zprof

# Setup
source ~/.zsh/variables.zsh
source ~/.zsh/settings.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/installs.zsh
# Interactive
source ~/.zsh/fzf.zsh
source ~/.zsh/ui.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/abbr.zsh
# Aliases defined after functions so functions don't use aliases
source ~/.zsh/alias.zsh
source ~/.zsh/startup.zsh
if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi


# Plugins
# Plugins should be sourced last

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
# Syntax highlighting must be sourced last
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug 'zsh-users/zsh-history-substring-search'
zplug "lib/termsupport", from:oh-my-zsh
zplug "lib/functions", from:oh-my-zsh
zplug load

source ~/.zsh/plugins.zsh
