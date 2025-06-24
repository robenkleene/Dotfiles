# Trick to get `xargs` to use aliases, e.g., `fd foo | xargs eza` will not use
# aliases without this
alias xargs='xargs '

# Colors
alias grep="`which grep` --color=auto"
if [[ "$(uname)" = "Linux" ]]; then
  # `ls` does colors by default on macOS
  alias ls="`which ls` --color=auto"
fi

# Use `nvim` for clipboard provider
alias vim='nvim'
