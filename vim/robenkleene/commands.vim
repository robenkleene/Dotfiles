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
  command! SyntaxEchoColors :echo <SID>SyntaxColors()
endif
" Also remember `:XtermColorTable`
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

" Make the current buffer a grep buffer
command! GrepBuffer :call <SID>GrepBuffer()
function! s:GrepBuffer() abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  " `cbuffer`: Convert to `quickfix`
  " `bprevious`: Go back to grep input
  " `bdelete`: Delete the grep buffer
  if line('$') == 1
    " Don't show the quickfix list if there's exactly one match
    execute "cbuffer | bprevious | bdelete"
  else
    execute "cbuffer | bprevious | bdelete | cw | wincmd k"
  endif
endfunction

" Save and Restore Session State
command! SessionSaveLocal :mksession! vim_session
command! SessionSave :mksession! ~/.vim/vim_session
command! SessionRestoreLocal :source vim_session
command! SessionRestore :source ~/.vim/vim_session
command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! QuitSaveSession :call <SID>QuitSaveSession()
function! s:QuitSaveSession() abort
  SessionSave
  qa
endfunction

" Terminal Commands
" if exists(':terminal')
"   command! Doc call <SID>Doc()
"   function! s:Doc() abort
"     split
"     execute 'terminal doc'
"     tnoremap <buffer> <Esc> <C-\><C-n>
"   endfunction
" endif

" Add `git` hunks to `quickfix`
command! Ghunks cexpr system('git diff --relative \| dtg')

command! Gcd :call <SID>Gcd()
function! s:Gcd() abort
  let l:git_root = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    lcd shellescape(l:git_root)
  else
    echo "Not in a git respository."
  endif
endfunction

" Rg
command! -nargs=* Rg :call <SID>Rg(<q-args>)
function! s:Rg(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  execute "grep " . a:terms
  let &grepprg = l:original_grepprg
endfunction

" Atm
command! -nargs=* Atm :call <SID>Atm(<q-args>)
function! s:Atm(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=tmux-paths-rg
  execute "grep " . a:terms
  let &grepprg = l:original_grepprg
endfunction
