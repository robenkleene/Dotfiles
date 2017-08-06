set rtp+=~/.fzf

" rg
" nnoremap <leader>* :Rgf <C-r><C-w><cr>
" vnoremap <leader>* :<C-u>call <SID>RgfVisual()<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <localleader>l :BLines<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <M-e> :Files<CR>
nnoremap <leader>c :Cd<CR>
nnoremap <M-c> :Cd<CR>
nnoremap <leader>r :History<CR>
" nnoremap <leader>c :Modified<CR>
nnoremap <localleader>i :BTags<CR>
nnoremap <leader>i :Tags<CR>

command! FZFDocumentation :call <SID>FZFDocumentation()
function! s:FZFDocumentation() abort
  lcd ~/Documentation/development-references/
  call fzf#run({
        \   'source':  "rg --column --smart-case --line-number --no-heading --color=always",
        \   'sink':    'e'
        \ })
endfunction

" Modified Files
command! Modified :call fzf#run({
      \   'source':  "git ls-files -m | uniq",
      \   'sink':    'e'
      \ })

command! TmuxPaths :call fzf#run({
      \   'source':  "tmux-paths",
      \   'sink':    'e'
      \ })

command! Cd :call fzf#run({
      \   'source':  "cmd=\"${FZF_ALT_C_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type d -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':    'Explore'
      \ })
