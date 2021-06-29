let b:FormatPrg = "fish_indent"

nnoremap <leader>f :Format<CR>

" For editing the command line in Vim which uses a temporary file outside of
" the home directory which therefore doesn't load the `editorconfig`
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
