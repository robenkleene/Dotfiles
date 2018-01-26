if has('gui_running')
  " Use `ctrlp` instead
  finish
endif

nnoremap <leader>b :Buffers<CR>
" nnoremap <localleader>l :BLines<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <M-e> :Files<CR>
nnoremap <leader>c :Cd<CR>
nnoremap <M-c> :Cd<CR>
nnoremap <M-t> :TmuxPaths<CR>
nnoremap <M-z> :Z<CR>
nnoremap <M-v> :Zvim<CR>
nnoremap <leader>r :History<CR>
" nnoremap <leader>c :Modified<CR>
nnoremap <localleader>i :BTags<CR>
nnoremap <leader>i :Tags<CR>
nnoremap <M-i> :Tags<CR>

command! -bang -nargs=? FZFDocumentation lcd ~/Documentation/development-references/|call fzf#vim#files(<q-args>, <bang>0)

" Modified Files
command! Modified :call fzf#run(fzf#wrap({
      \   'source': "git ls-files -m | uniq",
      \   'sink': 'e'
      \ }))

" Note from the `tmux-paths` script: "The front program can change the `pwd`,
" which might result in paths appearing to be missing."
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

command! Zvim :call fzf#run(fzf#wrap({
      \   'source': "fasd -Rfl",
      \   'sink': 'e'
      \ }))

" Support a `TagBuffer` function that opens the current file contents as a
" tag.
command! TagBuffer :call <SID>TagBuffer()
function! s:TagBuffer() abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  let lines = getline(1,'$')
  bdelete
  return s:open_tags(lines)
endfunction
let s:is_win = has('win32') || has('win64')
function! s:escape(path)
  return escape(a:path, ' $%#''"\')
endfunction
function! s:open(cmd, target)
  if stridx('edit', a:cmd) == 0 && fnamemodify(a:target, ':p') ==# expand('%:p')
    return
  endif
  execute a:cmd s:escape(a:target)
endfunction
function! s:open_tags(lines)
  normal! m'
  let qfl = []
  let cmd = 'e'
  try
    let [magic, &magic, wrapscan, &wrapscan, acd, &acd] = [&magic, 0, &wrapscan, 1, &acd, 0]
    for line in a:lines
      try
        let parts   = split(line, '\t\zs')
        let excmd   = matchstr(join(parts[2:-2], '')[:-2], '^.*\ze;"\t')
        let base    = fnamemodify(parts[-1], ':h')
        let relpath = parts[1][:-2]
        let abspath = relpath =~ (s:is_win ? '^[A-Z]:\' : '^/') ? relpath : join([base, relpath], '/')
        call s:open(cmd, expand(abspath, 1))
        execute excmd
        call add(qfl, {'filename': expand('%'), 'lnum': line('.'), 'text': getline('.')})
      catch /^Vim:Interrupt$/
        break
      catch
        call s:warn(v:exception)
      endtry
    endfor
  finally
    let [&magic, &wrapscan, &acd] = [magic, wrapscan, acd]
  endtry
  if len(qfl) > 1
    call setqflist(qfl)
    copen
    wincmd p
    clast
  endif
  normal! zz
endfunction
function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction

