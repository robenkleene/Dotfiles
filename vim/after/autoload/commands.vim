function! commands#Dc(term) abort
  let l:term = a:term
  if l:term =~ '\D' && l:term < 0
    let l:term -= 1
  endif
  let l:result = histget(':', l:term)
  call histdel(':', l:term)
  echo "Deleted '".l:result."' from history"
endfunction

function! commands#Rg(...) abort
    let l:cmd = join(['rg'] + [expandcmd(join(a:000, ' '))], ' ')
    let l:result = system(l:cmd)
    if v:shell_error != 0
      echohl ErrorMsg | echomsg "Non-zero exit status for Rg command: ".l:cmd | echohl None
      return
    endif
    cexpr l:result
    if getqflist()->empty()
      echohl WarningMsg | echomsg "No matches for Rg command: ".l:cmd | echohl None
      return
    endif
    cwindow
endfunction

function! commands#Fd(bang, terms) abort
  let l:cmd = 'fd '.a:terms
  let l:result = systemlist(l:cmd)
  if v:shell_error != 0
    echohl ErrorMsg | echomsg "Non-zero exit status for Fd command: ".l:cmd | echohl None
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  if l:escaped_files->empty()
    echohl WarningMsg | echomsg "No files found for Fd command: ".l:cmd | echohl None
    return
  endif
  let l:args_list = join(l:escaped_files, ' ')
  execute "args".(a:bang ? '!':'').' '.l:args_list
endfunction
