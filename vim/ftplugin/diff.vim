setlocal foldexpr=getline(v:lnum)=~'^diff'?'>1':getline(v:lnum)=~'^@@'?'>2':'='
setlocal foldmethod=expr
" Allow quickly quitting without saving when piping a diff to vim
" Handled as default for piping now
" setlocal buftype=nofile

" Useful for debugging
" setlocal foldcolumn=3
" Start with folding enabling bindings to navigate folds are available
setlocal foldenable
setlocal foldlevel=2
setlocal readonly nomodifiable

nnoremap <silent> <buffer> gd :OpenDiff<CR>
nnoremap <silent> <buffer> <C-w>d :OpenDiffNew<CR>
nnoremap <silent> <buffer> gyd :YankDiff<CR>

command! YankDiff :call <SID>YankDiff()
function! s:YankDiff() abort
  let l:grep = system('~/.bin/f_fr_diff_to_grep '.line('.').' | tail -n1 | cut -d: -f1,2 | perl -p -e "chomp if eof"', join(getline(1,'$'), "\n"))
  let l:register=v:register
  " Use termporary buffer to force `YankTextPost` to trigger
  echom l:grep
  let @@ = l:grep
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  exe 'silent keepjumps normal! VPgg"'.l:register.'yG'
  bd!
endfunction

command! OpenDiff :call <SID>OpenDiff()
command! OpenDiffNew :split | call <SID>OpenDiff()
function! s:OpenDiff() abort
  let l:grep = system('~/.bin/f_fr_diff_to_grep '.line('.').' | tail -n1 | cut -d: -f1,2', join(getline(1,'$'), "\n"))
  let l:parts = split(l:grep, ':')
  exec "edit " . fnameescape(l:parts[0])
  let l:destlnum = l:parts[1]
  exec l:destlnum
endfunction
