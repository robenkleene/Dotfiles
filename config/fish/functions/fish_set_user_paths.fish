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
    set -U fish_user_paths ~/.gem/ruby/3.0.2/bin $fish_user_paths
    # set -U fish_user_paths ~/.rubies/ruby-3.0.2/lib/ruby/gems/3.0.0/bin $fish_user_paths
    set -U fish_user_paths ~/.rubies/ruby-3.0.2/bin $fish_user_paths

end
