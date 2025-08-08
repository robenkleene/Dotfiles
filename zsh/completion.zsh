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
# This makes Zsh completion more like Vim *buffer* completion (which does
# substring matches) but not like Vim *file* completion, which only matches from
# the start of the file.
# This doesn't work well for completing with a prefix, e.g., `t_<tab>` will show
# too many matches, because it'll both match the substring and the prefix.
# zstyle ':completion:*' matcher-list 'r:|?=**'
# Allow case-insensitive file matches, this makes Zsh work more like Vim file
# completion, which is case-insensitive.
# This is actually a side-effect of macOS being case insensitive, e.g., filename
# completion in Vim on Linux *is not* case insensitive. So for that reason,
# we're disabling this, because otherwise it emphasizes a confusing difference
# between Vim's behavior in macOS and Linux.
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Theme
# Third value is background
# Sixth value is foreground
# `"ma=48;5;246;38;5;15"`
#           ^ background
#                    ^ foreground
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=48;5;240;38;5;231"
