if command -sq fasd
    function __fasd_run -e fish_preexec -d "fasd takes record of the directories changed into"
        if test $argv[1] != "exit"
            command fasd --proc (command fasd --sanitize "$argv") >"/dev/null" 2>&1 &
        end
    end
end

# Ruby
source ~/.config/fish/vendor/chruby/chruby.fish
source ~/.config/fish/vendor/chruby/auto.fish

# Python
switch (uname)
    case Linux
        set -U fish_user_paths ~/Library/Python/3.8/bin $fish_user_paths
    case Darwin
        set -U fish_user_paths ~/.local/bin $fish_user_paths
end

# Node
set -U fish_user_paths ~/.nvm/versions/node/v13.12.0/bin $fish_user_paths

# llvm
switch (uname)
    case Darwin
        set -U fish_user_paths /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin $fish_user_paths
        set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)
end
