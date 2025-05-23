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
