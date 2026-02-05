" Custom support for fenced code blocks
" E.g., on a single line `yssc` will wrap the line in a fenced code block
" Or `Sc` will wrap the visual selection
" Or `ys]`c` will wrap the last pasted text
" This is already used for wrapping in a single backtick
" Use `echo char2nr("`")` to get `96`
" For "fenced", this is already used to prompt for a function
" Use `echo char2nr("f")` to get `102`
" For "code", this is unused
" Use `echo char2nr("c")` to get `99`
" Global
" let g:surround_102 = "```\n\r\n```"
" Only Markdown
augroup surround_markdown
  autocmd!
  autocmd FileType markdown let b:surround_99 = "```\n\r\n```"
augroup END
