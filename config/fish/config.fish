# Configuration

# Setup `fisher` (fisherman)
# Install via `brew`, then fun `fisher` in the same directory as the `fishfile`

# Greeting
set --erase fish_greeting

# Path
set -x PATH /usr/local/bin ~/Development/Scripts/bin $PATH
if not test (uname) = Darwin
  set -x PATH ~/bin $PATH
end

# local fish config
if test -e ~/.config.fish
  source ~/.config.fish
end

# Setup
source ~/.config/fish/variables.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/installs.fish
# Interactive
source ~/.config/fish/ui.fish
source ~/.config/fish/fzf.fish
source ~/.config/fish/alias.fish
source ~/.config/fish/startup.fish
