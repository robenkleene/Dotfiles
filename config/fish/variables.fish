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
set -gx CAT_COMMAND "bat"
set -gx MD_CAT_COMMAND "bat --style plain"
set -gx VISUAL "hx"
# set -gx VISUAL "$VIM_COMMAND"
# set -gx VISUAL "$EMACS_COMMAND"
# `hx` doesn't support jumping to a line number from `tig` for example
# set -gx CD_COMMAND "emacs_cd"
set -gx CD_COMMAND "vim_cd"

set -gx EDITOR "$VISUAL"
# set -gx MD_EDITOR "$EMACS_COMMAND"
# set -gx MD_EDITOR "$VIM_COMMAND"
# set -gx GIT_EDITOR "$EMACS_COMMAND"
# set -gx GIT_EDITOR "$VIM_COMMAND"
# set -gx GIT_EDITOR "$VIM_COMMAND -c \"SessionNoAuto\""
set -gx TIG_EDITOR "hx_wrapper"
set -gx LESS "--ignore-case --quit-if-one-screen"
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

if test -n "$INSIDE_EMACS"
    set -gx PAGER cat
    set -gx GIT_PAGER cat
end
