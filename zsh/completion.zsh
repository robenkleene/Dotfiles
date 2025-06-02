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
# `prefix*substring*<tab>`)
zstyle ':completion:*' completer _complete _match

# Make completion case and hyphen insensitive
# Allow partial matches, e.g., `vim md<tab>` for all files with `.md` extension
# zstyle ':completion:*' matcher-list \
#     'm:{[:lower:]}={[:upper:]}' \
#     '+r:|[._-]=* r:|=*' \
#     '+l:|=*'

# Cache completion by default at `~/.zcompcache`
# These don't appear to do anything
# zstyle ':completion::complete:*' use-cache true
# zstyle ':completion::complete:*' cache-path $HOME/.zcompcache
# Highlight partial matches
# zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==$color[cyan]=00}:${(s.:.)LS_COLORS}")';

# This will get completion to use `$LS_COLORS` but it overrides highlighting
# partial matches
# in `"ma=48;5;246;38;5;15"` the third value is the background color (`246`) and
# the sixth value is the foreground color `15`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=48;5;240;38;5;231"
