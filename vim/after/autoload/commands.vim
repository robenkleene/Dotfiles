function! commands#Fd(terms) abort
  let cmd = 'fd ' . escape(a:terms, '%#')
  let l:result = systemlist(cmd)
  if v:shell_error != 0 || empty(l:result)
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let l:args_list = join(l:escaped_files, ' ')
  execute 'args ' . l:args_list
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

function! commands#Lz(terms) abort
  let l:result = system('zoxide query ' . escape(a:terms, '%#'))
  if v:shell_error != 0
      return
  endif
  " Don't also explore, this helps in the case where you might have a No Name
  " buffer open that you want to switch to a directory to save
  " execute "Explore ".l:result
  " cd %
  execute "cd ".l:result
endfunction

function! commands#Z(terms) abort
  let l:result = system('zoxide query ' . escape(a:terms, '%#'))
  if v:shell_error != 0
      return
  endif
  " Don't also explore, this helps in the case where you might have a No Name
  " buffer open that you want to switch to a directory to save
  " execute "Explore ".l:result
  " cd %
  execute "cd ".l:result
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

function! commands#P(cmd) range abort
  let l:save = @@

  execute 'silent noautocmd keepjumps normal! gv'
  let l:mode = mode(1)
  execute 'silent noautocmd keepjumps normal! y'
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  execute 'silent noautocmd keepjumps normal! Vp'
  execute 'silent noautocmd keepjumps 0,$'.a:cmd

  if l:mode == 'v'
    execute 'silent noautocmd keepjumps normal! ggvGg_y'
  elseif l:mode == 'V'
    execute 'silent noautocmd keepjumps normal! ggVGy'
  elseif l:mode == "\<C-V>"
    execute 'silent noautocmd keepjumps normal! gg<C-v>G$y'
  endif

  bd!
  execute 'silent noautocmd keepjumps normal! gvp'

  let @@ = l:save
endfunction
