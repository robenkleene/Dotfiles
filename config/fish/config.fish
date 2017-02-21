# Configuration

# Setup `fisher` (fisherman)
# Install via `brew`, then fun `fisher` in the same directory as the `fishfile`

# Setup
source ~/.config/fish/variables.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/installs.fish
# Interactive
source ~/.config/fish/ui.fish
source ~/.config/fish/fzf.fish
source ~/.config/fish/alias.fish
source ~/.config/fish/bindings.fish
source ~/.config/fish/startup.fish

# local fish config
if test -e ~/.config.fish
  source ~/.config.fish
end
