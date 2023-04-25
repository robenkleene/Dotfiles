setlocal foldexpr=DiffFold(v:lnum)
setlocal foldmethod=expr
setlocal foldlevel=1
" Allow quickly quitting without saving when piping a diff to vim
setlocal buftype=nofile
setlocal readonly
setlocal nomodifiable
" Useful for debugging
setlocal foldcolumn=3

nnoremap <buffer> gd :OpenDiff<CR>

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
function! s:OpenDiff() abort
  " let l:start = search('^diff --git', 'bnW')
  " let l:fin = search('^@@', 'nW') - 1
  " if !l:start
  "   return
  " endif
  " if l:fin < 0
  "   let l:fin = line('$')
  " endif
  " let reg_save = @@
  " let l:diff = join(getbufline(bufnr('%'), l:start, l:fin), "\n")
  " let l:grep = system('~/.bin/diff_to_grep '.line('.').' | tail -n1 | cut -d: -f1,2', l:diff)
  let l:grep = system('~/.bin/diff_to_grep '.line('.').' | tail -n1 | cut -d: -f1,2', join(getline(1,'$'), "\n"))
  " echom "l:grep = ".l:grep
  let l:parts = split(l:grep, ':')
  " TODO: To get the proper line number: Add the number of lines between the
  " @@ and this line
  " let l:lnum = line('.')
  " let l:hunkstart = search('^@@ ', 'bnW')
  " let l:offset = l:lnum - l:hunkstart
  " echom "l:lnum = ".l:lnum
  " echom "l:hunkstart = ".l:hunkstart
  " echom "l:parts[1] = ".l:parts[1]
  " let l:destlnum = l:parts[1] + l:offset
  " echom "l:destlnum = ".l:destlnum
  exec "edit " . fnameescape(l:parts[0])
  let l:destlnum = l:parts[1]
  exec l:destlnum
endfunction
