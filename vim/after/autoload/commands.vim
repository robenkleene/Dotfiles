function! commands#Fd(term) abort
  let l:cmd = 'fd '.a:term
  let l:result = systemlist(l:cmd)
  if v:shell_error != 0
    echom "Non-zero exit status running ".l:cmd
    return
  endif
  if empty(l:result)
    echom "No results found running ".l:cmd
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let l:args_list = join(l:escaped_files, ' ')
  execute 'args ' . l:args_list
endfunction

function! commands#Rg(bang, term) abort
  let l:original_grepprg = &grepprg
  let &grepprg='rg '.a:term
  " Use `silent` to prevent the `Press ENTER` to continue message
  " We don't add `silent` because it's useful to see the initial output to get
  " a sense of how many total search matches there are
  execute 'grep'.(a:bang ? '!':'')
  let &grepprg = l:original_grepprg
endfunction

function! commands#ArgsSh(cmd) abort
  let l:result = systemlist(a:cmd)
  if v:shell_error != 0
    echom "Non-zero exit status running ".a:cmd
    return
  endif
  if empty(l:result)
    echom "No results found running ".a:cmd
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let l:args_list = join(l:escaped_files, ' ')
  execute 'args ' . l:args_list
endfunction

function! commands#GrepSh(bang, cmd) abort
  let l:original_grepprg = &grepprg
  let &grepprg=escape(a:cmd, '|')
  execute 'grep'.(a:bang ? '!':'')
  let &grepprg = l:original_grepprg
endfunction

function! commands#MakeSh(bang, cmd) abort
  let l:original_makeprg = &makeprg
  let &makeprg=escape(a:cmd, '|')
  execute "make".(a:bang ? '!':'')
  let &makeprg = l:original_makeprg
endfunction

function! commands#NewSh(cmd) abort
  call commands#NewShCmd("new", a:cmd)
endfunction

function! commands#VnewSh(cmd) abort
  call commands#NewShCmd("vnew", a:cmd)
endfunction

function! commands#EnewSh(cmd) abort
  call commands#NewShCmd("enew", a:cmd)
endfunction

function! commands#TabnewSh(cmd) abort
  call commands#NewShCmd("tabnew", a:cmd)
endfunction

function! commands#NewShCmd(split, cmd) abort
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
  execute 'file '.fnameescape(a:cmd)
endfunction

function! commands#completeMan9(arglead, cmdline, cursorpos) abort
  let cmd = "find ~/.man -type f -name '". a:arglead . "*' -exec basename {} '.9' \\;"
  return systemlist(cmd)
endfunction

function! commands#Ztcd(terms) abort
  call commands#Zcmd("tcd", a:terms)
endfunction

function! commands#Zlcd(terms) abort
  call commands#Zcmd("lcd", a:terms)
endfunction

function! commands#Zcd(terms) abort
  call commands#Zcmd("cd", a:terms)
endfunction

function! commands#Zcmd(cd, terms) abort
  let l:result = system('zoxide query ' . a:terms)
  if v:shell_error != 0
      return
  endif
  execute a:cd." ".l:result
  pwd
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

function! commands#Part(cmd) range abort
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

function! commands#PartNew(split) range abort
  let l:save = @@

  let l:oldundolevels=&undolevels
  setlocal undolevels=-1

  execute 'silent noautocmd keepjumps normal! gv'
  execute 'silent noautocmd keepjumps normal! y'
  execute a:split
  execute 'silent noautocmd keepjumps normal! Vp'
  filetype detect

  let @@ = l:save
  let &l:undolevels=l:oldundolevels
endfunction
