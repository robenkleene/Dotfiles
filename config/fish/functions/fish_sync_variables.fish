function fish_sync_variables
    for v in (set --names -U | grep -v "^_*fish")
        set -e $v
    end

    # set -U CDPATH . ~

    # Fish
    set -Ux fish_help_browser echo
    # Suppress default greeting
    set -U fish_greeting

    set -Ux COLORTERM "truecolor"

    # Without explicitely specifying `less` as the pager, Linux will use the
    # wrong version of `less` (system installed, which doesn't support the
    # `incsearch` option instead of Homebrew installed.
    set -Ux PAGER "less"
    # `--no-init`: Don't clear screen when quitting less
    set -Ux LESS "--no-init --RAW-CONTROL-CHARS --quit-if-one-screen --ignore-case --incsearch"

    # Emacs
    # Start the server in the background if it isn't running
    set -Ux ALTERNATE_EDITOR ""

    # Installs

    # rg
    set -Ux RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

    # fzf
    # Use `fd` for `:Files` in `fzf.vim`
    set -Ux FZF_DEFAULT_COMMAND "fd --type f"

    # nnn
    set -Ux NNN_PLUG "z:z;r:reveal;p:preview"

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
