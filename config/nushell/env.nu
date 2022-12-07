source ~/.local.nu

# Prompt
def create_left_prompt [] {
    let prompt = $"(ansi reset)(ansi light_gray)(date format '%r')(ansi reset)"
    let prompt = if ("SSH_CONNECTION" in (env).name) {
        # $prompt + $"(whoami | str trim)(ansi reset)@(ansi yellow)(hostname | str trim) "
        $prompt + $" (ansi yellow)(hostname | str trim)"
    } else {
        $prompt
    }
    let prompt = $prompt + $" (ansi cyan_bold)($env.PWD | path basename)(ansi reset)"
    let prompt = if ($env.LAST_EXIT_CODE > 0) {
        $prompt + $" (ansi red)($env.LAST_EXIT_CODE)(ansi reset)"
    } else {
        $prompt
    }
    $prompt
}
def create_right_prompt [] {
    # let time_segment = ([
    #     (date now | date format '%r')
    # ] | str join)
    # $"(ansi light_gray)($time_segment)"
    ""
}
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# Path
# Fix for unsplit path by default
let-env PATH = ($env.PATH | split row ":")
# Loop not working on macOS?
# let paths = [
# '~/.bin'
# '~/.fzf/bin'
# '/opt/homebrew/bin/'
# '~/.nvm/versions/node/v17.0.1/bin'
# '~/.gem/ruby/3.0.2/bin'
# '~/.rubies/ruby-3.0.2/bin'
# '~/.cargo/bin'
# ]
# $paths | each { |path|
#     if ($path | path exists) {
#         let-env PATH = ($env.PATH | prepend '/opt/homebrew/bin/')
#     }
# }
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.bin")
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.fzf/bin")
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.nvm/versions/node/v17.0.1/bin")
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.gem/ruby/3.0.2/bin")
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.rubies/ruby-3.0.2/bin")
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.cargo/bin")
let-env PATH = ($env.PATH | prepend '/opt/homebrew/bin')
let-env PATH = ($env.PATH | prepend $"($env.HOME)/.brew/bin")

# fzf
let-env FZF_DEFAULT_OPTS = "--height 40% --reverse"

# Emacs
let-env ALTERNATE_EDITOR = ""
let-env EMACS_COMMAND = "emacsclient -nw"

let-env MD_CAT_COMMAND = "bat --style plain"
let-env MD_EDITOR_COMMAND = $"($env.EMACS_COMMAND)"

let-env VISUAL = "nvim"
let-env EDITOR = $"($env.VISUAL)"
let-env LESS = "--RAW-CONTROL-CHARS --quit-if-one-screen --ignore-case --incsearch"

# hx
# let-env VISUAL = "hx"
# let-env TIG_EDITOR = "hx_wrapper"

let-env VIM_COMMAND = "nvim"

let-env BROWSER = "none"
let-env COLORTERM = "truecolor"

# Homebrew
let-env HOMEBREW_NO_ANALYTICS = 1
let-env HOMEBREW_NO_AUTO_UPDATE = 1
let-env HOMEBREW_NO_INSTALL_CLEANUP = 1

let-env NU_LIB_DIRS = [
    '~/.nu_local'
    ($nu.config-path | path dirname | path join 'source')
]

