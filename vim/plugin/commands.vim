" Also remember `:XtermColorTable`
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

" Make the current buffer a grep buffer
command! GrepBuffer :call commands#GrepBuffer()

" Save & Restore Sessions
command! SessionSaveLocal :mksession! vim_session
command! SessionSave :mksession! ~/.vim/vim_session
command! SessionRestoreLocal :source vim_session
command! SessionRestore :source ~/.vim/vim_session
command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! QuitSaveSession :call commands#QuitSaveSession()
" Terminal Commands
" if exists(':terminal')
"   command! Doc call commands#Doc()
"   function! s:Doc() abort
"     split
"     execute 'terminal doc'
"     tnoremap <buffer> <Esc> <C-\><C-n>
"   endfunction
" endif

" Add `git` hunks to `quickfix`
command! Ghunks cexpr system('git diff --relative \| dtg')

" Go to directory vim was launched from
command! Wcd :lcd $PWD

" Go to `git` root
command! Gcd :call commands#Gcd()
" `rg`
command! -nargs=* Rg :call commands#Rg(<q-args>)

" `rg` & `tmux`
command! -nargs=* Atm :call commands#Atm(<q-args>)

" Yank
command! YankFileName :let @" = expand("%")|:let @+ = @"|:echo @"
command! YankFilePath :let @" = expand("%:p")|:let @+ = @"|:echo @"
command! YankDirectoryPath :let @" = expand("%:p:h")|:let @+ = @"|:echo @"
