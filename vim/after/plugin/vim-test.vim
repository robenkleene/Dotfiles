" Couldn't get this to work but it should be a start
let g:test#ruby#minitest#file_pattern = 'tc_.*\.rb$'
let test#ruby#bundle_exec = 0

" Populate the `quickfix` list
let test#strategy = 'make'

augroup test_bindings
  autocmd!
  let blacklist = ['markdown']
  " autocmd FileType json,lisp RainbowParentheses
  autocmd FileType * if index(blacklist, &ft) < 0 | nnoremap <silent> <localleader>t :TestNearest<CR>
  autocmd FileType * if index(blacklist, &ft) < 0 | vnoremap <silent> <localleader>t :TestNearest<CR>
augroup END
