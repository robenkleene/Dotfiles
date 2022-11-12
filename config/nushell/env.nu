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

# fzf
let-env FZF_DEFAULT_COMMAND = 'fd --strip-cwd-prefix --type f --follow --type l --hidden --exclude .git --exclude .hg --exclude .DS_Store'
let-env FZF_ALL_COMMAND = 'fd --strip-cwd-prefix --hidden --follow --exclude .git --exclude .hg --exclude .DS_Store'
let-env FZF_DEFAULT_OPTS = "--height 40% --reverse"
let-env FZF_ALT_C_COMMAND = 'fd --strip-cwd-prefix --type d --hidden --follow --exclude .git --exclude .hg'
