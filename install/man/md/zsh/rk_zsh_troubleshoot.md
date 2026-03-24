- `zsh -f`: Open with no `.zshrc`

# Misaligned Output

Newlines move down but don't return to column 0, caused when a program (e.g., `vim`, `hg`, curses apps) disabled `onlcr` in the kernel TTY line discipline via `tcsetattr()` and exited without restoring it, i.e., `\n` no longer maps to `\r\n`.

- `reset`: `ncurses` binary (not a shell builtin), resets both kernel TTY state and sends terminal emulator reset sequences via `terminfo`
- `stty sane`: restores kernel TTY settings to defaults (re-enables `onlcr`)
- `printf '\033c'`: VT100 reset escape sequence, resets terminal emulator state
