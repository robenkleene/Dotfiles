alias mopen = ^open

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

