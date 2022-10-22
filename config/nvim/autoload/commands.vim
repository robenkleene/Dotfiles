function! commands#GrepBuffer(...) abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  if len(getqflist())
    cexpr []
  endif
  cw
  " If the input is a list of files, populate the `argslist`
  if filereadable(getline('1')) || isdirectory(getline('1'))
    let l:filenames = getline(1, '$')
    call map(l:filenames, "fnameescape(v:val)")
    execute "args ".join(l:filenames)
    " Can't seem to figure out how to not make this quit vim when using the
    " `:Q` command to populate the quickfix from the clipboard if it's files,
    " not grep matches
    " bprevious
    " bdelete
    return
  endif
  set modifiable
  " If it's diff output, first convert it to `grep`
  if getline('1')[0:len('diff --')-1] ==# 'diff --' || getline('2')[0:len('diff --')-1] ==# 'diff --' || getline('1')[0:len('changeset:')-1] ==# 'changeset:'
    execute "silent %!diff_clean | diff_to_grep"
  endif
  " If it's grep output, populate the quickfix list
  " Check the first three lines, to allow for various types of imperfect input
  " if getline('1') =~# '^.\{-}:\s\?\d\{-}:' || getline('2') =~# '^.\{-}:\s\?\d\{-}:' || getline('3') =~# '^.\{-}:\s\?\d\{-}:'
  " Now just always treat as grep buffer if it's not a diff, lots of command
  " output contain grep results buried in them
  execute "silent %!grep_clean"
  cbuffer
  if len(getqflist())
    " Keep these around by default because it makes it easier to recall the
    " search later
    if (a:0 > 0 && a:1 > 0)
      bprevious
      bdelete
    endif
    if len(getqflist()) > 1
      cw
      wincmd k
    endif
  endif
endfunction

function! commands#GrepBufferFromClipboard() abort
  call commands#NewBufferWithClipboard()
  call commands#GrepBuffer()
endfunction

function! commands#NewBufferWithClipboard() abort
  execute "enew"
  normal P
endfunction
