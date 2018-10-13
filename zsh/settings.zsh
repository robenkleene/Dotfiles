# Ad a custom folder for completions to override installed ones `_rg` was just
# added because path completion is broken with built-in completions. Try
# removing this occasionally and see if path completions have started working.
fpath=(~/.zsh/completion $fpath)

# Required for abbreviations
setopt extendedglob
# Make globs less case sensitive
# Without this set, `ls **/TAG` will print a match with the file name `tag`
# as `TAG`
setopt nocaseglob
# `cd` just by typing name
# setopt autocd
# This is supposed to allow aliases to work in `vim` but it doesn't work
# It's also a bit dangeruous, because it enables aliases in `zsh` scripts# setopt aliases

# Help
autoload -Uz run-help
# This command fails on Linux, so drop its output
unalias run-help &>/dev/null

alias help=run-help
autoload -Uz run-help-git
# autoload -Uz run-help-ip
# autoload -Uz run-help-openssl
# autoload -Uz run-help-p4
# autoload -Uz run-help-sudo
# autoload -Uz run-help-svk
# autoload -Uz run-help-svn

# Automatically `pushd` with `cd`
# `pushdtohome`: Allow `pushd` (or `cd` with `autopushd`) to go to home
# `pushdsilent`: Don't dump directory list after each `pushd` (or `cd`)
# `pushdminus`: Swaps the meaning of `+` and `-`, so `cd -3` is the third
# oldest directory (it's easiest to do `cd -<tab>`.
setopt autopushd pushdminus pushdsilent pushdtohome

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
# Don't enable this because it makes it difficult to narrow in on a choice
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
