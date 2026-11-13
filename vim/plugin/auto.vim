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
" `Special` uses the blue from the Ghostty theme (`palette = 4=#5FAFFF`), and
" `ctermfg=4` uses palette 4 directly
highlight Special guifg=#5FAFFF ctermfg=4 guibg=NONE ctermbg=NONE
call auto#HighlightMarkdown()
highlight WarningMsg guifg=#FFFF00 ctermfg=yellow guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
if !has('gui_running')
  " Default to terminal foreground color and background color
  highlight Normal ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE
  " In `lunaperche` `Statement` is white, so remap to `cyan`
  highlight Statement guifg=#8B8680 ctermfg=cyan guibg=NONE ctermbg=NONE cterm=NONE gui=NONE
endif
augroup override_colors
  autocmd!
  autocmd ColorScheme * highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  autocmd ColorScheme * highlight Special guifg=#5FAFFF ctermfg=4 guibg=NONE ctermbg=NONE
  autocmd ColorScheme * call auto#HighlightMarkdown()
  autocmd ColorScheme * highlight WarningMsg guifg=#FFFF00 ctermfg=yellow guibg=NONE ctermbg=NONE cterm=bold gui=bold
  if !has('gui_running')
    autocmd ColorScheme * highlight Normal ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE
  endif
augroup END

" Neovim applies `NormalNC` to inactive windows automatically, Vim has no
" `NormalNC` so the `inactive_windows` group sets `wincolor` instead
call auto#HighlightInactiveWindows()
augroup dim_inactive_windows
  autocmd!
  autocmd ColorScheme * call auto#HighlightInactiveWindows()
  " `OptionSet background` catches `set background` without a `colorscheme`
  autocmd OptionSet background call auto#HighlightInactiveWindows()
  " `OptionSet` doesn't fire during startup, `VimEnter` catches `background`
  " set by files sourced after this one (e.g., `plugin/vim.vim`)
  autocmd VimEnter * call auto#HighlightInactiveWindows()
augroup END
if !has('nvim') && exists('+wincolor')
  augroup inactive_windows
    autocmd!
    autocmd WinEnter,BufWinEnter * setlocal wincolor=
    autocmd WinLeave * setlocal wincolor=NormalNC
    " `VimEnter` dims windows opened at startup (e.g., `vim -o`), which never
    " get a `WinLeave`
    autocmd VimEnter * call map(range(1, winnr('$')), {_, n -> n == winnr() ? 0 : setwinvar(n, '&wincolor', 'NormalNC')})
  augroup END
endif

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
  " - `has('nvim') ? 'system' : 'auto#SystemPipe'`: Neovim's `system()` writes
  "   `{input}` to a pipe, but Vim writes it to a temp file that can be
  "   cleaned up while Vim is running, hence the `auto#SystemPipe()`
  "   workaround
  autocmd TextYankPost * if v:event["regname"] !=# '*' && v:event["regname"] !=# '+' && v:event["operator"] =~# '^[yd]$' && &ft !=# "netrw" | call call(has('nvim') ? 'system' : 'auto#SystemPipe', ['~/.bin/nobin/_rk-tmux-safecopy.sh', join(v:event["regcontents"],"\n")]) | end
augroup END
