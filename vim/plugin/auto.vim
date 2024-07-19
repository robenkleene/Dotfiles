" Exclude some buffers from restoring view settings, this prevents certain
" buffers that are meant to be transient from being save and restored when
" loading sessions
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
" `CursorHold` interval in ms, default is `4000`
set updatetime=1000
" This causes a delay when opening the command-line window with `<C-f>`?
" Maybe `set autoread` is enough?
augroup reload_buffers
  autocmd!
  " Oddly, `silent! checktime` doesn't seem to update after a `git checkout
  " <file>` while just `checktime` does. (`silent! checktime` when editing the
  " same file in another `vim` instance though.)
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' && expand('%') !=# '[Command Line]' && getcmdwintype() == '' | checktime | endif
augroup END

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

augroup nofilename_nofile
  autocmd!
  " Don't prompt for saving buffers with no file
  autocmd BufEnter * if eval('@%') == '' && &buftype == '' | setlocal buftype=nofile | end
augroup END

augroup safecopy
  autocmd!
  " Don't exclude the system keyboard in order to match how copying to the
  " tmux pasteboard typically works (which usually also pastes to the system
  " keyboard)
  " In specific, this helps when cutting in Vim to the `t` register and then
  " pasting in Emacs, because the Emacs paste will use `safepaste` which will
  " prioritize the system keyboard, the paste from Vim to Emacs will only work
  " if we copy to the system clipbaord
  "if has('clipboard')
  "  autocmd TextYankPost * silent! if v:event["regname"] ==# '*' || v:event["regname"] ==# '+'  | call system('~/.bin/safecopy',join(v:event["regcontents"],"\n")) | end
  "else
  "  autocmd TextYankPost * silent! if v:event["regname"] ==# '' || v:event["regname"] ==# '"' | call system('~/.bin/safecopy',join(v:event["regcontents"],"\n")) | end
  "endif
  " nvim has builtin support for a custom clipboard command
  autocmd TextYankPost * silent!
        \if !has('nvim') && v:event["regname"] ==# '*' 
        \|| v:event["regname"] ==# '+' 
        \| call system('~/.bin/safecopy -s',join(v:event["regcontents"],"\n"))
        \| end
  " Use this to always sync the vim yank with the system clipboard, this
  " approach has less side effects than `set clipboard` Only copy to system
  " clipboard on yank events (`v:event["operator"] ==# 'y') because otherwise,
  " since `"*p` with a visual selection first yanks and then pastes, it will
  " cause pasting over a visual selection to be a no-op
  "autocmd TextYankPost * silent!
  "      \if v:event["operator"] ==# 'y'
  "      \&& v:event["regname"] ==# ''
  "      \|| v:event["regname"] ==# '"'
  "      \| call system('~/.bin/safecopy',join(v:event["regcontents"],"\n"))
  "      \| end
augroup END

augroup quickfix_height
  autocmd!
  " Set the height to the number of lines, with a max of the size of the window, or 10, which ever is higher
  autocmd FileType qf execute min([line("$"), max([10, float2nr(&lines / 3)])]) . "wincmd _"
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END

augroup z_add
  autocmd!
  " netrw
  autocmd Filetype netrw call system('zoxide add '.shellescape(expand('%')))
  " Regular `cd` or `lcd`
  autocmd DirChanged * call system('zoxide add ' . expand('<amatch>'))
augroup END

" Automatically close the completion preview
augroup completion_preview
  autocmd!
  autocmd CompleteDone * pclose
augroup END

" Remove commit files from `v:oldfiles` (note this doesn't touch the edited
" files on disk, it filters the list when vim launches)
" Don't like that this might affect startup time
"augroup clean_oldfiles
"  autocmd!
"  autocmd VimEnter * call filter(v:oldfiles, 'v:val !~# "COMMIT_EDITMSG$" && v:val !~# "hg-editor-.*$"')
"augroup END
