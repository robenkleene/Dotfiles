function! commands#Dc(term) abort
  let l:term = a:term
  if l:term =~ '\D' && l:term < 0
    let l:term -= 1
  endif
  let l:result = histget(':', l:term)
  call histdel(':', l:term)
  echo "Deleted '".l:result."' from history"
endfunction

function! commands#Grep(...) abort
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

function! commands#Find(bang, cmd) abort
  let l:result = systemlist(a:cmd)
  if v:shell_error != 0
    echohl ErrorMsg | echomsg "Non-zero exit status running ".a:cmd | echohl None
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let l:args_list = join(l:escaped_files, ' ')
  execute "args".(a:bang ? '!':'').' '.l:args_list
endfunction
