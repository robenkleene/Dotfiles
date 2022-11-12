# Prompt
def create_left_prompt [] {
    # $"(ansi yellow) (date format '%r') (ansi reset) ' ' (ansi g) (whoami) '@' (hostname) (ansi reset) ' ' (ansi r) (pwd) (ansi reset) ' '"
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
let paths = [
'~/.bin'
'~/.fzf/bin'
'/opt/homebrew/bin/'
'~/.bin'
'~/.nvm/versions/node/v17.0.1/bin'
'~/.gem/ruby/3.0.2/bin'
'~/.rubies/ruby-3.0.2/bin'
'~/.cargo/bin'
]
$paths | each { |path|
    if ($path | path exists) {
        let-env PATH = ($env.PATH | prepend $path)
    }
}

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

