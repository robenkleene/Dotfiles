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
