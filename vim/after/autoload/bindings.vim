function! bindings#GetSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction

" Unimpaired conflict markers
" The original search was updated to find:
" - `^@@@`: sometimes there's an extra `@`?
" - `++<<<<<<<<`: Sometimes there's two `+` at the start?
" - The non-conflict markers were then removed because jumping to hunks is
"   more appropriate with fold bindings?
function! bindings#Context(reverse) abort
  " call search('^\(@@@\? .* @@@\?\|+\?+\?[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
  call search('^\(+\?+\?[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction
function! bindings#ContextMotion(reverse) abort
  if a:reverse
    -
  endif
  " call search('^@@@\? .* @@@\?\|^diff \|^+\?+\?[<=>|]\{7}[<=>|]\@!', 'bWc')
  call search('^+\?+\?[<=>|]\{7}[<=>|]\@!', 'bWc')
  if getline('.') =~# '^diff '
    let end = search('^diff ', 'Wn') - 1
    if end < 0
      let end = line('$')
    endif
  elseif getline('.') =~# '^@@ '
    let end = search('^@@ .* @@\|^diff ', 'Wn') - 1
    if end < 0
      let end = line('$')
    endif
  elseif getline('.') =~# '^=\{7\}'
    +
    let end = search('^>\{7}>\@!', 'Wnc')
  elseif getline('.') =~# '^[<=>|]\{7\}'
    let end = search('^[<=>|]\{7}[<=>|]\@!', 'Wn') - 1
  else
    return
  endif
  if end > line('.')
    execute 'normal! V'.(end - line('.')).'j'
  elseif end == line('.')
    normal! V
  endif
endfunction

" Conflict diff
function! bindings#ConflictOpen() abort
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

function! bindings#ConflictClose() abort
  let l:wins = []
  for l:winnr in range(1, winnr('$'))
    if getwinvar(l:winnr, '&diff') && getwinvar(l:winnr, '&buftype') ==# 'nofile'
      call add(l:wins, win_getid(l:winnr))
    endif
  endfor
  for l:winid in l:wins
    if win_gotoid(l:winid)
      close
    endif
  endfor
endfunction

function! s:ParseConflicts(lines) abort
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
