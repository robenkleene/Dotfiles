if set -q "$FISH_SOURCED"
    exit
end
set -gx FISH_SOURCED 1

# These paths are prepended and automatically handle duplicates
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths ~/.bin $fish_user_paths
set -U fish_user_paths ~/.fzf/bin $fish_user_paths

set -gx VIM_COMMAND "vim"
set -gx BAT_COMMAND "bat"
set -gx VISUAL "$VIM_COMMAND"
set -gx EDITOR "$VISUAL"
set -gx LESS "--ignore-case --RAW-CONTROL-CHARS --quit-if-one-screen"
set -gx PAGER "less"
set -gx ACK_COMMAND "rg_custom"

# Prevent `npm` scripts from opening browser windows
set -gx BROWSER "none"
# Emacs
# Start the server in the background if it isn't running
set -gx ALTERNATE_EDITOR ""

# Homebrew
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx VAGRANT_HOME ~/Documents/VMs/Vagrant/vagrant.d
set -gx VAGRANT_VMWARE_CLONE_DIRECTORY ~/Documents/VMs/Vagrant/

# Tidy
set -gx HTML_TIDY "$HOME/.tidy"

# Shellcheck
set -gx SHELLCHECK_OPTS "-e SC1090 -e SC2148"

if test -n "$INSIDE_EMACS"
    set -gx PAGER "cat"
    set -gx GIT_PAGER "cat"
end
