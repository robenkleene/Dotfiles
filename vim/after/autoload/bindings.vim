function! bindings#RegisterCopyPaste() abort
  let @t=system('~/.bin/safepaste')
  return "\<C-r>"
endfunction

function! bindings#ToggleQuickfixList() abort
  for bufnum in map(filter(split(bindings#GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  copen
  " Go back to the starting window
  " if winnr() != winnr
  "   wincmd p
  " endif
endfunction

function! bindings#GetBufferList() abort
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! bindings#GetSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction
