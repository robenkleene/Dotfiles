alias mopen = ^open
alias rg = rg_custom
alias p = ^p

# if test -f "$HOME/.personal"
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
# else
#     # Don't automatically commit on non-personal machines
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
# end

# def s [] {

# }
# def u [] {

# }
# def ut [] {

# }
# def ua [] {

# }

def-env egitn [] {
  let gitnext = (~/.bin/egit -n)
  if (($gitnext | length) > 0) {
    pwd
    git status
  }
  cd (if (($gitnext | length) > 0) {
    $gitnext
  } else {
    .
  })
}

def ssh_start [] {
  if ((uname | str trim) == "Linux") {
    ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -i -r -d | load-env
  }
}

let-env config = {
  # table_mode: none
  # table_mode: compact
  table_mode: light
  table_trim: {
    methodology: truncating,
    wrapping_try_keep_words: true,
  }
  show_banner: false
  # Keep hooks keys so they can be programatically editting
  hooks: {
    pre_prompt: [{
      $nothing
    }]
    pre_execution: [{
      $nothing
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing
      }]
    }
  }    
  keybindings: [
    # This doesn't work because the command is evaluated at initialization,
    # instead of after the binding is triggered
    # {
    #   name: ctrl_v
    #   modifier: control
    #   keycode: Char_v
    #   mode: emacs
    #   event: {
    #     edit: insertstring
    #     value: $"(~/.bin/safepaste)"
    #   }
    # }
    {
      name: fzf_z
      modifier: alt
      keycode: char_z
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "cd (zoxide query --list | str trim | str collect (char nl) | fzf | str trim)"
      }
    }
    {
      name: fzf_c
      modifier: alt
      keycode: char_c
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "cd (fd --strip-cwd-prefix --type d --hidden --follow --max-depth 1 --exclude .git --exclude .hg | str trim | str collect (char nl) | fzf | str trim)"
      }
    }
    {
      name: fzf_o
      modifier: alt
      keycode: char_o
      mode: emacs
      event: {
        send: executehostcommand
        cmd: ($"($env.EDITOR) " + "(fd --strip-cwd-prefix --type f --follow --type l --hidden --max-depth 1 --exclude .DS_Store | str trim | str collect (char nl) | fzf | str trim)")
      }
    }
  ]
}

if ((which 'zoxide' | length) > 0) {
  let-env config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append {|_, dir|
    zoxide add -- $dir
  }))
}

