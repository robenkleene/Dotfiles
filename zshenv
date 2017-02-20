export CURRENT_SHELL="zsh"

# `pip3` can install executables in `~/.local/bin`
export PATH=~/.local/bin:/usr/local/bin:~/Development/Scripts/bin:$PATH
if [ "$(uname)" = "Darwin" ]; then
  export PATH=~/bin:$PATH
fi

export EDITOR=nvim
export PAGER="less --ignore-case"

# Atom
export ATOM_PATH=$HOME/Applications/
export ATOM_REPOS_HOME=$HOME/Development/Projects/Atom

# Coffeelint
export COFFEELINT_CONFIG=$HOME/.coffeelint.json

# Emacs
# Start the server in the background if it isn't running
export ALTERNATE_EDITOR=""

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
