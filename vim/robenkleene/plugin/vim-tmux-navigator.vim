let g:tmux_navigator_no_mappings = 1

" Hack to fix meta keys
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "nnoremap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw

noremap <silent> <A-h> :TmuxNavigateLeft<cr>
noremap <silent> <A-j> :TmuxNavigateDown<cr>
noremap <silent> <A-k> :TmuxNavigateUp<cr>
noremap <silent> <A-l> :TmuxNavigateRight<cr>

noremap <silent> <S-Left> :TmuxNavigateLeft<cr>
noremap <silent> <S-Down> :TmuxNavigateDown<cr>
noremap <silent> <S-Up> :TmuxNavigateUp<cr>
noremap <silent> <S-Right> :TmuxNavigateRight<cr>
