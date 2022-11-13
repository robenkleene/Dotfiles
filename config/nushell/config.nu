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
  hooks: {
    env_change: {
      PWD: [{|before, after|
        fasd -A $after
      }]
    }
  }
  keybindings: [
    {
      name: fzf_z
      modifier: alt
      keycode: char_z
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "cd (nu -c 'fasd -Rdl' | str collect (char nl) | fzf | str trim)"
      }
    }
  ]
}

