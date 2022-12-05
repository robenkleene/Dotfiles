function fish_sync_variables
    for v in (set --names -U | grep -v "^_*fish")
        set -e $v
    end
    # Fish
    set -Ux fish_help_browser echo
    # Suppress default greeting
    set -U fish_greeting

    # Emacs
    # Start the server in the background if it isn't running
    set -Ux ALTERNATE_EDITOR ""
    set -Ux EMACS_COMMAND "emacsclient -nw"

    # Other
    set -Ux VIM_COMMAND nvim
    # set -Ux VIM_COMMAND vim
    set -Ux MD_CAT_COMMAND "bat --style plain"
    set -Ux MD_EDITOR_COMMAND "$EMACS_COMMAND"

    # # set -Ux VISUAL "hx"
    # set -Ux TIG_EDITOR "hx_wrapper"

    set -Ux VISUAL "$VIM_COMMAND"
    # set -Ux VISUAL "$EMACS_COMMAND"

    # set -Ux CD_COMMAND "emacs_cd"
    set -Ux CD_COMMAND "vim_cd"

    set -Ux EDITOR "$VISUAL"
    # set -Ux MD_EDITOR "$EMACS_COMMAND"
    # set -Ux MD_EDITOR "$VIM_COMMAND"
    # set -Ux GIT_EDITOR "$EMACS_COMMAND"
    # set -Ux GIT_EDITOR "$VIM_COMMAND"
    # set -Ux GIT_EDITOR "$VIM_COMMAND -c \"SessionNoAuto\""

    # Pager philosphy is to use use the pager for output we don't want in
    # our history because it's easy to recreate. E.g., `man` see how to use
    # a command or `bat` to see the contents of a file, we don't want in
    # our history because it's easy to grab again if we need it.
    # We only want things like compile, test, or search results in our history
    set -Ux ACK_COMMAND rg
    set -Ux COLORTERM "truecolor"

    # Prevent `npm` scripts from opening browser windows
    set -Ux BROWSER "none"

    # Homebrew
    if type -q brew
        set -Ux HOMEBREW_DIR (brew --prefix)
        set -Ux HOMEBREW_NO_ANALYTICS 1
        set -Ux HOMEBREW_NO_AUTO_UPDATE 1
        set -Ux HOMEBREW_NO_INSTALL_CLEANUP 1
        set -Ux MANPATH $MANPATH $HOMEBREW_DIR/share/man
        set -Ux INFOPATH $INFOPATH $HOMEBREW_DIR/share/info
    end

    switch (uname)
        case Darwin
            set -Ux MACOS 1
            # Setting `SDKROOT` is important, we get errors finding C libraries without this
            set -Ux SDKROOT (xcrun --sdk macosx --show-sdk-path)
    end
end
