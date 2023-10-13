# Emacs IBuffer

- `u`: Unmark buffer
- `m`: Mark buffer
- `t`: Invert marked buffers
- `D`: Kill (close) marked buffers
- `* M`: Mark buffers by major mode
- `U t` (or `* s`): Mark all buffers

## On Marked Buffers

- `M-s a C-s`: Do incremental search in the marked buffers.
- `M-s a C-M-s`: Isearch for regexp in the marked buffers.
- `U`: Replace by regexp in each of the marked buffers.
- `Q`: Query replace in each of the marked buffers.
- `I`: As above, with a regular expression.
- `0`: Run occur on the marked buffers.

## Sort

- `,`: Rotate through sorting option
- `s i`: Reverse sorting order
- `s a`: Sort the buffers alphabetically
- `s f`: Sort the buffers by file name
- `s v`: Sort the buffers by last viewed
- `s s`: Sort the buffers by size
- `s m`: Sort the buffers by major mode
