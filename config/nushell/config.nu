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
        event: [
            { edit: clear }
            { edit: insertstring value: 'cd (fasd -Rdl | str collect (char nl) | fzf | str trim)' }
            { send: enter }
        ]
    }
    {
        name: fzf_c
        modifier: alt
        keycode: char_z
        mode: emacs
        event: [
            { edit: clear }
            { edit: insertstring value: 'cd (fasd -Rdl | str collect (char nl) | fzf | str trim)' }
            { send: enter }
        ]
    }
  ]
}
