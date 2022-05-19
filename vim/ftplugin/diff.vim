setlocal foldexpr=DiffFoldLevel()
setlocal foldmethod=expr
setlocal foldlevel=1
" Allow quickly quitting without saving when piping a diff to vim
execute "setlocal buftype=nofile"

nnoremap <buffer> <return> :OpenDiff<CR>
nnoremap <buffer> [[ zk
nnoremap <buffer> ]] zj
nnoremap <buffer> <C-l> :%delete<CR>:r!~/.bin/diff_status<CR>
nnoremap <buffer> q ZQ

function! DiffFoldLevel()
    let l:line=getline(v:lnum)

    if l:line =~# '^\(diff\|Index\)'     " file
        return '>1'
    elseif l:line =~# '^\(@@\|\d\)'  " hunk
        return '>2'
    elseif l:line =~# '^\*\*\* \d\+,\d\+ \*\*\*\*$' " context: file1
        return '>2'
    elseif l:line =~# '^--- \d\+,\d\+ ----$'     " context: file2
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
