# Completion

# Enable Completion
# `compinit -C` is re-generating the cache and maybe shouldn't be run on
# startup?
# Removing this breaks `menu select` to highlight the current match
# With the `-C` is fast and fixes hightling the current match still works
autoload -Uz compinit && compinit -C

# Show the menu on the first tab, instead of only completing the ambiguous
# portion
# This makes tab completion often take one less tab, because it becomes just
# two tabs to select the first match if ambiguous, instead of three tabs.
setopt nolistambiguous

# Highlight tab match
zstyle ':completion:*' menu select

# Allow substring matches, e.g., `vim md<tab>` for all files with `.md` extension
# This makes Zsh completion more like Vim completion
zstyle ':completion:*' matcher-list 'r:|?=**'

# Theme
# Third value is background
# Sixth value is foreground
# `"ma=48;5;246;38;5;15"`
#           ^ background
#                    ^ foreground
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=48;5;240;38;5;231"
