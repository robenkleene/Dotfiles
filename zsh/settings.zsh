# Don't put this in variables because it needs to be resourced in subprocesses
fpath=( ~/.zfunc "${fpath[@]}" )

# Allows `<C-s>` to be bound in Vim
stty -ixon

# Required for abbreviations
setopt extendedglob
# Make globs less case sensitive
# Without this set, `ls **/TAG` will print a match with the file name `tag`
# as `TAG`
# `setopt nocaseglob` was causing an odd completion issue where an extra letter
# was being added to completions
# setopt nocaseglob
# `cd` just by typing name
# setopt auto_cd

# Help
autoload -Uz run-help
alias help=run-help
# This command fails on Linux, so drop its output
unalias run-help &>/dev/null

# Automatically `pushd` with `cd`
# `pushdtohome`: Allow `pushd` (or `cd` with `autopushd`) to go to home
# `pushd_ignore_dups`: Don't allow dupes in pushd stack
# `pushdsilent`: Don't dump directory list after each `pushd` (or `cd`)
# `pushdminus`: Swaps the meaning of `+` and `-`, so `cd -3` is the third
# oldest directory (it's easiest to do `cd -<tab>`).
setopt autopushd pushdsilent

# History
# Share history between sessions
HISTFILE=~/.zsh_history
# Number of history entries loaded into a session
HISTSIZE=10000
# Number of history entries saved to disk
SAVEHIST=10000
# Don't save commands starting with a space to history
setopt HIST_IGNORE_SPACE

# Remove `|` from `ZLE_REMOVE_SUFFIX_CHARS`, without this setting, doing
# `./<tab-complete-command> |` removes the space before the pipe, which is odd
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'

# By default `zsh` appends to history on exit, and reads it on startup
# Append to history immediately after a command is run
# `inc_append_history_time` appends after the command finishes running
# `inc_append_history` appends when the command starts
# Traced a slowdown problem to `inc_append_history_time`, so keeping it off for
# now
# setopt inc_append_history_time
# Share History
# zsh will save and load each line immediately, but this will intermingle
# history from multiple running shells
# setopt share_history

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
# `compinit -C` is just re-generating the cache and shouldn't be run on startup?
# Removing this breaks `menu select` to highlight the current match
# compinit
# With the `-C` is fast and fixes the issue
autoload -Uz compinit && compinit -C

# Automatically select the first option
# Don't enable this because it makes it difficult to narrow in on a choice
# setopt menucomplete
# Show the menu on the first tab, instead of only completing the ambiguous
# portion
# This makes tab completion often take one less tab, because it becomes just
# two tabs to select the first match if ambiguous, instead of three tabs.
setopt nolistambiguous
# Use a menu when expanding globs
# Can't figure out how to make this work with recursive globs
# setopt globcomplete
# Highlight tab match
zstyle ':completion:*' menu select
# Adding `_match` allow globs in command expansion (e.g.,
# `prefix*substring*<tab>`
zstyle ':completion:*' completer _complete _match
# Make completion case and hyphen insensitive
# Allow partial matches, e.g., `vim md<tab>` for all files with `.md` extension
zstyle ':completion:*' matcher-list \
    'm:{[:lower:]}={[:upper:]}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'

# Cache completion by default at `~/.zcompcache`
# These don't appear to do anything
# zstyle ':completion::complete:*' use-cache true
# zstyle ':completion::complete:*' cache-path $HOME/.zcompcache
# Highlight partial matches
# zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==$color[cyan]=00}:${(s.:.)LS_COLORS}")';
# This will get completion to use `$LS_COLORS` but it overrides highlighting
# partial matches
# in `"ma=48;5;246;38;5;15"` the third value is the background color (`246`) and the sixth value is the foreground color `15`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=48;5;240;38;5;231"
