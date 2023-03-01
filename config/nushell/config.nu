source alias.nu
source commands.nu
source fzf.nu

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
        ~/.bin/z_add $after
      }]
    }
  }
  keybindings: [
    {
      name: ctrl_w
      modifier: Control
      keycode: char_w
      mode: emacs
      event: { edit: CutBigWordLeft }
    }
    {
      name: fzf_z
      modifier: alt
      keycode: char_z
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "fzf_z"
      }
    }
    {
      name: fzf_o
      modifier: alt
      keycode: char_o
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "fzf_o"
      }
    }
  ]
}

