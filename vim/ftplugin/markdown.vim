" vim:fdm=marker
" General
let g:markdown_folding = 1
set nofoldenable
setlocal spell
set wrap

nnoremap <localleader>p :!open -a "Marked 2.app" "%:p"<CR>\|:redraw!<CR>
