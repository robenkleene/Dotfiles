command! GrepBuffer :call commands#GrepBuffer()
command! Gb :GrepBuffer
command! GrepBufferFromClipboard :call commands#GrepBufferFromClipboard()
command! Pq :GrepBufferFromClipboard

command! YankGrep :call commands#YankGrep()

command! -nargs=+ Rg :call commands#Rg(<q-args>)
command! -nargs=1 Z :call commands#Z(<q-args>)
