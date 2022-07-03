if set -q "$FISH_SOURCED"
    exit
end
set -gx FISH_SOURCED 1

set -gx VIM_COMMAND vim
# set -gx VIM_COMMAND "nvim"
set -gx BAT_COMMAND bat
set -gx VISUAL "$VIM_COMMAND"
set -gx EDITOR "$VISUAL"
set -gx LESS "--ignore-case --RAW-CONTROL-CHARS --quit-if-one-screen"
set -gx PAGER less
set -gx ACK_COMMAND rg

# Prevent `npm` scripts from opening browser windows
# set -gx BROWSER "none"
# Or set it
switch (uname)
    case Linux
        set -gx BROWSER none
    case Darwin
        set -gx BROWSER "google chrome"
end
# set -gx BROWSER "Microsoft Edge Beta"

# Emacs
# Start the server in the background if it isn't running
set -gx ALTERNATE_EDITOR ""
set -gx EMACS_COMMAND "emacsclient -nw"

set -gx fish_help_browser echo

# Homebrew
if type -q brew
    set -gx HOMEBREW_DIR (brew --prefix)
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    set -q MANPATH || set MANPATH ''
    set -x MANPATH $MANPATH $HOMEBREW_DIR/share/man
    set -q INFOPATH || set MANPATH ''
    set -x INFOPATH $INFOPATH $HOMEBREW_DIR/share/info
end
set -gx VAGRANT_HOME ~/Documents/VMs/Vagrant/vagrant.d
set -gx VAGRANT_VMWARE_CLONE_DIRECTORY ~/Documents/VMs/Vagrant/

# Git
set -gx GIT_EDITOR "$VIM_COMMAND -c \"SessionNoAuto\""

# Tidy
set -gx HTML_TIDY "$HOME/.tidy"

# Shellcheck
set -gx SHELLCHECK_OPTS "-e SC1090 -e SC2148"

if test -n "$INSIDE_EMACS"
    set -gx PAGER cat
    set -gx GIT_PAGER cat
end
