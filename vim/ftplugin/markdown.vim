let b:FormatPrg = "prettier --parser markdown"

" General
" Turning this on was causing performance issues when editing markdown files,
" but it disables folds
" `set nofoldenable` doesn't help
" An easy way to test the slowness is to run an operator like title case on a
" title
let g:markdown_folding = 1
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
nnoremap <buffer> <localleader>R :silent !open -a "Repla.app" "%:p"<CR>\|:redraw!<CR>

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

command! InsertTitle call <SID>InsertTitle()
function! s:InsertTitle() abort
  silent exe "normal! i\<C-r>=system('~/.bin/markdown_title '.fnameescape(expand('%:p')))\<CR>\<ESC>"
endfunction
nnoremap <buffer> <localleader>t :InsertTitle<CR>

command! -range=% TodoToggle call <SID>MarkdownTodo('-i', <line1>, <line2>)
command! -range=% TodoCheck call <SID>MarkdownTodo('-c', <line1>, <line2>)
command! -range=% TodoUncheck call <SID>MarkdownTodo('-u', <line1>, <line2>)
function! s:MarkdownTodo(flags, start, end) abort
  echom "normal! :".a:start.",".a:end."!markdown_check ".a:flags
  silent exe "normal! :".a:start.",".a:end."!markdown_check ".a:flags
endfunction
nnoremap <silent> <localleader>bt :set opfunc=<SID>MarkdownTodoInvert<CR>g@
nnoremap <silent> <localleader>bc :set opfunc=<SID>MarkdownTodoCheck<CR>g@
nnoremap <silent> <localleader>bu :set opfunc=<SID>MarkdownTodoUncheck<CR>g@
vnoremap <silent> <localleader>bt :<C-U>call <SID>MarkdownTodoInvert(visualmode(), 1)<CR>
vnoremap <silent> <localleader>bc :<C-U>call <SID>MarkdownTodoCheck(visualmode(), 1)<CR>
vnoremap <silent> <localleader>bu :<C-U>call <SID>MarkdownTodoUncheck(visualmode(), 1)<CR>
function! s:MarkdownTodoInvert(type, ...) abort
  call <SID>MarkdownTodoOperator(a:type, '-i', a:0)
endfunction
function! s:MarkdownTodoCheck(type, ...) abort
  call <SID>MarkdownTodoOperator(a:type, '-c', a:0)
endfunction
function! s:MarkdownTodoUncheck(type, ...) abort
  call <SID>MarkdownTodoOperator(a:type, '-u', a:0)
endfunction
function! s:MarkdownTodoOperator(type, flags, visual) abort
  " `@@` is an alias for `@"`, the unnamed register
  let reg_save = @@
  let reg_save2 = @*

  if a:visual
    " Visual
    silent exe "normal! gvc\<C-r>=system('~/.bin/markdown_check '.a:flags,@@)\<CR>\<ESC>"
  elseif a:type == 'line' " Line
    " Line
    silent exe "normal! '[V']c\<C-r>=system('~/.bin/markdown_check '.a:flags,@@)\<CR>\<ESC>"
  else
    " Character
    silent exe "normal! `[v`]c\<C-r>=system('~/.bin/markdown_check '.a:flags,@@)\<CR>\<ESC>"
  endif

  let @@ = reg_save
  let @* = reg_save2
endfunction
