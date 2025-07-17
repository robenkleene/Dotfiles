# Don't put this in variables because it needs to be resourced in subprocesses
fpath=( ~/.zfunc "${fpath[@]}" )

# Allows `<C-s>` to be bound in Vim
stty -ixon

# Required for abbreviations
# setopt extendedglob

# Make globs less case sensitive
# Without this set, `ls **/TAG` will print a match with the file name `tag`
# as `TAG`
# `setopt nocaseglob` was causing an odd completion issue where an extra letter
# was being added to completions
# setopt nocaseglob

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
# Try this instead, without this, a command I know I've run might be missing
# from this history of new shells because without this, commands aren't entered
# until they finish running
setopt inc_append_history
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
