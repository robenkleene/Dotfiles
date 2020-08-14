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


" command! -range=% MarkdownTodoInvert <line1>,<line2>call <SID>MarkdownTodo('-i')
" command! -range=% MarkdownTodoCheck <line1>,<line2>call <SID>MarkdownTodo('-c')
" command! -range=% MarkdownTodoUncheck <line1>,<line2>call <SID>MarkdownTodo('-u')

" nnoremap <silent> <localleader>ti :set opfunc=<SID>MarkdownTodo<CR>g@
" nnoremap <silent> <localleader>tc :set opfunc=<SID>MarkdownTodo<CR>g@
" nnoremap <silent> <localleader>tu :set opfunc=<SID>MarkdownTodo('')<CR>g@
" vnoremap <silent> <localleader>s :<C-U>call operators#SlugProjectLink(visualmode(), 1)<CR>

" function! operators#SlugProjectLink(type, flags, ...) abort
"   " `@@` is an alias for `@"`, the unnamed register
"   let reg_save = @@
"   let reg_save2 = @*

"   if a:0
"     " Visual
"     silent exe "normal! gvc\<C-r>=system('~/.bin/markdown_check -i '.fnameescape(expand('%:h')).'/projects/',@@.\"\\n\")\<CR>\<ESC>"
"   elseif a:type == 'line' " Line
"     " Line
"     silent exe "normal! '[V']c\<C-r>=system('~/.bin/markdown_check -i '.fnameescape(expand('%:h')).'/projects/',@@.\"\\n\")\<CR>\<ESC>"
"   else
"     " Character
"     silent exe "normal! `[v`]c\<C-r>=system('~/.bin/markdown_check -i '.fnameescape(expand('%:h')).'/projects/',@@.\"\\n\")\<CR>\<ESC>"
"   endif

"   let @@ = reg_save
"   let @* = reg_save2
" endfunction


" execute a:firstline "," a:lastline "yank"

" function! commands#Execute() abort
"   if !exists('b:ExecutePrg')
"     echo "No b:ExecutePrg defined"
"     return
"   endif
"   execute "%w !" . b:ExecutePrg
" endfunction

" function! commands#ExecuteVisual() abort
"   if !exists('b:ExecutePrg')
"     echo "No b:ExecutePrg defined"
"     return
"   endif
"   execute "'<,'>w !" . b:ExecutePrg
" endfunction


" function! operators#SlugProjectLink(type, ...) abort
"   " `@@` is an alias for `@"`, the unnamed register
"   let reg_save = @@
"   let reg_save2 = @*

"   if a:0
"     " Visual
"     silent exe "normal! gvc\<C-r>=system('~/.bin/slug_project -l -d '.fnameescape(expand('%:h')).'/projects/',@@.\"\\n\")\<CR>\<ESC>"
"   elseif a:type == 'line' " Line
"     " Line
"     silent exe "normal! '[V']c\<C-r>=system('~/.bin/slug_project -l -d '.fnameescape(expand('%:h')).'/projects/',@@.\"\\n\")\<CR>\<ESC>"
"   else
"     " Character
"     silent exe "normal! `[v`]c\<C-r>=system('~/.bin/slug_project -l -d '.fnameescape(expand('%:h')).'/projects/',@@.\"\\n\")\<CR>\<ESC>"
"   endif

"   let @@ = reg_save
"   let @* = reg_save2
" endfunction

" function! bindings#LinkSourceControlMarkdownYankQuotedLines() range abort
"   let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/.bin/link_source_control_markdown --quote --line-number '.line('.').' '.fnameescape(expand('%:p')))
"   let @* = @"
"   echo "Yanked git Markdown link"
" endfunction
