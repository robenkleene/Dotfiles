setlocal foldexpr=DiffFoldLevel()
setlocal foldmethod=expr
setlocal foldlevel=1
execute "setlocal buftype=nofile"

nnoremap <return> :OpenDiff<CR>

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
  let reg_save = @@
  let @@ = join(getbufline(bufnr('%'), l:start, l:fin), "\n")
  execute "enew"
  normal ""P
  call commands#GrepBuffer()
  cclose
  clast
  let @@ = reg_save
endfunction
