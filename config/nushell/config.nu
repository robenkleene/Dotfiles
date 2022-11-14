source alias.nu
source commands.nu
source theme.nu
source fzf.nu

let-env config = {
  color_config: $dark_theme
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
      name: fzf_c
      modifier: alt
      keycode: char_c
      mode: emacs
      event: {
        send: executehostcommand
        cmd: "fzf_c"
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

source installs.nu
