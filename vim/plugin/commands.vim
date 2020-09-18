" Also remember `:XtermColorTable`
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

" Make the current buffer a grep buffer
command! GrepBuffer :call commands#GrepBuffer()
command! ScratchBuffer :call commands#ScratchBuffer()
command! DisableBackgrounding :call commands#DisableBackgrounding()

" Save & Restore Sessions
command! SessionSaveLocal :mksession! vim_session
command! SessionSave :mksession! ~/.vim/vim_session
command! SessionRestoreLocal :source vim_session
command! SessionRestoreSaved :source ~/.vim/vim_session
command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! QuitSaveSession :call commands#QuitSaveSession()
command! SessionNoAuto :autocmd! save_session

" Add `git` hunks to `quickfix`
command! Ghunks cexpr system('git diff --relative \| dtg')

" Edit README
command! Erm :e README.md
command! Ermg :call commands#Cdg('lcd')|:e README.md

" Delete whitespace at the end of the file
command! DeleteEOFWhitespace :call commands#DeleteEOFWhitespace()

" Go to working directory
" Go to directory vim was launched from
" command! Cdw :lcd $PWD
" command! Cdw :call commands#Cdw('cd')
" command! Wlcd :call commands#Cdw('lcd')

" `rg`
command! -nargs=* Rg :call commands#Rg(<q-args>)
command! -nargs=* Rgg :call commands#Rgg(<q-args>)
command! -nargs=* Qa :call commands#Qa(<q-args>)

" `rg` & `tmux`
command! -nargs=* Atm :call commands#Atm(<q-args>)

" Yank
command! YankFileName :let @" = expand("%")|:let @+ = @"|:echo @"
command! YankFilePath :let @" = expand("%:p")|:let @+ = @"|:echo @"
command! YankDirectoryPath :let @" = expand("%:p:h")|:let @+ = @"|:echo @"

" Splits
command! NewFileType :call commands#NewFileType('new')
command! VnewFileType :call commands#NewFileType('vnew')
command! TabnewFileType :call commands#NewFileType('tabnew')

" Scratch
command! -range=% -bang EditScratch :call commands#NewScratch(<bang>0, 'edit', <line1>, <line2>)
command! -range=% -bang NewScratch :call commands#NewScratch(<bang>0, 'new', <line1>, <line2>)
command! -range=% -bang VnewScratch :call commands#NewScratch(<bang>0, 'vnew', <line1>, <line2>)
command! -range=% -bang TabnewScratch :call commands#NewScratch(<bang>0, 'tabnew', <line1>, <line2>)

" Register
command! -nargs=1 NewRegister :call commands#NewRegister(<q-args>, 'new')
command! -nargs=1 VnewRegister :call commands#NewRegister(<q-args>, 'vnew')
command! -nargs=1 TabnewRegister :call commands#NewRegister(<q-args>, 'tabnew')

" Write Register
command! -nargs=1 WriteRegister :call commands#WriteRegister(<q-args>)

" Markdown
command! RenameFileFromTitle :call commands#RenameFileFromTitle()

" Blog
command! -nargs=1 BlogNewPost :call commands#BlogNewPost(<q-args>, '')
command! -nargs=1 BlogNewLink :call commands#BlogNewPost(<q-args>, '-l')
command! BlogNewPostWithFile :call commands#BlogNewPostWithFile('')
command! BlogNewLinkWithFile :call commands#BlogNewPostWithFile('-l')

" Journal
command! Journal :e ~/Text/journal/README.md

" Inbox
command! -nargs=? Inbox :call commands#Inbox(<args>)

" Archive
command! Archive :call commands#Archive()

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
command! SlugProjectArchive :call commands#SlugProjectArchive()

" Tags
command! Tags :call commands#Tags()

" Profile
command! ProfileStart :call commands#ProfileStart()
command! ProfileEnd :call commands#ProfileEnd()

" Source Control
command! SourceControlWeb :call commands#SourceControlWeb()

" Quit
command! QuitIfNoBuffers :call commands#QuitIfNoBuffers()
