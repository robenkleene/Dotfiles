map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" Suppress the extra space after `//` for processing files
" Without `b:commentary_format` commentary adds this by default
augroup commentary_format
  autocmd!
  autocmd FileType processing :let b:commentary_format = &commentstring
augroup END
