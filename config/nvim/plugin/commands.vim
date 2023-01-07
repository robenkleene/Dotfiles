command! Ei :cd ~/Developer/Dotfiles/config/nvim/ | :edit init.lua
command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! GrepBuffer :call commands#GrepBuffer()
command! GrepBufferFromClipboard :call commands#GrepBufferFromClipboard()
command! Pq :GrepBufferFromClipboard
" Files
command! Fnext :call commands#Fnext()
command! Fprev :call commands#Fprev()

command! YankGrep :call commands#YankGrep()
command! YankPath :call commands#YankPath()

command! -nargs=* Rg :call commands#Rg(<q-args>)

cnoreabbrev E Explore
