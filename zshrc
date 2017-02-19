# Enable Completion
autoload -Uz compinit promptinit
compinit

# Use `emacs` bindings
bindkey -e

# Color in `ls`
export CLICOLOR=1

# External
source ~/.zsh/prompt.zsh
source ~/.zsh/bindings.zsh
