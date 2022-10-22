if set -q "$FISH_SOURCED"
    exit
end
set -gx FISH_SOURCED 1

# Emacs
# Start the server in the background if it isn't running
set -gx ALTERNATE_EDITOR ""
set -gx EMACS_COMMAND "emacsclient -nw"

# Other
set -gx VIM_COMMAND nvim
# set -gx VIM_COMMAND "nvim"
set -gx BAT_COMMAND bat
set -gx VISUAL "$VIM_COMMAND"
# set -gx VISUAL "$EMACS_COMMAND"
# `hx` doesn't support jumping to a line number from `tig` for example
# set -gx VISUAL "hx"
set -gx EDITOR "$VISUAL"
set -gx MD_EDITOR "$EMACS_COMMAND"
set -gx GIT_EDITOR "$VIM_COMMAND"
# set -gx GIT_EDITOR "$VIM_COMMAND -c \"SessionNoAuto\""
set -gx LESS "--ignore-case --RAW-CONTROL-CHARS --quit-if-one-screen"
set -gx PAGER less
set -gx ACK_COMMAND rg
set -gx COLORTERM "truecolor"

# Prevent `npm` scripts from opening browser windows
set -gx BROWSER "none"
# Or set it
# switch (uname)
#     case Linux
#         set -gx BROWSER none
#     case Darwin
#         set -gx BROWSER "google chrome"
# end
# set -gx BROWSER "Microsoft Edge Beta"

set -gx fish_help_browser echo

# Homebrew
if type -q brew
    set -gx HOMEBREW_DIR (brew --prefix)
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    set -gx HOMEBREW_NO_INSTALL_CLEANUP 1
    set -q MANPATH || set MANPATH ''
    set -x MANPATH $MANPATH $HOMEBREW_DIR/share/man
    set -q INFOPATH || set MANPATH ''
    set -x INFOPATH $INFOPATH $HOMEBREW_DIR/share/info
end
set -gx VAGRANT_HOME ~/Documents/VMs/Vagrant/vagrant.d
set -gx VAGRANT_VMWARE_CLONE_DIRECTORY ~/Documents/VMs/Vagrant/

# Tidy
set -gx HTML_TIDY "$HOME/.tidy"

# Shellcheck
set -gx SHELLCHECK_OPTS "-e SC1090 -e SC2148"

if test -n "$INSIDE_EMACS"
    set -gx PAGER cat
    set -gx GIT_PAGER cat
end

# nnn
set BLK "0B"
set CHR "0B"
set DIR "04"
set EXE "06"
set REG "00"
set HARDLINK "06"
set SYMLINK "06"
set MISSING "00"
set ORPHAN "09"
set FIFO "06"
set SOCK "0B"
set OTHER "06"
set -gx NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
