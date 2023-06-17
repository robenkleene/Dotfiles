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
    set -Ux MD_CAT_COMMAND "bat --style plain"
    set -Ux MD_EDITOR_COMMAND "$EMACS_COMMAND"
    # set -Ux CD_COMMAND "vim_cd"
    set -Ux CD_COMMAND "emacs_cd"

    # hx
    # set -Ux VISUAL "hx"
    # set -Ux TIG_EDITOR "hx_wrapper"

    # Standard
    # Without explicitely specifying `less` as the pager, Linux will use the
    # wrong version of `less` (system installed, which doesn't support the
    # `incsearch` option instead of Homebrew installed.
    set -Ux PAGER "less"
    set -Ux LESS "--RAW-CONTROL-CHARS --quit-if-one-screen --ignore-case --incsearch"
    set -Ux VISUAL "$VIM_COMMAND"
    # set -Ux VISUAL "$EMACS_COMMAND"
    set -Ux EDITOR "$VISUAL"
    # Prevent `npm` scripts from opening browser windows
    set -Ux BROWSER "none"
    set -Ux COLORTERM "truecolor"

    # nnn
    set -Ux NNN_PLUG 'z:fzf_z;c:fzf_subdir;-:fzf_parentdir'

    # Homebrew
    if type -q brew
        set -Ux HOMEBREW_DIR (brew --prefix)
        set -Ux HOMEBREW_NO_ANALYTICS 1
        set -Ux HOMEBREW_NO_AUTO_UPDATE 1
        set -Ux HOMEBREW_NO_INSTALL_CLEANUP 1
        set -Ux HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK 1
        set -Ux MANPATH $MANPATH $HOMEBREW_DIR/share/man
        set -Ux INFOPATH $INFOPATH $HOMEBREW_DIR/share/info
    end

    # Ruby
    # `zsh` has `chruby` setup, so to configure these in fish, get the values
    # of these environment variables from `zsh`
    set -Ux GEM_HOME "$HOME/.gem/ruby/3.0.2"
    set -Ux GEM_PATH "$HOME/.gem/ruby/3.0.2:/Users/robenkleene/.rubies/ruby-3.0.2/lib/ruby/gems/3.0.0"
    set -Ux GEM_ROOT "$HOME/.rubies/ruby-3.0.2/lib/ruby/gems/3.0.0/"

    switch (uname)
        case Darwin
            set -Ux MACOS 1
            # Setting `SDKROOT` is important, we get errors finding C libraries without this
            set -Ux SDKROOT (xcrun --sdk macosx --show-sdk-path)
    end
end
