function! commands#GrepBuffer(...) abort
  " Remove blank lines at the end of the file (which get their own entries
  " otherwise)
  " This is giving an warning in vim
  silent v/\_s*\S/d
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  if len(getqflist())
    cexpr []
  endif
  cwindow
  cbuffer
  if len(getqflist())
    if (a:0 > 0 && a:1 > 0)
      bprevious
      bdelete
    endif
    " Automatically open quickfix
    " if len(getqflist()) > 1
    "   cwindow
    "   wincmd k
    " endif
  endif
endfunction

function! commands#YankGrep()
  let @@ = expand("%:p").":".line('.')
  call system('~/.bin/safecopy', @@)
  echo getreg('@')
endfunction

function! commands#Rg(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=rg\ \ --vimgrep\ --no-heading
  if len(a:terms)
    execute "silent grep " . escape(a:terms, '%#')
  else
    let l:search = getreg('/')
    if l:search[0:len('\<')-1] ==# '\<'
      let l:search = l:search[2:len(l:search)-3]
    endif
    if !len(l:search)
      return
    endif
    execute "silent grep " . escape(l:search, '%#')
  endif
  let &grepprg = l:original_grepprg
  if !has('nvim')
    redraw!
  endif
endfunction

function! commands#Fd(terms) abort
  let l:result = system('fd ' . escape(a:terms, '%#') . ' -X printf "%s "')
  if v:shell_error != 0
      return
  endif
  execute "args ".l:result
endfunction

function! commands#CompleteRegisters(findstart, base)
  if a:findstart == 1
    return 0
  endif
  let s = ''
  redir => s
  silent registers
  redir END
  let reg_list = []
  for reg_str in split(s, "\n")[1:]
      let abbr = reg_str[6:7]
      let word = reg_str[10:]
      let reg_dict = {"menu": word, "abbr": abbr, "word": "", "dup": v:true, "empty": v:true, "kind": "r"}
      call add(reg_list, reg_dict)
  endfor
  return complete(col('.'), reg_list)
endfunction

function! commands#completeMan9(arglead, cmdline, cursorpos) abort
  let cmd = "find ~/.man -type f -name '". escape(a:arglead, '%#') . "*' -exec basename {} '.9' \\;"
  return systemlist(cmd)
endfunction

command! -nargs=1 -complete=customlist,<sid>CompleteFd FD execute 'edit' <f-args>
function! commands#GrepBufferFromClipboard() abort
  let l:original_grepprg = &grepprg
  set grepprg=~/.bin/safepaste
  execute "silent grep"
  let &grepprg = l:original_grepprg
  if !has('nvim')
    redraw!
  endif
endfunction

function! commands#Z(terms) abort
  let l:result = system('~/.bin/z_get ' . escape(a:terms, '%#'))
  if v:shell_error != 0
      return
  endif
  execute "Explore ".l:result
  cd %
endfunction
