let b:FormatPrg = "prettier --parser markdown"

" General
" Turning this on was causing performance issues when editing markdown files,
" but it disables folds
" `set nofoldenable` doesn't help
" An easy way to test the slowness is to run an operator like title case on a
" title
" let g:markdown_folding = 1
setlocal spell
set wrap

" Don't show 80 character guide
" Reason for having this off: it's confusing because there's no way to soft
" wrap to the `colorcolumn`.
" Reason for having this on: As a convention, code blocks in markdown should
" be less than `80` characters long.
" setlocal colorcolumn=""

nnoremap <buffer> <localleader>P :!open -a "Marked 2.app" "%:p"<CR>\|:redraw!<CR>
nnoremap <buffer> <leader>P :!open -a "Marked 2.app" "%:p"<CR>\|:redraw!<CR>

nnoremap <silent> <buffer> <localleader>lr :set opfunc=operators#LinkReplace<CR>g@
vnoremap <silent> <buffer> <localleader>lr :<C-U>call operators#LinkReplace(visualmode(), 1)<CR>

nnoremap <buffer> <localleader>W :!open -a "iA Writer.app" "%:p"<CR>\|:bd<CR>
nnoremap <buffer> <localleader>R :!open -a "Repla.app" "%:p"<CR>\|:bd<CR>

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
    tnoremap <buffer> <Esc> <C-\><C-n>
  endfunction
endif
" Can't use `<localleader>c` because that's title case operator
" nnoremap <buffer> <localleader>c :ConvertMarkdown %<CR>
