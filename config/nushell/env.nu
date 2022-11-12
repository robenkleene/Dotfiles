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
let-env FZF_DEFAULT_OPTS = "--height 40% --reverse"
