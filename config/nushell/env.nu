# Prompt
def create_left_prompt [] {
    $"(ansi blue)($env.PWD | path basename)"
}
def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%r')
    ] | str join)
    $"(ansi light_gray)($time_segment)"
}
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# Path

# fzf
let-env FZF_DEFAULT_OPTS = "--height 40% --reverse"

# Editor
let-env ALTERNATE_EDITOR = ""
let-env MD_CAT_COMMAND = "bat --style plain"
let-env VISUAL = "hx"
let-env VISUAL = "hx"
let-env TIG_EDITOR = "hx_wrapper"
let-env BROWSER = "none"

# Homebrew
let-env HOMEBREW_NO_ANALYTICS = 1
let-env HOMEBREW_NO_AUTO_UPDATE = 1
let-env HOMEBREW_NO_INSTALL_CLEANUP = 1

# set -U fish_user_paths ~/.brew/bin $fish_user_paths
# set -U fish_user_paths ~/.fzf/bin $fish_user_paths
# set -U fish_user_paths ~/.bin $fish_user_paths
    
# if test -e /opt/homebrew/bin/
#     set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
# end

# if test -e ~/.nvm/versions/node/v17.0.1/bin
#     set -U fish_user_paths ~/.nvm/versions/node/v17.0.1/bin $fish_user_paths
# end

# if test -d ~/.gem/ruby/3.0.2/bin
#     set -U fish_user_paths ~/.gem/ruby/3.0.2/bin $fish_user_paths
# end
# if test -d ~/.rubies/ruby-3.0.2/bin
#     set -U fish_user_paths ~/.rubies/ruby-3.0.2/bin $fish_user_paths
# end

# if test -d $HOME/.cargo/bin
#     set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
# end
