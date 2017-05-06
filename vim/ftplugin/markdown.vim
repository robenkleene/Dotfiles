" General
let g:markdown_folding = 1
set nofoldenable
setlocal spell
set wrap

" Don't show 80 character guide
" setlocal colorcolumn=""

nnoremap <localleader>P :!open -a "Marked 2.app" "%:p"<CR>\|:redraw!<CR>
nnoremap <localleader>t :.!markdown-title "%"<CR>


" Convert
if exists(':terminal')
  command! -nargs=* ConvertMarkdown call <SID>ConvertMarkdown(<f-args>)
  function! s:ConvertMarkdown(args) abort
    " Not sure why this is necessary, copied from `vim-fugitive`
    let args = matchstr(a:args,'\v\C.{-}%($|\\@<!%(\\\\)*\|)@=')
    if expand('%') != ''
      -tabedit %
    else
      -tabnew
    endif
    execute 'terminal pandoc -f markdown -t html' args
  endfunction
endif
nnoremap <localleader>c :ConvertMarkdown %<CR>

" Follow file links
" Search for `](` go right twice and then `gf`, etc...
" TODO: This really should be made to only work with file URLs and relative
" files. Right now it also works with regular URLs which causes Netrw to curl
" the web page and open it in a temporary buffer.
" nnoremap <buffer> <CR> ^/](<CR>2lgf
" nnoremap <buffer> <C-w><CR> ^/](<CR>2l<C-w>f
" nnoremap <buffer> <C-w>g<CR> ^/](<CR>2l<C-w>gf
