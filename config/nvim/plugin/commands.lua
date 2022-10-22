vim.cmd([[
command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! GrepBuffer :call commands#GrepBuffer()
command! GrepBufferFromClipboard :call commands#GrepBufferFromClipboard()
command! Cq :GrepBufferFromClipboard
]])
