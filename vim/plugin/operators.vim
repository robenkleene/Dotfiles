nnoremap <expr> gC operators#ConflictDiff()
xnoremap <expr> gC operators#ConflictDiff()
nnoremap gCC <Cmd>call operators#ConflictDiffLine()<CR>
nnoremap gCc <Cmd>call operators#ConflictDiffClose()<CR>
command! ConflictClose call operators#ConflictDiffClose()
