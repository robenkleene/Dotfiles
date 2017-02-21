# Enable Completion
autoload -Uz compinit
compinit
# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol

# Color in `ls`
export CLICOLOR=1

# Required for abbreviations
setopt extendedglob


# Highlight tab match
zstyle ':completion:*' menu select

