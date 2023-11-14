command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! Sr :SessionRestoreAuto
command! GrepBuffer :call commands#GrepBuffer()
command! Gb :GrepBuffer
command! GrepBufferFromClipboard :call commands#GrepBufferFromClipboard()
command! Pq :GrepBufferFromClipboard

command! -nargs=+ Rg :call commands#Rg(<q-args>)
command! -nargs=+ Fd :call commands#Fd(<q-args>)
command! -nargs=+ Z :call commands#Z(<q-args>)
command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
