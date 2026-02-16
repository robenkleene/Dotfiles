- `-q`, `--no-init-file`: Load with default settings
- `-nw`, `--no-window-system`: By default Emacs will open a new buffer in GUI window, use `-nw` to open Emacs in the terminal

# macOS

On macOS, doing `emacs <file>` has a couple of caveats:

1. The `emacs <file>` process will not exit until the frame is closed, so the terminal that `emacs <file>` was run from won't be usable until the frame is closed.
2. `emacs <file>` opens a separate instance of `Emacs.app`, so a separate Dock icon will appear for example.

For these reasons, it's generally better on macOS to have `emacs <file>` behave as `emacs -nw`, and open a file in GUI Emacs with `open -a Emacs <file>`
