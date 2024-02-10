" Exclude buffers from restoring view settings
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

" This is so trailing spaces aren't visible when typing in insert mode
augroup no_whitespace_insert
  autocmd!
  autocmd InsertEnter * setlocal nolist
  autocmd InsertLeave * setlocal list
augroup END

augroup ft_stdin
  autocmd!
  " Don't prompt to save when piped to stdin
  autocmd StdinReadPost * setlocal buftype=nofile
augroup END

augroup diff_stdin
  autocmd!
  " Make piped diffs read only
  autocmd StdinReadPost * if &filetype == 'diff' | setlocal readonly nomodifiable | end
augroup END

augroup nofilename_nofile
  autocmd!
  " Don't prompt for saving buffers with no file
  autocmd BufEnter * if eval('@%') == '' && &buftype == '' | setlocal buftype=nofile | end
augroup END

" Don't depend on this because the `*` and `+` registers aren't even defined
" in terminal vim on Linux
" augroup safecopy
"   autocmd!
"   autocmd TextYankPost * silent! if v:event["regname"] ==# '*' || v:event["regname"] ==# '+' | call system('~/.bin/safecopy -s',join(v:event["regcontents"],"\n")) | end
" augroup END
