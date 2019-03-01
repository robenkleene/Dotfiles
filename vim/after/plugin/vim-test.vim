" Couldn't get this to work but it should be a start
let g:test#ruby#minitest#file_pattern = 'tc_.*\.rb$'
let test#ruby#bundle_exec = 0

nnoremap <silent> <localleader>t :TestNearest<CR>
vnoremap <silent> <localleader>t :TestNearest<CR>
