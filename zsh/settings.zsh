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
# Reduce dupes
# setopt hist_expire_dups_first
# setopt hist_ignore_dups
# Above options are no-op with the below
setopt hist_ignore_all_dups

# Don't beep on failed completion
setopt nolistbeep
# Just don't beep period
# setopt nobeep

# Completion
# Enable Completion
autoload -Uz compinit
compinit
# Automatically select the first option
# setopt menucomplete
# Use a menu when expanding globs
# Can't figure out how to make this work with recursive globs
# setopt globcomplete
# Highlight tab match
zstyle ':completion:*' menu select
# Make completion case and hyphen insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
# Cache completion by default at `~/.zcompcache`
# These don't appear to do anything
# zstyle ':completion::complete:*' use-cache true
# zstyle ':completion::complete:*' cache-path $HOME/.zcompcache
# Highlight partial matches
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==$color[cyan]=00}:${(s.:.)LS_COLORS}")';
# This will get completion to use `$LS_COLORS` but it overrides highlighting
# partial matches
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
