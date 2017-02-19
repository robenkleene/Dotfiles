# Enable Completion
autoload -Uz compinit promptinit
compinit

# Color in `ls`
export CLICOLOR=1

# Plugins
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
# Syntax highlighting must be last
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load

# External
source ~/.zsh/prompt.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/alias.zsh
