function fish_sync_variables
    # First delete existing variables
    for v in (set --names -U | grep -v "^_*fish")
        set -e $v
    end

    # Editor
    # Fish fails to run `edit_command_buffer` without `VISUAL` or `EDITOR` set
    set -Ux VISUAL "nvim"
    # set -Ux VISUAL "hx"
    set -Ux EDITOR $VISUAL

    # Less
    set -Ux LESS "--no-init --ignore-case --incsearch --quit-if-one-screen --RAW-CONTROL-CHARS"

    # Fish
    set -Ux fish_help_browser echo
    # Suppress default greeting
    set -U fish_greeting

    set -Ux COLORTERM "truecolor"

    # Emacs
    # Start the server in the background if it isn't running
    set -Ux ALTERNATE_EDITOR ""

    # Installs

    # rg
    set -Ux RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

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
            # Setting `SDKROOT` is important, we get errors importing C libraries without this
            set -Ux SDKROOT (xcrun --sdk macosx --show-sdk-path)
    end

    switch (uname)
        case Linux
            set -Ux LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/lib:/usr/lib/x86_64-linux-gnu"
    end
end
