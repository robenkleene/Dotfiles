# Enable Completion
autoload -Uz compinit promptinit
compinit

# Color in `ls`
export CLICOLOR=1

# Required for abbreviations
setopt extendedglob

# Highlight tab match
zstyle ':completion:*' menu select

