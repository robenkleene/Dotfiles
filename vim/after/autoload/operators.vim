function operators#ConflictDiff(type = '') abort
  if a:type == ''
    let &operatorfunc = function('operators#ConflictDiff')
    return 'g@'
  endif

  let l:lines = getline("'[", "']")
  let l:conflicts = s:ParseConflicts(l:lines)

  if empty(l:conflicts)
    echohl ErrorMsg | echomsg 'No conflict markers found' | echohl None
    return
  endif

  let l:origin = win_getid()
  for l:conflict in l:conflicts
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile
    silent call setline(1, l:conflict.ours)
    diffthis

    vnew
    setlocal buftype=nofile bufhidden=wipe noswapfile
    silent call setline(1, l:conflict.theirs)
    diffthis
  endfor
  call win_gotoid(l:origin)
endfunction

function operators#ConflictDiffLine() abort
  let l:save_pos = getpos('.')
  let l:start = search('^<<<<<<<', 'bWc')
  if l:start == 0
    let l:start = search('^<<<<<<<', 'Wc')
  endif
  if l:start == 0
    call setpos('.', l:save_pos)
    echohl ErrorMsg | echomsg 'No conflict markers found' | echohl None
    return
  endif
  let l:end = search('^>>>>>>>', 'Wc')
  if l:end == 0
    call setpos('.', l:save_pos)
    echohl ErrorMsg | echomsg 'No conflict markers found' | echohl None
    return
  endif

  let l:lines = getline(l:start, l:end)
  let l:conflicts = s:ParseConflicts(l:lines)
  call setpos('.', l:save_pos)

  if empty(l:conflicts)
    echohl ErrorMsg | echomsg 'No conflict markers found' | echohl None
    return
  endif

  let l:origin = win_getid()
  for l:conflict in l:conflicts
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile
    silent call setline(1, l:conflict.ours)
    diffthis

    vnew
    setlocal buftype=nofile bufhidden=wipe noswapfile
    silent call setline(1, l:conflict.theirs)
    diffthis
  endfor
  call win_gotoid(l:origin)
endfunction

function s:ParseConflicts(lines) abort
  let l:conflicts = []
  let l:ours = []
  let l:theirs = []
  let l:section = ''
  for l:line in a:lines
    if l:line =~# '^<<<<<<<'
      let l:ours = []
      let l:theirs = []
      let l:section = 'ours'
    elseif l:line =~# '^|||||||'
      let l:section = 'base'
    elseif l:line =~# '^======='
      let l:section = 'theirs'
    elseif l:line =~# '^>>>>>>>'
      call add(l:conflicts, #{ours: l:ours, theirs: l:theirs})
      let l:section = ''
    elseif l:section ==# 'ours'
      call add(l:ours, l:line)
    elseif l:section ==# 'theirs'
      call add(l:theirs, l:line)
    endif
  endfor
  return l:conflicts
endfunction
