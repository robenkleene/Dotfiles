function fish_set_user_paths
    set -U fish_user_paths

    # Python
    switch (uname)
        case Linux
            set -U fish_user_paths ~/.local/bin $fish_user_paths
        case Darwin
            set -U fish_user_paths /usr/local/bin $fish_user_paths
            set -U fish_user_paths ~/Library/Python/3.11/bin $fish_user_paths
    end

    if test -e ~/.brew/bin
        set -U fish_user_paths ~/.brew/bin $fish_user_paths
    end
    if test -e ~/.bin
        set -U fish_user_paths ~/.bin $fish_user_paths
    end

    # llvm
    switch (uname)
        case Darwin
            set -U fish_user_paths /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin $fish_user_paths
    end

    # Node
    # Never install `nvm.fish` because it'll conflict with the way `nvm` is installed via the dotfiles installed script (`~/Developer/Dotfiles/install/node`)
    # If I do need to support `nvm`, it's a good idea to switch to using `fisher` and install the plugin
    if test -e ~/.nvm/versions/node/v21.6.1/bin
        set -U fish_user_paths ~/.nvm/versions/node/v21.6.1/bin $fish_user_paths
    end

    # Ruby
    # Never install `chruby.fish` for the same reasons at `nvm.fish`, need a coherent strategy for supporting Bash and fish version management installs
    if test -d ~/.gem/ruby/3.0.2/bin
        set -U fish_user_paths ~/.gem/ruby/3.0.2/bin $fish_user_paths
    end
    if test -d ~/.rubies/ruby-3.0.2/bin
        set -U fish_user_paths ~/.rubies/ruby-3.0.2/bin $fish_user_paths
    end

    # Python
    if test -d $PYENV_ROOT/bin
        set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
    end

    # Rust
    if test -d $HOME/.cargo/bin
        set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
    end

    # Local
    if test -f ~/.local_paths.fish
        source ~/.local_paths.fish
    end
end
