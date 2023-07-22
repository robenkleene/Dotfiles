function fish_sync_variables
    for v in (set --names -U | grep -v "^_*fish")
        set -e $v
    end

    # Fish
    set -Ux fish_help_browser echo
    # Suppress default greeting
    set -U fish_greeting

    # fzf
    # Use `fd` for `:Files` in `fzf.vim`
    set -Ux FZF_DEFAULT_COMMAND "fd --type f"
    # Setup editors first so others can depend on them
    # Vim
    set -Ux VIM_COMMAND nvim
    # set -Ux VIM_COMMAND vim
    # Emacs
    # Start the server in the background if it isn't running
    set -Ux ALTERNATE_EDITOR ""
    set -Ux EMACS_COMMAND "emacsclient -nw"

    # Standard
    # Without explicitely specifying `less` as the pager, Linux will use the
    # wrong version of `less` (system installed, which doesn't support the
    # `incsearch` option instead of Homebrew installed.
    set -Ux PAGER "less"
    # `--no-init`: Don't clear screen when quitting less
    set -Ux LESS "--no-init --RAW-CONTROL-CHARS --quit-if-one-screen --ignore-case --incsearch"
    set -Ux VISUAL "$VIM_COMMAND"
    # set -Ux VISUAL "$EMACS_COMMAND"
    set -Ux EDITOR "$VISUAL"
    # Prevent `npm` scripts from opening browser windows
    # This breaks `gh browse`
    # set -Ux BROWSER "none"
    set -Ux COLORTERM "truecolor"

    # Other
    set -Ux MD_CAT_COMMAND "bat --style plain"
    # MD_EDITOR_COMMAND fallsback to EDITOR if not set
    # set -Ux MD_EDITOR_COMMAND "$EMACS_COMMAND"
    # set -Ux CD_COMMAND "vim_cd"
    set -Ux CD_COMMAND "emacs_cd"

    # hx
    # set -Ux VISUAL "hx"
    # set -Ux TIG_EDITOR "hx_wrapper"

    # nnn
    set -Ux NNN_PLUG "z:fzf_z;r:reveal;o:ls_fzf;p:preview"

    # Homebrew
    if type -q brew
        set -Ux HOMEBREW_DIR (brew --prefix)
        set -Ux HOMEBREW_NO_ANALYTICS 1
        set -Ux HOMEBREW_NO_AUTO_UPDATE 1
        set -Ux HOMEBREW_NO_INSTALL_CLEANUP 1
        set -Ux HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK 1
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
