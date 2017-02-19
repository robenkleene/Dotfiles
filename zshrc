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

# Setup
source ~/.zsh/variables.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/installs.zsh
# Interactive
source ~/.zsh/ui.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/startup.zsh

# This misbehaves when sourced
eval "$(fasd --init auto)"
