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
  if exists('*getcmdwintype') && !empty(getcmdwintype())
    echom "Not valid in command-line window"
    return
  endif
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

function! commands#Sh(bang, cmd) abort
  let l:cmd = substitute(a:cmd, '\s%$', ' #', '')
  let l:basename = fnameescape(a:cmd)
  " Neither approach supports `DiffSh git diff %` well, but this one at
  " least allows `DiffSh git diff #`
  " let l:result = system(a:cmd)
  " new
  " put =l:result
  " This could be either `enew` or `new`, `:tag` works like `enew` and `:h`
  " and `:Man` work like `new`
  if !a:bang || bufwinnr(l:basename) < 0
    new
  endif
  " Reset undo for this buffer
  let l:oldundolevels=&undolevels
  setlocal undolevels=-1
  let l:bufnr = bufnr(l:basename)
  if a:bang && l:bufnr > 0
    execute 'buffer '.l:bufnr
    enew
    bd#
  endif
  for l:i in range(1, 9)
    " Wrap `file` in a try-catch to suppress errors if the name already exists
    " (The buffer will continue to show up as `[No Name]`)
    try
      execute 'file '.l:basename.(i > 1 ? ' '.l:i : '')
      file
      break
    catch
    endtry
  endfor
  execute 'silent 0r !'.l:cmd
  norm Gddgg
  let &l:undolevels=l:oldundolevels
  filetype detect
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
  if v:shell_error == 1
      echo "No match found"
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

function! commands#Part(...) range abort
  let l:save = @@

  execute 'silent noautocmd keepjumps normal! gv'
  let l:mode = mode(1)
  execute 'silent noautocmd keepjumps normal! y'
  new
  let l:oldundolevels=&undolevels
  setlocal undolevels=-1

  setlocal buftype=nofile bufhidden=hide noswapfile
  execute 'silent noautocmd keepjumps normal! Vp'

  if a:0 >= 1 && !empty(a:1)
    let l:cmd = a:1
    execute 'silent noautocmd keepjumps 0,$'.l:cmd

    if l:mode == 'v'
      execute 'silent noautocmd keepjumps normal! ggvGg_y'
    elseif l:mode == 'V'
      execute 'silent noautocmd keepjumps normal! ggVGy'
    elseif l:mode == "\<C-V>"
      execute 'silent noautocmd keepjumps normal! gg<C-v>G$y'
    endif

    bd!
    execute 'silent noautocmd keepjumps normal! gvp'
  else
    let &l:undolevels=l:oldundolevels
  endif

  let @@ = l:save
endfunction

function! commands#Ggrep(args)
    let content = a:args
    if content =~# '^\([^:]\+\):\(\d\+\):\?\(\d*\)'
        let file = matchstr(content, '^\([^:]\+\)')
        let line = matchstr(content, ':\zs\d\+\ze')
        let col = matchstr(content, ':\d\+:\zs\d\+\ze')
        if empty(col)
            let col = 1
        endif

        " `filereadable` isn't working, maybe doesn't support a virtual file system?
        " if filereadable(file)
        execute 'edit ' . file
        execute 'normal! ' . line . 'G' . col . '|'
        " else
        "     echo "Error: File '" . file . "' not found."
        " endif
    else
        echo "Error: Invalid format in register. Expected '<filename>:<linenumber>[:<columnumber>]'."
    endif
endfunction
