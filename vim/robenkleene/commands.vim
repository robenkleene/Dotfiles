" Colors
if exists("*synstack")
  " Syntax Groups
  function! s:SyntaxGroups()
    return join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))
  endfunc
  " Echo Syntax Group
  command! SyntaxEchoGroups :echo <SID>SyntaxGroups()
  " Yank Syntax Group
  command! SyntaxYankGroups :let @" = <SID>SyntaxGroups()|:let @+ = @"|:echo @"

  " Syntax Colors
  function! s:SyntaxColors()
    let syntaxcolors = 'fg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg")
    let syntaxcolors .= ' fg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")
    let syntaxcolors .= ' bg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg")
    let syntaxcolors .= ' bg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")
    let syntaxcolors .= ' sp:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp")
    let syntaxcolors .= ' sp#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp#")
    let syntaxcolors .= ' italic:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"italic")
    let syntaxcolors .= ' reverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"reverse")
    let syntaxcolors .= ' inverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"inverse")
    let syntaxcolors .= ' standout:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"standout")
    let syntaxcolors .= ' underline:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"underline")
    let syntaxcolors .= ' undercurl:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"undercurl")
    return syntaxcolors
  endfunc
  " Echo Syntax Colors
  command! EchoSyntaxColors :echo <SID>SyntaxColors()
endif
" Also remember `:XtermColorTable`
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

" Quit and save contents of buffer to the clipboard
command! -bang Q
      \ execute "%w !pbcopy" |
      \ if <bang>1 |
      \   execute "q" |
      \ else |
      \   execute "q<bang>" |
      \ endif

" Quit and save session
command! -bang QS
      \ execute "SaveSession" |
      \ if <bang>1 |
      \   execute "qa!" |
      \ else |
      \   execute "qa" |
      \ endif
command! -bang QSL
      \ execute "SaveSessionLocal" |
      \ if <bang>1 |
      \   execute "qa!" |
      \ else |
      \   execute "qa" |
      \ endif

" Make the current buffer a grep buffer
command! GrepBuffer :call <SID>GrepBuffer()
function! s:GrepBuffer()
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  if line('$') == 1
    " Don't show the quickfix list if there's exactly one match
    execute "cbuffer"
  else
    execute "cbuffer | cw | wincmd k"
    " Bigger version below 
    " execute "cbuffer | copen 20 | wincmd k"
  endif
endfunction

" Save and Restore Session State
command! SaveSessionLocal :mksession! vim_session
command! RestoreSessionLocal :source vim_session
command! SaveSession :mksession! ~/.vim/vim_session
command! RestoreSession :source ~/.vim/vim_session
cnoreabbrev SS SaveSession
cnoreabbrev RS RestoreSession

" Rg
if exists(':terminal')
  command! -nargs=* Rg call <SID>Rg(<f-args>)
  function! s:Rg(args) abort
    " Not sure why this is necessary, copied from `vim-fugitive`
    let args = matchstr(a:args,'\v\C.{-}%($|\\@<!%(\\\\)*\|)@=')
    if expand('%') != ''
      -tabedit %
    else
      -tabnew
    endif
    execute 'terminal rg --smart-case --line-number' args
  endfunction
endif

" Add `git` hunks to `quickfix`
command! Ghunks cexpr system('git diff --relative \| dtg')
