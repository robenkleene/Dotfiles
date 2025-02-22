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

augroup auto_insert
  autocmd!
  " Toggle off `list` so white space isn't visible in insert mode
  " Toggle off `ignorecase` because case sensitivity is shared between search
  " and completion, we want search to be case insensitive, and completion to
  " be case sensitive
  " Disabling ignorecase because it's off by default now and this overwrites
  " that
  "autocmd InsertEnter * setlocal nolist | setlocal noignorecase
  "autocmd InsertLeave * setlocal list | setlocal ignorecase
  autocmd InsertEnter * setlocal nolist
  autocmd InsertLeave * setlocal list
augroup END

" This is necessary because Vim does not have a command to write all modified
" files that are backed by buffers and force quit modified buffers that aren't
" backed by files (e.g., what you'd think `:wqa` with a bang would do, but it
" doesn't support a bang).
augroup nofilename_nofile
  autocmd!
  " Don't prompt for saving buffers with no file
  autocmd BufEnter * if eval('@%') == '' && &buftype == '' | setlocal buftype=nofile | end
augroup END

" The `*` register for the system clipboard isn't available in SSH, so as a
" workaround use `safecopy` on every yank
" Don't wrap this in `!has('clipboard')` because that will create different
" behavior for whether a SSH is active or not, which isn't desirable
" Actually we're putting this back, if clipboard is not active, it will just
" show a message on yank if prefixed with `"*`, which isn't a big deal
if has('clipboard')
  " If the `*` register is available then also copy the register contents to
  " the `tmux` buffer.
  " Add `if getenv('TMUX') && (` (and add the closing `)` around the `||`) to
  " the beginning of the `if` to only execute if `tmux` is available.
  augroup safecopy_yank
    autocmd!
    autocmd TextYankPost * if v:event["regname"] ==# '*' || v:event["regname"] ==# '+' | call system('~/.bin/safecopy -s',join(v:event["regcontents"],"\n")) | end
  augroup END
else
  augroup safecopy_yank
    autocmd!
    " We can't add delete (`v:event["operator"] ==# 'd'`) because then doing a
    " visual selection (e.g., `v`) then system clipboard paste (`"*p`) will
    " first delete the visual selection then paste, which means the visual
    " selection will overwrite the clipboard
    autocmd TextYankPost * if v:event["regname"] !=# '*' && v:event["regname"] !=# '+' && v:event["operator"] ==# 'y' | call system('~/.bin/safecopy -s',join(v:event["regcontents"],"\n")) | end
  augroup END
endif

augroup quickfix_height
  autocmd!
  " Set the height to the number of lines, or a fraction of the window height
  " (with a maximum), which ever is higher
  autocmd FileType qf execute min([line("$"), max([10, float2nr(&lines / 3)])]) . "wincmd _"
augroup END

" Automatically close the completion preview
augroup completion_preview
  autocmd!
  autocmd CompleteDone * pclose
augroup END

" Remove commit files from `v:oldfiles` (note this doesn't touch the edited
" files on disk, it filters the list when vim launches)
" Don't like that this might affect startup time
" Removing this because it might affect startup time
"augroup clean_oldfiles
"  autocmd!
"  autocmd VimEnter * call filter(v:oldfiles, 'v:val !~# "COMMIT_EDITMSG$" && v:val !~# ".*\.hg\.txt$"')
"augroup END

highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
highlight Normal ctermbg=NONE guibg=NONE
augroup override_colors
  autocmd!
  autocmd ColorScheme * highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END
