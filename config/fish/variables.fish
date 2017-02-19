# Editor
# Vim
# set -x EDITOR vim
# NeoVim
set -x EDITOR nvim

# Manpager
set -x PAGER "less --squeeze-blank-lines --ignore-case"

# Pager
set -x PAGER "less --ignore-case"
# Fish
set -x FISH_CONFIG_PATH $HOME/.config/fish/config.fish

# Atom
set -x ATOM_PATH $HOME/Applications/
set -x ATOM_REPOS_HOME $HOME/Development/Projects/Atom

# Coffeelint
set -x COFFEELINT_CONFIG $HOME/.coffeelint.json

# Emacs
# Start the server in the background if it isn't running
set -x ALTERNATE_EDITOR ""

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1
