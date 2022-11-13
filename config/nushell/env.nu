# Prompt
def create_left_prompt [] {
    $"(ansi light_gray)(date format '%r') (ansi light_gray)(whoami | str trim)(ansi reset)@(ansi yellow)(hostname | str trim)(ansi cyan) ($env.PWD | path basename)"
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
let-env PATH = ($env.PATH | prepend '/opt/homebrew/bin/')

# fzf
let-env FZF_DEFAULT_OPTS = "--height 40% --reverse"

# Editor
let-env ALTERNATE_EDITOR = ""
let-env MD_CAT_COMMAND = "bat --style plain"
let-env VISUAL = "hx"
let-env EDITOR = $"($env.VISUAL)"
let-env TIG_EDITOR = "hx_wrapper"
let-env BROWSER = "none"

# Homebrew
let-env HOMEBREW_NO_ANALYTICS = 1
let-env HOMEBREW_NO_AUTO_UPDATE = 1
let-env HOMEBREW_NO_INSTALL_CLEANUP = 1

