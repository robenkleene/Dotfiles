function! commands#GrepBuffer(...) abort
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
    if len(getqflist()) > 1
      cwindow
      wincmd k
    endif
  endif
endfunction

function! commands#GrepBufferFromClipboard() abort
  call commands#NewBufferWithClipboard()
  call commands#GrepBuffer()
endfunction

function! commands#NewBufferWithClipboard() abort
  execute "enew"
  normal VP
endfunction

function! s:entries(path) abort
  let path = substitute(a:path,'[\\/]$','','')
  let files = split(glob(path."/.*"),"\n")
  let files += split(glob(path."/*"),"\n")
  call filter(files, '!isdirectory(v:val) && v:val !~ "\.DS_Store$"')
  return files
endfunction
function! s:FileByOffset(num) abort
  let file = expand('%:p')
  if empty(file)
    let file = getcwd() . '/'
  endif
  let path = fnamemodify(file,':h')
  let files = s:entries(path)
  let num = a:num
  if a:num < 0
    call reverse(sort(filter(files,'v:val <# file')))
  else
    call sort(filter(files,'v:val ># file'))
  endif
  return get(files,0,'')
endfunction
function! commands#Fnext() abort
  let l:filename = fnameescape(<SID>FileByOffset(1))
  execute 'edit '.l:filename
endfunction
function! commands#Fprev() abort
  let l:filename = fnameescape(<SID>FileByOffset(-1))
  execute 'edit '.l:filename
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
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
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
  if len(getqflist())
    copen
    wincmd p
  endif
endfunction

function! commands#TerminalLocal() abort
  let l:term_dir=expand('%:p:h')
  enew
  call termopen([&shell], { 'cwd': l:term_dir })
endfunction

function! commands#NNN() abort
  let l:path=expand('%:p')
  " Without an `enew` it takes over the current buffer completely which means if
  " you have a file, make a split, then enter `nnn` in the split, it'll open
  " in both splits.
  enew
  call termopen(["nnn","-AQ",l:path])
  " `bufhidden=delete` should close the buffer when it hides, which would help
  " prevent the "job still running" messages when quitting with `:wqa` and a
  " still living `nnn` buffer. This doesn't work though.
  setlocal bufhidden=delete
endfunction
