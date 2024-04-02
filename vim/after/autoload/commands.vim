function! commands#ArgsSh(cmd) abort
  let l:result = systemlist(a:cmd)
  if v:shell_error != 0 || empty(l:result)
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let l:args_list = join(l:escaped_files, ' ')
  execute 'args ' . l:args_list
endfunction

function! commands#GrepSh(bang, cmd) abort
  let l:original_grepprg = &grepprg
  " Escape `\` so they aren't removed when setting `grepprg`
  " Setting `grepprg` requires escaping spaces
  execute 'set grepprg='.escape(a:cmd,' \')
  execute "grep".(a:bang ? '!':'')
  let &grepprg = l:original_grepprg
endfunction

function! commands#MakeSh(bang, cmd) abort
  let l:original_makeprg = &makeprg
  execute 'set makeprg='.escape(a:cmd,' ')
  execute "make".(a:bang ? '!':'')
  let &makeprg = l:original_makeprg
endfunction

function! commands#Nsh(cmd) abort
  call commands#NewSh("new", a:cmd)
endfunction

function! commands#Vsh(cmd) abort
  call commands#NewSh("vnew", a:cmd)
endfunction

function! commands#NewSh(split, cmd) abort
  let l:cmd = substitute(a:cmd, '\s%$', ' #', '')
  " Neither approach supports `DiffSh git diff %` well, but this one at
  " least allows `DiffSh git diff #`
  " let l:result = system(a:cmd)
  " new
  " put =l:result
  " This could be either `enew` or `new`, `:tag` works like `enew` and `:h`
  " and `:Man` work like `new`
  exec a:split
  " Reset undo for this buffer
  let l:oldundolevels=&undolevels
  setlocal undolevels=-1
  execute '0r !'.l:cmd
  norm Gddgg
  let &l:undolevels=l:oldundolevels
  filetype detect
endfunction

function! commands#completeMan9(arglead, cmdline, cursorpos) abort
  let cmd = "find ~/.man -type f -name '". a:arglead . "*' -exec basename {} '.9' \\;"
  return systemlist(cmd)
endfunction

function! commands#Lz(terms) abort
  let l:result = system('zoxide query ' . a:terms)
  if v:shell_error != 0
      return
  endif
  " Don't also explore, this helps in the case where you might have a No Name
  " buffer open that you want to switch to a directory to save
  " execute "Explore ".l:result
  " cd %
  execute "lcd ".l:result
endfunction

function! commands#Z(terms) abort
  let l:result = system('zoxide query ' . a:terms)
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
