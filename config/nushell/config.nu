source alias.nu
source commands.nu
source zoxide.nu
source nnn.nu

$env.config = {
  show_banner: false,
  cursor_shape: {
    # Prevent nushell from changing the cursor shape because it doesn't change
    # it back when exiting
    emacs: block
  },
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
