source alias.nu
source commands.nu
source zoxide.nu
source nnn.nu

$env.config = {
  show_banner: false,
  keybindings: [
    {
      name: ctrl_w
      modifier: Control
      keycode: char_w
      mode: emacs
      event: { edit: CutBigWordLeft }
    }
  ]
}
