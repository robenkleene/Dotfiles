function! commands#Dc(term) abort
  let l:term = a:term
  if l:term =~ '\D' && l:term < 0
    let l:term -= 1
  endif
  let l:result = histget(':', l:term)
  call histdel(':', l:term)
  echo "Deleted '".l:result."' from history"
endfunction

function! commands#Make(cmd, label) abort
    let l:cmd = expandcmd(a:cmd)
    let l:result = system(l:cmd)
    if v:shell_error != 0
      echohl ErrorMsg | echomsg "Non-zero exit status for ".a:label." command: ".l:cmd | echohl None
      return
    endif
    cexpr l:result
    if getqflist()->empty()
      echohl WarningMsg | echomsg "No matches for ".a:label." command: ".l:cmd | echohl None
      return
    endif
    cwindow
    wincmd k
endfunction

function! commands#Args(bang, cmd) abort
  let l:result = systemlist(a:cmd)
  if v:shell_error != 0
    echohl ErrorMsg | echomsg "Non-zero exit status for Find command: ".a:cmd | echohl None
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  if l:escaped_files->empty()
    echohl WarningMsg | echomsg "No files found for Find command: ".a:cmd | echohl None
    return
  endif
  let l:args_list = join(l:escaped_files, ' ')
  execute "args".(a:bang ? '!':'').' '.l:args_list
endfunction
