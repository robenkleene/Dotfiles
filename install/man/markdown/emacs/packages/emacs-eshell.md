# Emacs Eshell

- `C-c C-u`: Clear line
- `C-c C-p` / `C-c C-n`: Go to previous / next prompt
- `C-c C-o`: Kill output of previous command
- `C-p` / `C-n`: Go to previous / next line

## Buffers

- `C-c M-b`: Choose a buffer and insert it, e.g., `$ echo "Hello World" >>` then `C-c M-b`, choose buffer name to pipe to that buffer

## Piping

- `$ echo "Hello World" > #<*echo output*>`: Output to a new buffer name `*echo output*`

## Alias

- `alias a 'rg_custom $*'`: Example alias
- `eshell-read-aliases-list`: Reload aliases from `~/emacs.d/eshell/alias` (this needs to be run in eshell)
