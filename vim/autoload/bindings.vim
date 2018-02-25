" Yank Markdown Links
function! bindings#LinkSourceControlYank() abort
  let @" = system('~/Development/Scripts/bin/link-source-control-markdown --url-only '.fnameescape(expand('%:p')))
  let @* = @"
  echo "Yanked git link"
endfunction
function! bindings#LinkSourceControlYankLines() range abort
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/link-source-control-markdown --url-only --line-number '.line('.').' '.fnameescape(expand('%:p')))
  let @* = @"
  echo "Yanked git link"
endfunction
function! bindings#LinkSourceControlMarkdownYank() abort
  let @" = system('~/Development/Scripts/bin/link-source-control-markdown '.fnameescape(expand('%:p')))
  let @* = @"
  echo "Yanked git Markdown link"
endfunction
function! bindings#LinkSourceControlMarkdownYankLines() range abort
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/link-source-control-markdown --line-number '.line('.').' '.fnameescape(expand('%:p')))
  let @* = @"
  echo "Yanked git Markdown link"
endfunction

" Open Git Links
function! bindings#LinkSourceControlOpen() abort
  echo system('~/Development/Scripts/bin/link-source-control-open '.fnameescape(expand('%:p')))
endfunction
function! bindings#LinkSourceControlOpenLines() range abort
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/link-source-control-open --line-number '.line('.').' '.fnameescape(expand('%:p')))
endfunction

" Backup Text
function! bindings#ArchiveLines(bang) range abort
  let file_path = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/Development/Scripts/bin/backup-text')
  if (a:bang == 1)
    let temp = @s
    silent normal! gv"sd
    let @s = temp
  endif
  let lineCount = system('wc -l < '.fnameescape(file_path).' | tr -d " " | tr -d "\n"')
  echom "Backed up ".lineCount." lines"
endfunction

" `grep` Visual Star
function! bindings#VSetSearch(cmdtype) abort
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
" `rg` Visual Star
function! bindings#GrepVisual() abort
  let temp = @s
  norm! gv"sy
  let @s = escape(@s, '\\/.*$^~[]#%')
  execute "Rg --fixed-strings '" . @s . "'"
  let @s = temp
  " if len(getqflist())
  "   copen
  "   wincmd p
  " endif
endfunction

" Toggle `quickfix`
function! bindings#GetBufferList() abort
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction
function! bindings#ToggleQuickfixList() abort
  for bufnum in map(filter(split(bindings#GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  copen
  if winnr() != winnr
    wincmd p
  endif
endfunction

" Todo
function! bindings#OpenTodo() abort
  if !empty($TODO_FILE)
    split
    edit $TODO_FILE
    return
  endif

  if !empty($TODO_DIRECTORY)
    split
    Explore $TODO_DIRECTORY 
    return
  endif

  echom "No TODO_FILE or TODO_DIRECTORY defined."
  " split
  " terminal zsh
  " tnoremap <buffer> <Esc> <C-\><C-n>
endfunction
