function fish_set_user_paths
    set -U fish_user_paths
    set -U fish_user_paths /usr/local/bin $fish_user_paths
    set -U fish_user_paths ~/.fzf/bin $fish_user_paths
    set -U fish_user_paths ~/.bin $fish_user_paths

    # Python
    switch (uname)
        case Linux
            set -U fish_user_paths ~/.local/bin $fish_user_paths
        case Darwin
            set -U fish_user_paths ~/Library/Python/3.9/bin $fish_user_paths
    end

    # Support local homebrew install
    if test -e ~/.brew/bin
        set -U fish_user_paths ~/.brew/bin $fish_user_paths
    end

    # Node
    set -U fish_user_paths ~/.nvm/versions/node/v13.12.0/bin $fish_user_paths

    # llvm
    switch (uname)
        case Darwin
            set -U fish_user_paths /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin $fish_user_paths
    end
end
