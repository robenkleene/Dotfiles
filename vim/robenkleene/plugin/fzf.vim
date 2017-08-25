set rtp+=~/.fzf

nnoremap <leader>b :Buffers<CR>
nnoremap <localleader>l :BLines<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <M-e> :Files<CR>
nnoremap <leader>c :Cd<CR>
nnoremap <M-c> :Cd<CR>
nnoremap <M-t> :TmuxPaths<CR>
nnoremap <M-z> :Z<CR>
nnoremap <leader>r :History<CR>
" nnoremap <leader>c :Modified<CR>
nnoremap <localleader>i :BTags<CR>
nnoremap <leader>i :Tags<CR>

command! -bang -nargs=? FZFDocumentation lcd ~/Documentation/development-references/|call fzf#vim#files(<q-args>, <bang>0)

" Modified Files
command! Modified :call fzf#run(fzf#wrap({
      \   'source': "git ls-files -m | uniq",
      \   'sink': 'e'
      \ }))

command! TmuxPaths :call fzf#run(fzf#wrap({
      \   'source':  "tmux-paths",
      \   'sink': function('<SID>cd_sink')
      \ }))

function! s:cd_sink(e) abort
  execute 'Explore' a:e
  let l:path = expand('%')
  if !empty(l:path)
    " This should be an `lcd` but that doesn't work reliably
    cd %
  endif
endfunction

command! Cd :call fzf#run(fzf#wrap({
      \   'source': "cmd=\"${FZF_ALT_C_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type d -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':   'Explore'
      \ }))

command! Z :call fzf#run(fzf#wrap({
      \   'source': "fasd -Rdl",
      \   'sink': function('<SID>cd_sink')
      \ }))
