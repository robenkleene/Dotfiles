alias mopen = ^open
alias rg = rg_custom
alias p = ^p

# function egitn
#     # The reason `egitn` has to be run seprately after `egit` is because the
#     # second time running `egit` can't print except the path.
#     set -l gitnext (~/.bin/egit -n)
#     if test -n "$gitnext"
#         cd "$gitnext"
#         pwd
#         git status
#         return 1
#     end
# end
# if test -f "$HOME/.personal"
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto" && sgitt -cp'
# else
#     # Don't automatically commit on non-personal machines
#     alias s='ssh_start && begin; egit -p || egitn; end && echo "Auto"; sgitt -p'
# end
# function ssh_start
#     switch (uname)
#         case Linux
#            if test -z $SSH_AGENT_PID
#                 eval (ssh-agent -c)
#                 ssh-add
#            end
#     end
# end

# def ssh_start [] {

# }
# def egitn [] {

# }
# def s [] {

# }


let-env config = {
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
        cmd: "cd (nu -c 'zoxide query --list' | str trim | str collect (char nl) | fzf | str trim)"
      }
    }
    {
      name: fzf_c
      modifier: alt
      keycode: char_c
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "cd (nu -c 'fd --strip-cwd-prefix --type d --hidden --follow --max-depth 1 --exclude .git --exclude .hg' | str trim | str collect (char nl) | fzf | str trim)"
      }
    }
    {
      name: fzf_o
      modifier: alt
      keycode: char_o
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "hx (nu -c 'fd --strip-cwd-prefix --type f --follow --type l --hidden --max-depth 1 --exclude .DS_Store' | str trim | str collect (char nl) | fzf | str trim)"
      }
    }
  ]
}

if ((which 'zoxide' | length) > 0) {
  let-env config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append {|_, dir|
    zoxide add -- $dir
  }))
}

