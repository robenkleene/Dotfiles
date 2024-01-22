function! commands#completeMan9(arglead, cmdline, cursorpos) abort
  let cmd = "find ~/.man -type f -name '". escape(a:arglead, '%#') . "*' -exec basename {} '.9' \\;"
  return systemlist(cmd)
endfunction

function! commands#Z(terms) abort
  let l:result = system('zoxide query ' . escape(a:terms, '%#'))
  if v:shell_error != 0
      return
  endif
  execute "Explore ".l:result
  cd %
endfunction

function! commands#Dc(term) abort
  let l:term = a:term
  if l:term =~ '\D' && l:term < 0
    let l:term -= 1
  endif
  let l:result = histget(':', l:term)
  call histdel(':', l:term)
  echo "Deleted '".l:result."' from history."
endfunction
