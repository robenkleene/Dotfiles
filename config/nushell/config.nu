source alias.nu
source commands.nu

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
      name: open_dir
      modifier: alt
      keycode: char_r
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "open_dir"
      }
    }
  ]
}

