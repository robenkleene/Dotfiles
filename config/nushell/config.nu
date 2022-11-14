source theme.nu
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

source alias.nu
source installs.nu
source commands.nu
