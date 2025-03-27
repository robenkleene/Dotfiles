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
  nnoremap "* :let @"=system('safepaste')<CR>
  inoremap <C-r>* <C-r>=system('safepaste')<CR>
endif

augroup quickfix_height
  autocmd!
  " Set the height to the number of lines, or a fraction of the window height
  " (with a maximum), which ever is higher
  autocmd FileType qf execute min([line("$"), max([10, float2nr(&lines / 3)])]) . "wincmd _"
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
