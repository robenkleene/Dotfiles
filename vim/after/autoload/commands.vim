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

function! commands#GrepBufferFromClipboard() abort
  call commands#NewBufferWithClipboard()
  call commands#GrepBuffer()
endfunction

function! commands#NewBufferWithClipboard() abort
  execute "enew"
  normal V"0P
endfunction

function! commands#YankGrep()
  let @@ = expand("%:p").":".line('.')
  call system('~/.bin/safecopy', @@)
  echo getreg('@')
endfunction

function! commands#YankPath()
  let @@ = expand("%:p")
  call system('~/.bin/safecopy', @@)
  echo getreg('@')
endfunction

function! commands#YankFilename()
  let @@ = expand("%")
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
  " Open the quickfix list and navigate to the first result
  " if len(getqflist())
  "   copen
  "   wincmd p
  " endif
  " Vim has artifacts if we don't redraw after this
  redraw!
endfunction

function! commands#Z(terms) abort
  let l:result = system('~/.bin/z_get '. a:terms)
  exe "Explore ".l:result
endfunction
