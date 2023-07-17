command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! Sr :SessionRestoreAuto
command! GrepBuffer :call commands#GrepBuffer()
command! Gb :call commands#GrepBuffer()
command! GrepBufferFromClipboard :call commands#GrepBufferFromClipboard()
command! Pq :GrepBufferFromClipboard
" Files
command! Fnext :call commands#Fnext()
command! Fprev :call commands#Fprev()

command! YankGrep :call commands#YankGrep()
command! YankPath :call commands#YankPath()
command! YankFilename :call commands#YankFilename()

command! -nargs=* Rg :call commands#Rg(<q-args>)
command! Cpaste :let @0=substitute(@0, '\n\+$', '', '') | :norm "0p
command! Cwise :let @0=substitute(@0, '\n\+$', '', '')
