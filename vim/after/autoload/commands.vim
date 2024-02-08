function! commands#Fd(terms) abort
  let cmd = 'fd ' . escape(a:terms, '%#') . ' -0'
  let l:result = systemlist(cmd)
  if v:shell_error != 0 || empty(l:result)
    return
  endif
  let escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let args_list = join(escaped_files, ' ')
  execute 'args ' . args_list
endfunction

function! commands#Rg(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=rg\ \ --vimgrep\ --no-heading
  if len(a:terms)
    execute "grep " . escape(a:terms, '%#')
  endif
  let &grepprg = l:original_grepprg
endfunction

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
