" None of the source control functions should be operators because they don't
" have a character-wise action (e.g., only full lines can be referenced via
" URL not words).
" Also, these functions have a meaning even without a motion, e.g., opening a
" source control link with with no selection, opens a link to the file without
" specifying a line number.

" Yank Markdown Links
function! bindings#LinkSourceControlYank() abort
  let @" = system('~/.bin/link_source_control_markdown --url-only '.fnameescape(expand('%:p')))
  if exists("@*")
    let @* = @"
  endif
  echo "Yanked git link"
endfunction
function! bindings#LinkSourceControlYankLines() range abort
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/.bin/link_source_control_markdown --url-only --line-number '.line('.').' '.fnameescape(expand('%:p')))
  if exists("@*")
    let @* = @"
  endif
  echo "Yanked git link"
endfunction
function! bindings#LinkSourceControlMarkdownYank() abort
  let @" = system('~/.bin/link_source_control_markdown '.fnameescape(expand('%:p')))
  if exists("@*")
    let @* = @"
  endif
  echo "Yanked git Markdown link"
endfunction
function! bindings#LinkSourceControlMarkdownYankLines() range abort
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/.bin/link_source_control_markdown --line-number '.line('.').' '.fnameescape(expand('%:p')))
  if exists("@*")
    let @* = @"
  endif
  echo "Yanked git Markdown link"
endfunction
function! bindings#LinkSourceControlMarkdownYankQuotedLines() range abort
  let @" = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/.bin/link_source_control_markdown --quote --line-number '.line('.').' '.fnameescape(expand('%:p')))
  if exists("@*")
    let @* = @"
  endif
  echo "Yanked git Markdown link"
endfunction

" Open Git Links
function! bindings#LinkSourceControlOpen() abort
  echo system('~/.bin/link_source_control_open '.fnameescape(expand('%:p')))
endfunction
function! bindings#LinkSourceControlOpenLines() range abort
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/.bin/link_source_control_open --line-number '.line('.').' '.fnameescape(expand('%:p')))
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
  " let @s = escape(@s, '\\/.*$^~[]#%')
  " Only escape things that are auto-expanded by Vim
  let @s = escape(@s, '#%-')
  execute "A --fixed-strings '" . @s . "'"
  let @s = temp
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

function! bindings#toggle_fold()
  if foldclosed(line('.')) >= 0
    silent! normal zv
  else
    silent! normal za
  endif
endfunction

function! bindings#move_forward_or_toggle_fold()
  let oldpos = getpos('.')
  execute "normal! 1\<c-i>"
  let newpos = getpos('.')
  if newpos == oldpos
    call bindings#toggle_fold()
  endif
endfunction
