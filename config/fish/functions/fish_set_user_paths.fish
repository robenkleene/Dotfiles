function fish_set_user_paths
    set -U fish_user_paths
    set -U fish_user_paths ~/.brew/bin $fish_user_paths
    set -U fish_user_paths ~/.fzf/bin $fish_user_paths
    set -U fish_user_paths ~/.bin $fish_user_paths

    # Python
    switch (uname)
        case Linux
            set -U fish_user_paths ~/.local/bin $fish_user_paths
        case Darwin
            set -U fish_user_paths /usr/local/bin $fish_user_paths
            set -U fish_user_paths ~/Library/Python/3.9/bin $fish_user_paths
    end

    # llvm
    switch (uname)
        case Darwin
            set -U fish_user_paths /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin $fish_user_paths
    end

    # Support user homebrew install
    if test -e ~/.brew/bin
        set -U fish_user_paths ~/.brew/bin $fish_user_paths
    end

    if test -e /opt/homebrew/bin/
        set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
    end

    # Node
    if test -e ~/.config/nvm/17.0.1/bin
        set -U fish_user_paths ~/.config/nvm/17.0.1/bin $fish_user_paths
    else if test -e ~/.nvm/versions/node/v17.0.1/bin
        set -U fish_user_paths ~/.nvm/versions/node/v17.0.1/bin $fish_user_paths
    end

    # Ruby
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

    # Android
    if test -n "$ANDROID_SDK"
        fish_add_path {$ANDROID_SDK}/emulator {$ANDROID_SDK}/tools {$ANDROID_SDK}/tools/bin {$ANDROID_SDK}/platform-tools
    end
end
