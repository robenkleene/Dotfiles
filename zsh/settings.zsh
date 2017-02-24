# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol
# Color in `ls`
export CLICOLOR=1
# Required for abbreviations
setopt extendedglob
# `cd` just by typing name
setopt autocd

# History
# Share history between sessions
setopt share_history
HISTFILE=~/.zsh_history
# Number of history entries loaded into a session
HISTSIZE=10000
# Number of history entries saved to disk
SAVEHIST=10000

# Completion
# Enable Completion
autoload -Uz compinit
compinit
# Automatically select the first option
# setopt menucomplete
# Use a menu when expanding globs
# Can't figure out how to make this work with recursive globs
# setopt globcomplete
# Don't beep on tab
setopt nolistbeep
# Highlight tab match
zstyle ':completion:*' menu select
# Make completion case and hyphen insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
# Highlight partial matches
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==$color[cyan]=00}:${(s.:.)LS_COLORS}")';
