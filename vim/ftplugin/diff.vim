" setlocal foldexpr=DiffFold(v:lnum)
" setlocal foldexpr=DiffFold(v:lnum)
setlocal foldexpr=getline(v:lnum)=~'^diff'?'>1':getline(v:lnum)=~'^@@'?'>2':=
setlocal foldmethod=expr
" Allow quickly quitting without saving when piping a diff to vim
" Handled as default for piping now
" setlocal buftype=nofile

" Useful for debugging
" setlocal foldcolumn=3
" Start with folding enabling bindings to navigate folds are available
setlocal foldenable
" Set starting fold level so all folds are open
setlocal foldlevel=2
setlocal readonly nomodifiable

nnoremap <silent> <buffer> <localleader>gd :OpenDiff<CR>
nnoremap <silent> <buffer> <C-w><localleader>d :OpenDiffNew<CR>

" function! DiffFold(lnum)
"   let line = getline(a:lnum)
"   if line =~ '^diff'
"     return '>1'
"   elseif line =~ '^@@'
"     return '>2'
"   else
"     return '='
"   endif
" endfunction
command! OpenDiff :call <SID>OpenDiff()
command! OpenDiffNew :split | call <SID>OpenDiff()
function! s:OpenDiff() abort
  let l:grep = system('~/.bin/f_from_diff_to_grep '.line('.').' | tail -n1 | cut -d: -f1,2', join(getline(1,'$'), "\n"))
  let l:parts = split(l:grep, ':')
  exec "edit " . fnameescape(l:parts[0])
  let l:destlnum = l:parts[1]
  exec l:destlnum
endfunction
