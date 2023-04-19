setlocal foldmethod=expr
setlocal foldexpr=DiffFold(v:lnum)
setlocal foldlevel=1
" Allow quickly quitting without saving when piping a diff to vim
setlocal buftype=nofile
setlocal readonly
setlocal nomodifiable
" Useful for debugging
" setlocal foldcolumn=3

nnoremap <buffer> <C-]> :OpenDiff<CR>

function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^diff'
    return '>1'
  elseif line =~ '^@@'
    return '>2'
  else
    return '='
  endif
endfunction

command! OpenDiff :call <SID>OpenDiff()
function! s:OpenDiff()
  let l:start = search('^diff --git', 'bnW')
  let l:fin = search('^@@', 'nW') - 1
  if !l:start
    return
  endif
  if l:fin < 0
    let l:fin = line('$')
  endif
  let reg_save = @@
  let l:diff = join(getbufline(bufnr('%'), l:start, l:fin), "\n")
  let l:grep = system('~/.bin/diff_to_grep | tail -n1 | cut -d: -f1,2', l:diff)
  let l:parts = split(l:grep, ':')
  exec "edit " . fnameescape(l:parts[0])
  " Go to line
  exec l:parts[1]
endfunction
