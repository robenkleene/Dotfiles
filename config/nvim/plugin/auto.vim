let s:temporary_directory = "/tmp/vim.robenkleene/"
let s:chdirectory_directory = s:temporary_directory . "chdir"
let s:chdirectory_file = s:chdirectory_directory . "/chdir"
if !isdirectory(s:chdirectory_directory)
  call mkdir(s:chdirectory_directory, 'p')
endif
function! s:isdir(dir)
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction
augroup write_chdir
  autocmd!
  autocmd VimLeavePre *
        \ if <SID>isdir(expand('%:h'))
        \ | call writefile([expand('%:h:p')], s:chdirectory_file)
        \ | endif
augroup END

augroup auto_save_session
  autocmd!
  autocmd VimLeave * 
  \ if expand('%:p') !~ '^/tmp'
  \&& &filetype !~ 'gitcommit'
  \&& &filetype !~ 'hgcommit'
  \&& &filetype !~ 'pullrequest'
  \&& &filetype !~ 'gitrebase'
  \|    silent! mksession! ~/.vim/vim_auto_session
  \|  endif
augroup END

" Save View
augroup save_view
  autocmd!
  autocmd BufWinLeave *
  \   if expand('%') != ''
  \&& &buftype !~ 'nofile'
  \&& &buftype !~ 'help'
  \&& &buftype !~ 'term'
  \&& &filetype !~ 'gitcommit'
  \&& &filetype !~ 'hgcommit'
  \&& &filetype !~ 'pullrequest'
  \&& &filetype !~ 'gitrebase'
  \|    silent! mkview
  \|  endif
  autocmd BufWinEnter *
  \   if expand('%') != ''
  \&& &buftype !~ 'nofile'
  \&& &buftype !~ 'help'
  \&& &buftype !~ 'term'
  \&& &filetype !~ 'gitcommit'
  \&& &filetype !~ 'hgcommit'
  \&& &filetype !~ 'pullrequest'
  \&& &filetype !~ 'gitrebase'
  \|    silent! loadview
  \|  endif
augroup END

augroup quickfix_height
  autocmd!
  autocmd FileType qf call auto#AdjustWindowHeight(3, 20)
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END
"
" Autoreload files edited by other programs
set autoread
" This causes a delay when opening the command-line window with `<C-f>`?
" Maybe `set autoread` is enough?
" augroup reload_buffers
"   autocmd!
"   " Oddly, `silent! checktime` doesn't seem to update after a `git checkout
"   " <file>` while just `checktime` does. (`silent! checktime` when editing the
"   " same file in another `vim` instance though.)
"   " autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * if expand('%') !=# '[Command Line]' | checktime | endif
"   autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * if !bufexists("[Command Line]") | checktime | endif
" augroup END
"
" Do not extend comments automatically, e.g., with `O`
augroup disable_autocomments
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Write directory to temp file
let s:temporary_directory = "/tmp/vim.robenkleene/"
let s:chdirectory_directory = s:temporary_directory . "chdir"
let s:chdirectory_file = s:chdirectory_directory . "/chdir"
if !isdirectory(s:chdirectory_directory)
  call mkdir(s:chdirectory_directory, 'p')
endif
function! s:isdir(dir)
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction
augroup write_chdir
  autocmd!
  autocmd VimLeavePre *
        \ if <SID>isdir(expand('%'))
        \ | call writefile([expand('%:p')], s:chdirectory_file)
        \ | endif
augroup END

augroup no_whitespace_insert
  autocmd!
  autocmd InsertEnter * setlocal nolist
  autocmd InsertLeave * setlocal list
augroup END

" clipboard
augroup safecopy
  autocmd!
  autocmd TextYankPost * silent! call system('~/.bin/safecopy',join(v:event["regcontents"],"\n"))
augroup END
" When moving to another vim instance, copy from the system clipboard and
" append a new line so pasting is always linewise. this allows pastin between
" Vim instances without using `unnamedplus` which can mess up using `yyp` to
" copy a line within a Vim session
augroup safepaste
  autocmd!
  autocmd FocusGained * let @" = system('~/.bin/safepaste').."\n"
augroup END
let @" = system('~/.bin/safepaste')

" z add
" Not sure why this doesn't work consistently
augroup z_add
  autocmd!
  autocmd VimEnter * if exists('#FileExplorer') | execute 'autocmd! FileExplorer *' | endif
  autocmd BufEnter * if s:isdir(expand('%')) | call system('~/.bin/z_add '.shellescape(expand('%'))) | endif
augroup END
if exists('#FileExplorer') | execute 'autocmd! FileExplorer *' | endif

augroup terminal_settings
  autocmd!
  " Start terminals in insert mode
  autocmd TermOpen * startinsert
  " Automatically close terminals
  " This breaks things like `vim.g.unception_delete_replaced_buffer`
  " autocmd TermClose * call feedkeys("i")
augroup END
