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
if !has('gui_running')
  highlight Normal ctermbg=NONE guibg=NONE
endif
augroup override_colors
  autocmd!
  autocmd ColorScheme * highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  if !has('gui_running')
    autocmd ColorScheme * highlight Normal ctermbg=NONE
  endif
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END

augroup safecopy
  autocmd!
  " Two cases to watch out for:
  " - A visual selection (e.g., `v`) then system clipboard paste (`"*p`) can
  "   break because the changed text can overwrite the clipboard making the
  "   paste just replace with the exact same text. This can be avoided by not
  "   copying if the yanked register is already the system register.
  " - A change (e.g., `c`) can be copy to the system clipboard, so `c` then
  "   `⌘V` to paste will paste the same text. This can be avoided by ommitting
  "   the `c` event.
  " - `&ft !=# "netrw"`: Always exclude `netrw` which has a habit of
  "   overwriting registers
  autocmd TextYankPost * if v:event["regname"] !=# '*' && v:event["regname"] !=# '+' && v:event["operator"] =~# '^[yd]$' && &ft !=# "netrw" | call system('~/.bin/nobin/_safecopy.sh',join(v:event["regcontents"],"\n")) | end
augroup END
