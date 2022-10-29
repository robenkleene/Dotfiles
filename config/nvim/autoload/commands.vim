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
  normal P
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
  let @@ = expand("%:p").":".line('.').":0"
  call system('~/.bin/safecopy', @@)
  echo "Yanked Grep"
endfunction
