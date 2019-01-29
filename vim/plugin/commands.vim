" Also remember `:XtermColorTable`
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

" Make the current buffer a grep buffer
command! GrepBuffer :call commands#GrepBuffer()
command! DisableBackgrounding :call commands#DisableBackgrounding()

" Save & Restore Sessions
command! SessionSaveLocal :mksession! vim_session
command! SessionSave :mksession! ~/.vim/vim_session
command! SessionRestoreLocal :source vim_session
command! SessionRestoreSaved :source ~/.vim/vim_session
command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! QuitSaveSession :call commands#QuitSaveSession()

" Add `git` hunks to `quickfix`
command! Ghunks cexpr system('git diff --relative \| dtg')

" Go to directory vim was launched from
command! Wcd :lcd $PWD

" Delete whitespace at the end of the file
command! DeleteEOFWhitespace :call commands#DeleteEOFWhitespace()

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

" Splits
command! New :call commands#New('new')
command! Vnew :call commands#New('vnew')
command! Tabnew :call commands#New('tabnew')

" Scratch
command! -bang Snew :call commands#Snew(<bang>0, 'new')
command! -bang Svnew :call commands#Snew(<bang>0, 'vnew')
command! -bang Stabnew :call commands#Snew(<bang>0, 'tabnew')

" Lint
command! Lint :call commands#Lint()

" Format
command! Format :call commands#Format()

" Execute
command! Execute :call commands#Execute()
command! -range ExecuteVisual :call commands#ExecuteVisual()

" Run
command! Run :call commands#Run()

" Slug
command! -nargs=1 SlugProject :call commands#SlugProject(<q-args>)
