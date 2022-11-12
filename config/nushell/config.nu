alias mopen = ^open

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

