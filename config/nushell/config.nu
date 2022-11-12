let-env config = {
  show_banner: false
  hooks: {
    pre_prompt: [{
      $nothing  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{
      $nothing  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing  # replace with source code to run if the PWD environment is different since the last repl input
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
    {
        name: fzf_cd
        modifier: alt
        keycode: char_c
        mode: emacs
        event: {
          send: executehostcommand
          cmd: "cd (nu -c $env.FZF_ALT_C_COMMAND | str collect (char nl) | fzf | str trim)"
        }
    }
    {
      name: fzf_edit
      modifier: alt
      keycode: char_o
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "nu -c $env.EDITOR (nu -c $env.FZF_CTRL_T_COMMAND | str collect (char nl) | fzf | str trim)"
      }
    }
  ]
}


